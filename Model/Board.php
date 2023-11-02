<?php
include $_SERVER['DOCUMENT_ROOT'] . "/Model/Model.php";

class BoardInfo extends Model
{
    var $table_name = "rams.boardm";

    function __construct()
    {
        parent::__construct();
    }

    public function loadFileBoard()
    {
        $sql = "select b.board_idx, b.title, c1.code_name code_name1, c.detail code_name2, b.contents, b.files, b.reg_date 
                from {$this->table_name} b
                left join rams.codem c1 on (b.category1 = c1.code_num2 and c1.code_num1 = '71' and c1.code_num3 = '')
                left join rams.codem c on (c.code_num1 = '71' and b.category2 = c.code_num3 and c.code_num2 = b.category1 )
                where category1 != ''";
        $result = $this->db->sqlRowArr($sql);

        return $result;
    }

    public function loadBoard()
    {
        $sql = "select board_idx, title, contents, files, reg_date 
                from {$this->table_name}
                where category1 = ''";
        $result = $this->db->sqlRowArr($sql);

        return $result;
    }

    public function boardSelect($board_idx){
        $sql = "select board_idx, title, category1, category2, contents, files, origin_file, file_path, reg_date from {$this->table_name} where board_idx = ".$board_idx;
        $result = $this->db->sqlRow($sql);
        return $result;
    }
}