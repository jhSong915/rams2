<?php
include_once $_SERVER['DOCUMENT_ROOT'] . "/center/Controller/Controller.php";
include_once $_SERVER['DOCUMENT_ROOT'] . "/center/Model/SaveMessage.php";
include_once $_SERVER['DOCUMENT_ROOT'] . "/common/function.php";
include_once $_SERVER['DOCUMENT_ROOT'] . "/common/ftpClass.info.php";

class SaveMessageController extends Controller
{
    private $saveMessageInfo;

    function __construct()
    {
        $this->saveMessageInfo = new SaveMessageInfo();
    }

    public function msgAttachFileUpload($request)
    {
        $center_idx = !empty($request['center_idx']) ? $request['center_idx'] : '';
        try {
            if (empty($center_idx)) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }

            $ftp_server = FTP_HOST;
            $ftp_port = FTP_PORT;
            $ftp_id = FTP_ID;
            $ftp_pw = FTP_PASS;

            if (!empty($_FILES['attachImg'])) {
                $nameArr = explode(".", $_FILES['attachImg']['name']);
                $extension = end($nameArr);
                $file_name = 'attach_' . date("YmdHis") . "." . $extension;

                $path = $_SERVER['DOCUMENT_ROOT'] . "/files/msg_file/" . $center_idx . "/";
                if (!is_dir($path)) {
                    $dir = mkdir($path, 775);
                }
                copy($_FILES['attachImg']['tmp_name'], $path . $file_name);
                $return_data['fileNm'] = $file_name;
                $return_data['up_path1'] = "/files/msg_file/" . $center_idx . "/" . $file_name;
            } else {
                throw new Exception('파일 업로드에 실패했습니다.(1)', 701);
            }

            $conn_id = ftp_connect($ftp_server, $ftp_port);
            if ($conn_id == false) {
                throw new Exception('서버 연결에 실패했습니다.(1)', 701);
            }
            $login_result = ftp_login($conn_id, $ftp_id, $ftp_pw);
            if ($login_result == false) {
                throw new Exception('서버 연결에 실패했습니다.(2)', 701);
            }
            $localfile = $_FILES['attachImg']['tmp_name'];
            $server_file =  $file_name;
            ftp_pasv($conn_id, true);
            ftp_chdir($conn_id, "/upload/mms/rams2/");
            if (ftp_put($conn_id, $server_file, $localfile, FTP_BINARY)) {
                $return_data['up_path2'] = "/upload/mms/rams2/" . $file_name;
            } else {
                throw new Exception('파일 업로드에 실패했습니다.(2)', 701);
            }

            return $return_data;
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }

    public function sendMsg($request)
    {
        $center_idx = !empty($request['center_idx']) ? $request['center_idx'] : '';
        $user_idx = !empty($request['user_idx']) ? $request['user_idx'] : '';
        $user_phone = !empty($request['user_phone']) ? $request['user_phone'] : '';
        $chkCenterNum = !empty($request['chkCenterNum']) ? $request['chkCenterNum'] : '';
        $msgcontents = !empty($request['msgcontents']) ? $request['msgcontents'] : '';
        $lists = !empty($request['lists']) ? $request['lists'] : '';
        $revdt = !empty($request['revdt']) ? $request['revdt'] : '';
        $msgType = !empty($request['msgType']) ? $request['msgType'] : '';
        $fileNm = !empty($request['FileNm']) ? $request['FileNm'] : '';
        $path1 = !empty($request['path1']) ? $request['path1'] : '';
        $path2 = !empty($request['path2']) ? $request['path2'] : '';

        try {
            if (empty($center_idx) || empty($user_idx) || empty($msgcontents) || empty($lists) || empty($msgType)) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }
            $sql = "SELECT tel_num, point, sms_fee, lms_fee, mms_fee FROM franchiseM WHERE franchise_idx = '{$center_idx}'";
            $cnt = count($lists);
            $result2 = $this->saveMessageInfo->db->sqlRow($sql);
            $leave_point = $result2['point'];
            if ($msgType == 's') {
                $fee = $result2['sms_fee'];
            } else if ($msgType == 'l') {
                $fee = $result2['lms_fee'];
            } else if ($msgType == 'm') {
                $fee = $result2['mms_fee'];
            }
            if ($chkCenterNum == 'Y') {
                $user_phone = $result2['tel_num'];
            }
            if ($leave_point < ($cnt * $fee)) {
                throw new Exception('램스 포인트가 부족합니다. 충전 후 이용하시기 바랍니다.', 701);
            }
            $sql = "";
            $sql2 = "";
            foreach ($lists as $key => $val) {
                $sql = "SELECT user_name FROM member_studentM WHERE franchise_idx = '{$center_idx}' AND user_phone = '" . phoneFormat($lists[$key][1], true) . "'";
                $db_user_name = $this->saveMessageInfo->db->sqlRowOne($sql);
                $msg_replace_contents = $msgcontents;
                if (strpos($msgcontents, "[이름]") !== false) {
                    if ($db_user_name) {
                        $user_name = mb_substr($db_user_name, 1);
                    } else {
                        $user_name = mb_substr($lists[$key][0], 1);
                    }
                    $msg_replace_contents = str_replace("[이름]", $user_name, $msg_replace_contents);
                }
                if (strpos($msgcontents, "[이름이]") !== false) {
                    if ($db_user_name) {
                        $user_name = mb_substr($db_user_name, 1) . "이";
                    } else {
                        $user_name = mb_substr($lists[$key][0], 1) . "이";
                    }
                    $msg_replace_contents = str_replace("[이름이]", $user_name, $msg_replace_contents);
                }
                $sql = "";
                $data = array(
                    "action" => "sendMsg",
                    "fileNm" => !empty($fileNm) ? $fileNm : null,
                    "from_no" => $user_phone,
                    "to_no" => str_replace('-', '', $lists[$key][1]),
                    "msg_contents" => $msg_replace_contents,
                    "revdt" => !empty($revdt) ? date("Y-m-d H:i:s", strtotime($revdt)) : null,
                );

                $send = $this->curlExec($data);
                if (empty($send)) {
                    throw new Exception('문자메시지 전송 중 오류가 발생했습니다. (1)', 701);
                }
                $sql2 .= "INSERT INTO messageT (
                    franchise_idx
                    ,send_user_idx
                    ,from_no
                    ,to_name
                    ,to_no
                    ,msg_contents
                    ,file_nm
                    ,file_path1
                    ,file_path2
                    ,msgType
                    ,msg_state
                    ,rev_datetime
                    ,cont_seq
                    ,msg_seq
                ) VALUES (
                    '{$center_idx}', 
                    '{$user_idx}', 
                    '{$user_phone}', 
                    '" . $lists[$key][0] . "', 
                    '" . str_replace('-', '', $lists[$key][1]) . "', 
                    '{$msg_replace_contents}', 
                    '{$fileNm}', 
                    '{$path1}', 
                    '{$path2}', 
                    '{$msgType}', 
                    '', 
                    '" . (!empty($revdt) ? date("Y-m-d H:i:s", strtotime($revdt)) : '') . "',
                    '" . $send['data']['cont_seq'] . "',
                    '" . $send['data']['msg_seq'] . "') ";
            }
            $result = $this->saveMessageInfo->db->execute($sql2);
            if ($result) {
                $return_data['msg'] = '문자메시지 전송되었습니다.';
            } else {
                throw new Exception('문자메시지 전송 중 오류가 발생했습니다. (2)', 701);
            }

