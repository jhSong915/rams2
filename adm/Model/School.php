<?php
include $_SERVER['DOCUMENT_ROOT'] . "/adm/Model/Model.php";

class SchoolInfo extends Model
{
    var $table_name = 'school_infoM';

    function __construct()
    {
        parent::__construct();
    }

    public function getSchoolList()
    {
        $sql = "SELECT school_idx, CASE WHEN school_type = '1' THEN '초등학교' WHEN school_type = '2' THEN '중학교' WHEN school_type = '3' THEN '고등학교' ELSE '' END AS school_type, school_name,
        access_token, start_date, expire_date, reg_date FROM {$this->table_name} WHERE reg_date >= '" . date('Y-m-d', strtotime("-1 Years")) .  "'";
        $result = $this->db->sqlRowArr($sql);
        return $result;
    }

    public function getSchoolInfo($school_idx)
    {
        $sql = "SELECT S.school_idx, S.school_type, S.school_name, S.manager_name, S.manager_tel, S.manager_hp, 
        S.manager_email, S.access_token, S.start_date, S.expire_date, S.reg_date, C1.code_name AS 'order_method', S.order_state, S.order_money, S.contract_no FROM {$this->table_name} S
        LEFT OUTER JOIN codeM C1 ON C1.code_num1 = '41' AND C1.code_num2 = S.order_method
        WHERE school_idx = '{$school_idx}'";
        $result = $this->db->sqlRow($sql);
        return $result;
    }

    public function getAccessTokenCheck($access_token)
    {
        $sql = "SELECT COUNT(0) FROM {$this->table_name} WHERE access_token = '{$access_token}'";
        $result = $this->db->sqlRowOne($sql);
        return $result;
    }
}
