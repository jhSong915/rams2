<?php
include $_SERVER['DOCUMENT_ROOT'] . "/adm/Model/Model.php";

class FranchiseInfo extends Model
{
    var $table_name = 'franchisem';

    function __construct()
    {
        parent::__construct();
    }

    public function centerLoad()
    {
        $sql = "SELECT franchise_idx, center_name, owner_name, useyn FROM {$this->table_name}";
        $result = $this->db->sqlRowArr($sql);

        return $result;
    }

    public function centerSelect($franchise_idx)
    {
        $sql = "SELECT franchise_type, center_name, center_eng_name, owner_name, owner_id, useyn, address, zipcode, tel_num, fax_num, email, location
                , biz_reg_date, biz_no, class_no, report_date, franchisee_start, franchisee_end
                , rams_fee, sales_confirm, royalty, sms_fee, lms_fee, mms_fee, shop_id, shop_key
                FROM {$this->table_name} WHERE franchise_idx = '" . $franchise_idx . "'";
        $result = $this->db->sqlRow($sql);

        return $result;
    }

    public function updateOwner($owner_id)
    {
        $menu = "SELECT menu_idx FROM menu_link WHERE type = 'center' AND useYn = 'Y'";
        $menu_arr = $this->db->sqlRowArr($menu);
        $menu_list = implode(',', $menu_arr);

        $sql = "UPDATE member_centerm SET
                state = '00', is_admin = 'Y', menu_group = '{$menu_list}' WHERE user_id = '{$owner_id}'";

        $result = $this->db->execute($sql);
        return $result;
    }

    public function getPointList($year)
    {
        if (!empty($year)) {
            $qry = " AND IP.reg_date BETWEEN '" . $year . "-01-01' AND '" . $year . "-12-31' ";
        }
        $sql = "SELECT F.center_name, F.point, C.code_name, IP.order_money, IP.reg_date FROM invoice_pointM IP
        LEFT OUTER JOIN franchiseM F ON F.franchise_idx = IP.franchise_idx
        LEFT OUTER JOIN codeM C ON C.code_num1 = '41' AND IP.order_method = C.code_num2
        WHERE (IP.franchise_idx+IP.reg_date) IN (SELECT franchise_idx+MAX(reg_date) FROM invoice_pointM GROUP BY franchise_idx) {$qry} ORDER BY IP.reg_date DESC";
        $result = $this->db->sqlRowArr($sql);

        return $result;
    }
}
