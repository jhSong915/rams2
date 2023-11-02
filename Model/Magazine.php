<?php
include $_SERVER['DOCUMENT_ROOT'] . "/Model/Model.php";

class MagazineInfo extends Model
{
    var $table_name = 'rams.magazinem';

    function __construct()
    {
        parent::__construct();
    }

    public function magazineLoad($season)
    {
        $where = '';

        if (!empty($season)) {
            $where = " where season = '" . $season . "'";
        }

        $sql = "SELECT m.magazine_idx, m.title, f.center_name FROM {$this->table_name} m LEFT OUTER JOIN rams.franchisem f ON m.franchise_idx = f.franchise_idx" . $where;
        $result = $this->db->sqlRowArr($sql);

        return $result;
    }

    public function magazineSelect($magazine_idx)
    {
        $sql = "SELECT title, franchise_idx, months, thumbnail_name, pdf_link, thumbnail_name
                FROM {$this->table_name} WHERE magazine_idx = '".$magazine_idx."'";
        $result = $this->db->sqlRow($sql);

        return $result;        
    }
}