            $sql = "UPDATE franchiseM SET point = point - (" . ($fee * $cnt) . ") WHERE franchise_idx = '{$center_idx}'";
            $result = $this->saveMessageInfo->db->execute($sql);

            return $return_data;
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }

    public function saveMsgLoad($request)
    {
        $franchise_idx  = !empty($request['center_idx']) ? $request['center_idx'] : '';
        $user_idx = !empty($request['user_idx']) ? $request['user_idx'] : '';
        try {
            if (empty($franchise_idx) || empty($user_idx)) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }
            $result = $this->saveMessageInfo->saveMsgLoad($franchise_idx, $user_idx);
            $opt = "<option value=\"\">선택</option>";
            if (!empty($result)) {
                foreach ($result as $key => $val) {
                    $opt .= "<option value=\"" . $val['msg_idx'] . "\">" . $val['msg_title'] . "</option>";
                }
            }
            $result['opt'] = $opt;

            return $result;
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }

    public function saveMsgSelect($request)
    {
        $msg_idx  = !empty($request['msg_idx']) ? $request['msg_idx'] : '';
        $franchise_idx  = !empty($request['center_idx']) ? $request['center_idx'] : '';
        $user_idx = !empty($request['user_idx']) ? $request['user_idx'] : '';
        try {
            if (empty($msg_idx) || empty($franchise_idx) || empty($user_idx)) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }
            $result = $this->saveMessageInfo->saveMsgSelect($msg_idx, $franchise_idx, $user_idx);

            return $result;
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }

    public function saveMsgInsert($request)
    {
        $franchise_idx  = !empty($request['center_idx']) ? $request['center_idx'] : '';
        $user_idx = !empty($request['user_idx']) ? $request['user_idx'] : '';
        $msgtitle = !empty($request['msgtitle']) ? $request['msgtitle'] : '';
        $msgcontents = !empty($request['msgcontents']) ? $request['msgcontents'] : '';

        try {
            if (empty($franchise_idx) || empty($user_idx) || empty($msgtitle) || empty($msgcontents)) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }

            $params = array(
                "franchise_idx" => $franchise_idx,
                "user_idx" => $user_idx,
                "msg_title" => $msgtitle,
                "msg_contents" => $msgcontents
            );

            $result = $this->saveMessageInfo->insert($params);
            if ($result) {
                $return_data['msg'] = '메시지가 저장되었습니다.';
            } else {
                throw new Exception('메시지가 저장되지 않았습니다.', 701);
            }
            return $return_data;
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }

    public function saveMsgDelete($request)
    {
        $msg_idx  = !empty($request['msg_idx']) ? $request['msg_idx'] : '';
        $franchise_idx  = !empty($request['center_idx']) ? $request['center_idx'] : '';
        $user_idx = !empty($request['user_idx']) ? $request['user_idx'] : '';
        try {
            if (empty($msg_idx) || empty($franchise_idx) || empty($user_idx)) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }
            $this->saveMessageInfo->where_qry = " msg_idx = '" . $msg_idx . "' AND franchise_idx = '" . $franchise_idx . "' AND user_idx = '" . $user_idx . "' ";
            $result = $this->saveMessageInfo->delete();
            if ($result) {
                $return_data['msg'] = '저장 메시지가 삭제되었습니다.';
            } else {
                throw new Exception('저장 메시지가 삭제되지 않았습니다.', 701);
            }
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

$saveMessageController = new SaveMessageController();
