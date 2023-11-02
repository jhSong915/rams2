<?php
include $_SERVER['DOCUMENT_ROOT'] . "/center/Model/Model.php";

class InquiryInfo extends Model
{
    var $table_name = 'board_inquiryt';
    var $inquiry_comment_table = 'board_inquiry_commentt';

    function __construct()
    {
        parent::__construct();
    }

    public function inquiryLoad()
    {
        $sql = "SELECT 
                I.inquiry_idx, I.inquiry_title, convert(varchar(19), I.reg_date, 120) reg_date, concat(F.center_name, ' ', M.user_name) inquiry_writer, C.inquiry_comment
                FROM {$this->table_name} I 
                LEFT OUTER JOIN member_centerm M 
                ON I.inquiry_writer = M.user_no
                LEFT OUTER JOIN franchisem F
                ON F.franchise_idx = M.franchise_idx
                LEFT OUTER JOIN {$this->inquiry_comment_table} C
                ON C.inquiry_idx = I.inquiry_idx
                ORDER BY I.reg_date DESC";
        $result = $this->db->sqlRowArr($sql);

        return $result;
    }

    public function inquirySelect($inquiry_idx)
    {
        $sql = "SELECT 
                I.inquiry_title,
                CONCAT(F.center_name, ' ', M.user_name) inquiry_writer,
                convert(varchar(19), I.reg_date, 120) reg_date,
                CO.code_name inquiry_kind,
                I.inquiry_contents,
                I.file_name,
                I.origin_file_name,
                C.inquiry_comment,
                C.file_name comment_file,
                I.inquiry_writer writer_no
                FROM {$this->table_name} I
                LEFT OUTER JOIN member_centerm M 
                ON I.inquiry_writer = M.user_no
                LEFT OUTER JOIN franchisem F 
                ON F.franchise_idx = M.franchise_idx
                LEFT OUTER JOIN codem CO
                ON CO.code_num1 = '72' AND CO.code_num2 = I.inquiry_type
                LEFT OUTER JOIN {$this->inquiry_comment_table} C 
                ON C.inquiry_idx = I.inquiry_idx
                WHERE I.inquiry_idx = '" . $inquiry_idx . "' ";

        $result = $this->db->sqlRow($sql);
        return $result;
    }

    public function inquiryUpdateLoad($inquiry_idx)
    {
        $sql = "SELECT inquiry_title, inquiry_type, file_name, origin_file_name, inquiry_contents FROM {$this->table_name} WHERE inquiry_idx = '".$inquiry_idx."'";
        $result = $this->db->sqlRow($sql);

        return $result;
    }
}
