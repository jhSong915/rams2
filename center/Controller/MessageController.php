<?php
include_once $_SERVER['DOCUMENT_ROOT'] . "/center/Controller/Controller.php";
include_once $_SERVER['DOCUMENT_ROOT'] . "/center/Model/Message.php";

class MessageController extends Controller
{
    private $messageInfo;

    function __construct()
    {
        $this->messageInfo = new MessageInfo();
    }

    public function msgListLoad($request)
    {
        $franchise_idx = !empty($request['center_idx']) ? $request['center_idx'] : '';
        $user_idx = !empty($request['user_idx']) ? $request['user_idx'] : '';
        $months = !empty($request['months']) ? $request['months'] : '';

        try {
            if (empty($franchise_idx) || empty($months)) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }
            $this->syncMsgServer($franchise_idx, $months);
            $result = $this->messageInfo->msgListLoad($franchise_idx, $user_idx, $months);
            if (!empty($result)) {
                foreach ($result as $key => $val) {
                    $result[$key]['no'] = $key + 1;
                    $result[$key]['to_no'] = $val['to_no'] . "<br>(" . $val['to_name'] . ")";
                    if (!empty($val['rev_datetime']) && $val['msg_state'] == '' && (date("Y-m-d H:i:s", strtotime($val['rev_datetime'])) > date('Y-m-d H:i:s'))) {
                        $result[$key]['regchk'] = "<input type=\"checkbox\" class=\"form-check-input revchk\" value=\"{$val['msg_idx']}\" />";
                        $result[$key]['revdelbtn'] = "<button type=\"button\" class=\"btn btn-sm btn-outline-danger revdelbtn\">예약취소</button>";
                    } else {
                        $result[$key]['regchk'] = "";
                        $result[$key]['revdelbtn'] = "";
                    }
                }
            } else {
                throw new Exception('발송하신 문자메시지 내역이 없습니다.', 701);
            }
            return $result;
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }

    public function msgContentLoad($request)
    {
        $msg_idx = !empty($request['msg_idx']) ? $request['msg_idx'] : '';
        try {
            if (empty($msg_idx)) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }
            $result = $this->messageInfo->msgContentLoad($msg_idx);
            if (empty($result)) {
                throw new Exception('발송하신 문자메시지 내역이 없습니다.', 701);
            }
            return $result;
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }

    public function msgListDelete($request)
    {
        $msg_idx = !empty($request['msg_idx']) ? $request['msg_idx'] : '';
        $msg_seq = !empty($request['msg_seq']) ? $request['msg_seq'] : '';
        $franchise_idx = !empty($request['center_idx']) ? $request['center_idx'] : '';

        try {
            if (empty($msg_idx) || empty($msg_seq)) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }
            $data = array(
                'action' => "deleteRevMsg",
                'msg_seq' => $msg_seq
            );
            $result = $this->curlExec($data);

            if (!empty($result)) {
                $sql2 = "SELECT M.msgType, count(M.msgType) AS msg_type_cnt FROM messageT M WHERE M.msg_idx IN ({$msg_idx}) GROUP BY M.msgType";
                $sql3 = "SELECT sms_fee, lms_fee, mms_fee FROM franchiseM WHERE franchise_idx = '{$franchise_idx}' AND useYn = 'Y'";
                $result2 = $this->messageInfo->db->sqlRowArr($sql2);
                $result3 = $this->messageInfo->db->sqlRow($sql3);
                if (!empty($result2)) {
                    $s_cnt = 0; // sms 환불 금액
                    $l_cnt = 0; // lms 환불 금액
                    $m_cnt = 0; // mms 환불 금액
                    foreach ($result2 as $key => $val) {
                        if ($val['msgType'] == 's') {
                            $s_cnt = $val['msg_type_cnt'] * $result3['sms_fee'];
                        } else if ($val['msgType'] == 'l') {
                            $l_cnt = $val['msg_type_cnt'] * $result3['lms_fee'];
                        } else if ($val['msgType'] == 'm') {
                            $m_cnt = $val['msg_type_cnt'] * $result3['mms_fee'];
                        }
                    }
                    $sql = "UPDATE franchiseM SET point = point + " . ($s_cnt + $l_cnt + $m_cnt) . ", mod_date = getdate() WHERE franchise_idx = '{$franchise_idx}'";
                    $result4 = $this->messageInfo->db->execute($sql);
                    $sql = "UPDATE {$this->messageInfo->table_name} SET msg_state = '99' WHERE msg_idx IN ({$msg_idx})";
                    $result5 = $this->messageInfo->db->execute($sql);
                    $return_data['msg'] = "선택하신 문자메시지가 예약취소되었습니다. (" . ($s_cnt + $l_cnt + $m_cnt) . " 원이 환불되었습니다.)";
                } else {
                    throw new Exception('선택하신 문자메시지 예약취소에 실패했습니다.', 701);
                }
            }
            return $return_data;
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }

