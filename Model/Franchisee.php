<?php
include $_SERVER['DOCUMENT_ROOT'] . "/Model/Model.php";

class FranchiseInfo extends Model
{
    var $table_name = 'rams.franchisem';

    function __construct()
    {
        parent::__construct();
    }

    public function centerLoad()
    {
        $sql = "select franchise_idx, center_name, owner_name, useyn from {$this->table_name} where franchise_type <> '00'";
        $result = $this->db->sqlRowArr($sql);

        return $result;
    }

    public function centerSelect($franchise_idx)
    {
        $sql = "select franchise_type, center_name, center_eng_name, owner_name, owner_id, useyn, address, tel_num, fax_num, email, location
                , biz_reg_date, biz_no, class_no, report_date, franchisee_start, franchisee_end
                , rams_fee, sales_confirm, royalty, sms_fee, mms_fee, shop_id, shop_key
                from {$this->table_name} where franchise_idx = '" . $franchise_idx . "'";
        $result = $this->db->sqlRow($sql);

        return $result;
    }

    public function getCenterMenu()
    {
        $sql = "SELECT menu_idx FROM menu_link WHERE type = 'center' AND useYn = 'Y'";
        $result = $this->db->sqlRowArr($sql);
        return $result;
    }
}
