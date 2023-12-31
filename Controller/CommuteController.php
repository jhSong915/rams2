<?php
include_once $_SERVER['DOCUMENT_ROOT'] . "/Controller/Controller.php";
include_once $_SERVER['DOCUMENT_ROOT'] . "/Model/Commute.php";

class CommuteController extends Controller
{
    private $commuteInfo;

    function __construct()
    {
        $this->commuteInfo = new CommuteInfo();
    }

    public function selectEmployee()
    {
        try {
            $result = $this->commuteInfo->selectEmployee();
            return $result;
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }

    public function insertCommuteLog($request)
    {
        $user_no = !empty($request['user_no']) ? $request['user_no'] : '';
        $state   = !empty($request['state']) ? $request['state'] : '';

        try {
            if (empty($user_no) || empty($state)) {
                throw new Exception('필수값이 누락되었습니다.', 501);
            }

            $params = array(
                "user_no" => !empty($user_no) ? $user_no : '',
                "state"   => !empty($state) ? $state : ''
            );

            $cnt = $this->commuteInfo->checkTodayLog($user_no, $state);
            if ($cnt > 0) {
                throw new Exception("이미 오늘 " . $state . "을 등록하셨습니다.", 501);
            } else {
                $result = $this->commuteInfo->insert($params);
                if ($result) {
                    $return_data['msg'] = $state . "처리가 완료되었습니다.";
                } else {
                    throw new Exception('잠시 후 다시후 다시 시도해주세요.', 501);
                }
            }
            return $return_data;
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }

    public function commuteSelect($params)
    {
        $user_no = !empty($params['user_no']) ? $params['user_no'] : '';
        $now_date = !empty($params['now_date']) ? $params['now_date'] : date("Y-m");

        $date_list = $this->getMonthArray($now_date);

        try {
            $result = $this->commuteInfo->commuteSelect($user_no);

            foreach ($date_list as $key => $date_val) {
                $date_list[$key]['in_time']        = '';
                $date_list[$key]['out_time']       = '';
                $date_list[$key]['work_time']      = '';
                $date_list[$key]['break_time']     = '';
                $date_list[$key]['break_day']      = '';

                $date_w = date('w', strtotime($date_val['date'])) + 1; //요일 확인 (1:일, 2:월, 3:화, 4:수, 5:목, 6:금, 7:토)

                foreach ($result as $key2 => $val) {
                    if ($date_w == $val['paid_holiday']) {
                        $date_list[$key]['break_day'] = '유급휴일';
                    } else if ($date_w == $val['unpaid_holiday']) {
                        $date_list[$key]['break_day'] = '무급휴일';
                    }

                    if ($date_val['date'] == $val['date']) {
                        $date_arr = explode(",", $val['reg_date']);
                        $in_time = $date_arr[0];
                        $out_time = $date_arr[1];
                        $work_min = !empty($out_time) ? sprintf("%d", (strtotime($out_time) - strtotime($in_time)) / 60) : '';
                        $work_hour = !empty($work_min) ? sprintf("%d", $work_min / 60) : '';
                        $work_time = '';
                        $break_time = '';

                        if(!empty($in_time) && !empty($out_time)){
                            $work_min = !empty($out_time) ? sprintf("%d", (strtotime($out_time) - strtotime($in_time)) / 60) : '';

                            if($work_min < 480){
                                $break_time = 30;
                            }else{
                                $break_time = 60;
                            }

                            $work_min = $work_min - $break_time;
                            $work_hour = !empty($work_min) ? sprintf("%d", $work_min / 60) : '';
                            $work_time = $work_hour . " / " . $work_min;
                        }

                        $date_list[$key]['in_time']    = $in_time;
                        $date_list[$key]['out_time']   = $out_time;
                        $date_list[$key]['work_time']  = $work_time;
                        $date_list[$key]['break_time'] = $break_time;
                    }
                }
            }

            return $date_list;
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }
}
$commuteController = new CommuteController();