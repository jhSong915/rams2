<?php
include $_SERVER['DOCUMENT_ROOT'] . "/Model/Model.php";

class CurriculumInfo extends Model
{
    var $table_name = "rams.curriculumm";

    function __construct()
    {
        parent::__construct();
    }

    public function curriculumLoad($params)
    {
        $months     = !empty($params['months']) ? $params['months'] : '';
        $grade     = !empty($params['grade']) ? $params['grade'] : '';

        $where = '';
        $where_arr = array();

        if (!empty($months)) {
            $where_arr[] .= " months = '" . $months . "' ";
        }

        if (!empty($grade)) {
            $where_arr[] .= " grade = '" . $grade . "' ";
        }

        if (!empty($where_arr)) {
            $where = "where " . implode(" and ", $where_arr);
        }

        $sql = "select 
                  c.curriculum_idx
                , c.months
                , c1.code_name
                , c.orders
                , c.book_idx
                , b.book_name
                , b.book_writer
                , b.book_publisher  
                from {$this->table_name} c 
                left join rams.bookm b 
                on c.book_idx = b.book_idx
                left join rams.codem c1
                on (c.grade =  c1.code_num2 and c1.code_num1 = '02')
                " . $where . "
                order by orders asc";
        $result = $this->db->sqlRowArr($sql);
        return $result;
    }
}
