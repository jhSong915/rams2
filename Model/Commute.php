<?php
include $_SERVER['DOCUMENT_ROOT'] . "/Model/Model.php";

class CommuteInfo extends Model
{
    var $table_name = 'rams.commute_logt';

    function __construct()
    {
        parent::__construct();
    }

    public function selectEmployee()
    {
        $sql = "select e.user_no, e.user_name, c.code_name, e.position from rams.member_employeem e
                left join rams.codem c
                  on e.position = c.code_num2
                where e.show_yn = 'Y'
                and c.code_num1 = '08'
                and e.state = '00'
                and e.user_id <> 'admin'
                order by e.position asc
                ";
        $result = $this->db->sqlRowArr($sql);
        return $result;
    }

    public function checkTodayLog($user_no, $state)
    {
        $date = date("Y-m-d");

        $sql = "select count(0) from {$this->table_name}
                where user_no = " . $user_no . " 
                      and state = '" . $state . "' 
                      and reg_date between '" . $date . " 00:00:00' and '" . $date . " 23:59:59' 
                      order by reg_date desc 
                      limit 1";
        $result = $this->db->sqlRowOne($sql);

        return $result;
    }

    public function commuteSelect($user_no)
    {
        $sql = "select group_concat(reg_date) reg_date, date_format(reg_date, '%Y-%m-%d') date, EC.paid_holiday, EC.unpaid_holiday 
                from rams.commute_logt CL
                left join rams.employee_commutem EC
                  on CL.user_no = EC.user_no
                where CL.user_no = '".$user_no."'
                group by date
                order by date";

        $result = $this->db->sqlRowArr($sql);

        return $result;
    }
}