    public function msgListDelete2($request)
    {
        $msg_idx = !empty($request['msg_idx']) ? $request['msg_idx'] : '';
        $msg_seq = !empty($request['msg_seq']) ? $request['msg_seq'] : '';
        $franchise_idx = !empty($request['center_idx']) ? $request['center_idx'] : '';

        try {
            if (empty($msg_idx) || empty($msg_seq)) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }
            $msg_idxs = implode(",", $msg_idx);
            $msg_seqs = implode(",", $msg_seq);
            $data = array(
                'action' => "deleteRevMsg",
                'msg_seq' => $msg_seqs
            );
            $result = $this->curlExec($data);
            if (!empty($result)) {
                $sql2 = "SELECT M.msgType, count(M.msgType) AS msg_type_cnt FROM messageT M WHERE M.msg_idx IN ({$msg_idxs}) GROUP BY M.msgType";
                $sql3 = "SELECT sms_fee, lms_fee, mms_fee FROM franchiseM WHERE franchise_idx = '{$franchise_idx}' AND useYn = 'Y'";
                $result2 = $this->messageInfo->db->sqlRowArr($sql2);
                $result3 = $this->messageInfo->db->sqlRow($sql3);
                if (!empty($result2)) {
                    $s_cnt = 0; // sms 환불 금액
                    $l_cnt = 0; // lms 환불 금액
                    $m_cnt = 0; // mms 환불 금액
                    foreach ($result2 as $key => $val) {
                        if ($val['msgType'] == 's') {
                            $s_cnt = $val['msg_type_cnt'] * $result3['sms_fee'];
                        } else if ($val['msgType'] == 'l') {
                            $l_cnt = $val['msg_type_cnt'] * $result3['lms_fee'];
                        } else if ($val['msgType'] == 'm') {
                            $m_cnt = $val['msg_type_cnt'] * $result3['mms_fee'];
                        }
                    }
                    $sql = "UPDATE franchiseM SET point = point + " . ($s_cnt + $l_cnt + $m_cnt) . ", mod_date = getdate() WHERE franchise_idx = '{$franchise_idx}'";
                    $result4 = $this->messageInfo->db->execute($sql);
                    $sql = "UPDATE {$this->messageInfo->table_name} SET msg_state = '99' WHERE msg_idx IN ({$msg_idxs})";
                    $result5 = $this->messageInfo->db->execute($sql);
                    $return_data['msg'] = "선택하신 문자메시지가 예약취소되었습니다. (" . ($s_cnt + $l_cnt + $m_cnt) . " 원이 환불되었습니다.)";
                } else {
                    throw new Exception('선택하신 문자메시지 예약취소에 실패했습니다.', 701);
                }
            }
            return $return_data;
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }

    public function syncMsgServer($franchise_idx, $month)
    {
        $months = !empty($month) ? $month : '';
        $center_idx = !empty($franchise_idx) ? $franchise_idx : '';

        try {
            if (empty($months) || empty($center_idx)) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }
            $result = $this->messageInfo->getMsgSeq($center_idx);
            if (empty($result)) {
                $return_data['msg'] = "문자메시지 발송내역이 동기화할 항목이 없습니다.";
                return $return_data;
            }
            $msg_seq = "";
            foreach ($result as $key => $val) {
                $msg_seq = $val['msg_seq'];
                $data = array(
                    'action' => "getMessageState",
                    'msg_seq' => $msg_seq,
                    'month' => $months,
                );
                $result2 = $this->curlExec($data);
                if (empty($result2)) {
                    return;
                }
                $msg_state = !empty($result2['data']['state']) ? $result2['data']['state'] : '';
                $msg_sent_date = !empty($result2['data']['sent_date']) ? $result2['data']['sent_date'] : '';
                if (empty($msg_state) || empty($msg_sent_date)) {
                    return;
                }
                $sql = "UPDATE messageT SET msg_state = '{$msg_state}', send_date = '{$msg_sent_date}', syncYn = 'Y' WHERE msg_seq = '{$msg_seq}' AND franchise_idx = '{$center_idx}'";

                $result3 = $this->messageInfo->db->execute($sql);
            }

            $return_data['msg'] = "문자메시지 발송내역이 동기화되었습니다.";
            return $return_data;
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }

    public function curlExec($request)
    {
        $data = !empty($request) ? $request : '';

        try {
            if (empty($data)) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }
            $header_data = array(
                'Content-Type: application/x-www-form-urlencoded; charset=utf-8'
            );

            $url = "https://rams.readingm.com/tst/message.aspx";
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_HEADER, false);
            curl_setopt($ch, CURLOPT_HTTPHEADER, $header_data);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
            curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 10);
            curl_setopt($ch, CURLOPT_TIMEOUT, 10);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
            curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($request));
            curl_setopt($ch, CURLOPT_POST, true);

            $response = curl_exec($ch);
            curl_close($ch);

            $result = explode("|", $response);
            $return_data = array();
            foreach ($result as $key => $val) {
                if ($key == 1) {
                    $return_data['success'] = $val;
                } else if ($key == count($result) - 1) {
                    $return_data['msg'] = $val;
                } else if (($key + 1) % 2 == 0) {
                    if (strpos($val, "$")) {
                        $data_arr = explode("$", $val);
                        foreach ($data_arr as $key2 => $val2) {
                            if (($key2 + 1) % 2 == 1) {
                                $key_name = $val2;
                            }
                            if (($key2 + 1) % 2 == 0) {
                                $return_data['data'][$key_name] = $val2;
                            }
                        }
                    } else {
                        $return_data['data'] .= $val;
                    }
                }
            }
            return $return_data;
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }
}

$messageController = new MessageController();
