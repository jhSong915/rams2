<?php
include $_SERVER['DOCUMENT_ROOT'] . "/adm/Model/Model.php";

class BannerInfo extends Model
{
    var $table_name = "bannerT";

    function __construct()
    {
        parent::__construct();
    }

    public function loadBanner()
    {
        $sql = "SELECT banner_idx, from_date, to_date, banner_image, banner_link, orders, mainYn, banner_visible FROM {$this->table_name} WHERE to_date <= '". date('Y-m-d H:i:s') ."'";
        $result = $this->db->sqlRowArr($sql);

        return $result;
    }

    public function getBannerInfo($banner_idx)
    {
        $sql = "SELECT banner_idx, from_date, to_date, banner_image, banner_link, orders, mainYn, banner_visible FROM {$this->table_name} WHERE banner_idx = '{$banner_idx}'";
        $result = $this->db->sqlRow($sql);
        return $result;
    }
}