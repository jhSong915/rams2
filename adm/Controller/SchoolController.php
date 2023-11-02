<?php
include_once $_SERVER['DOCUMENT_ROOT'] . "/adm/Controller/Controller.php";
include_once $_SERVER['DOCUMENT_ROOT'] . "/adm/Model/School.php";
include_once $_SERVER['DOCUMENT_ROOT'] . "/common/function.php";

class SchoolController extends Controller
{
    private $schoolInfo;

    function __construct()
    {
        $this->schoolInfo = new SchoolInfo();
    }

    public function getSchoolList($request)
    {
        try {
            $result = $this->schoolInfo->getSchoolList();
            if (!empty($result)) {
            }

            return $result;
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }

    public function getSchoolInfo($request)
    {
        $school_idx = !empty($request['school_idx']) ? $request['school_idx'] : '';
        try {
            if (empty($school_idx)) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }

            $result = $this->schoolInfo->getSchoolInfo($school_idx);

            return $result;
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }

    public function getAccessTokenCheck($request)
    {
        $access_token = !empty($request['access_token']) ? $request['access_token'] : "";
        try {
            if (empty($access_token)) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }

            $result = $this->schoolInfo->getAccessTokenCheck($access_token);

            return $result;
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }

    public function schoolInfoInsert($request)
    {
        $school_type = !empty($request['school_type']) ? $request['school_type'] : "";
        $school_name = !empty($request['school_name']) ? $request['school_name'] : "";
        $manager_name = !empty($request['manager_name']) ? $request['manager_name'] : "";
        $manager_tel = !empty($request['manager_tel']) ? $request['manager_tel'] : "";
        $manager_hp = !empty($request['manager_hp']) ? $request['manager_hp'] : "";
        $manager_email = !empty($request['manager_email']) ? $request['manager_email'] : "";
        $manager_password = !empty($request['manager_password']) ? $request['manager_password'] : "";
        $start_date = !empty($request['start_date']) ? $request['start_date'] : "";
        $end_date = !empty($request['end_date']) ? $request['end_date'] : "";
        $contarct_no = !empty($request['contarct_no']) ? $request['contarct_no'] : 0;
        $order_money = !empty($request['order_money']) ? $request['order_money'] : 1000;
        $access_token = !empty($request['access_token']) ? $request['access_token'] : "";

        try {
            if (empty($school_type) || empty($school_name) || empty($manager_name) || empty($manager_tel) || empty($manager_hp) || empty($manager_email)
             || empty($manager_password) || empty($start_date) || empty($end_date) || empty($contarct_no) || empty($order_money) || empty($access_token)) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }

            $manager_password = password_hash($manager_password, PASSWORD_DEFAULT);

            $params = array(
                "school_type" => $school_type,
                "school_name" => $school_name,
                "manager_name" => $manager_name,
                "manager_tel" => $manager_tel,
                "manager_hp" => $manager_hp,
                "manager_email" => $manager_email,
                "manager_password" => $manager_password,
                "start_date" => $start_date,
                "expire_date" => $end_date,
                "order_state" => "01",
                "order_method" => "",
                "order_money" => $order_money,
                "contract_no" => $contarct_no,
                "access_token" => $access_token
            );

            $result = $this->schoolInfo->insert($params);
            if ($result) {
                $return_data['msg'] = '학교정보가 등록되었습니다.';
                return $return_data;
            } else {
                throw new Exception('학교정보 등록에 실패하였습니다.', 701);
            }
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }

    public function schoolInfoUpdate($request)
    {
        $school_idx = !empty($request['school_idx']) ? $request['school_idx'] : "";
        $school_name = !empty($request['school_name']) ? $request['school_name'] : "";
        $manager_name = !empty($request['manager_name']) ? $request['manager_name'] : "";
        $manager_tel = !empty($request['manager_tel']) ? $request['manager_tel'] : "";
        $manager_hp = !empty($request['manager_hp']) ? $request['manager_hp'] : "";
        $manager_email = !empty($request['manager_email']) ? $request['manager_email'] : "";
        $manager_password = !empty($request['manager_password']) ? $request['manager_password'] : "";
        $start_date = !empty($request['start_date']) ? $request['start_date'] : "";
        $end_date = !empty($request['end_date']) ? $request['end_date'] : "";
        $order_state = !empty($request['order_state']) ? $request['order_state'] : "";
        $contract_no = !empty($request['contract_no']) ? $request['contract_no'] : "0";

        try {
            if (empty($school_idx) || empty($school_name) || empty($manager_name) || empty($manager_tel) || empty($manager_hp) || empty($manager_email)
             || empty($start_date) || empty($end_date) || empty($order_state)) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }

            $params = array(
                "school_name" => $school_name,
                "manager_name" => $manager_name,
                "manager_tel" => $manager_tel,
                "manager_hp" => $manager_hp,
                "manager_email" => $manager_email,
                "start_date" => $start_date,
                "expire_date" => $end_date,
                "order_state" => $order_state,
                "contract_no" => $contract_no,
                "mod_date" => "getdate()"
            );

            if (!empty($manager_password)) {
                $manager_password = password_hash($manager_password, PASSWORD_DEFAULT);
                $params["manager_password"] = $manager_password;
            }
            $this->schoolInfo->where_qry = " school_idx = '{$school_idx}' ";
            $result = $this->schoolInfo->update($params);
            if ($result) {
                $return_data['msg'] = '학교정보가 수정되었습니다.';
                return $return_data;
            } else {
                throw new Exception('학교정보 수정에 실패하였습니다.', 701);
            }
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }
}

$schoolController = new SchoolController();
