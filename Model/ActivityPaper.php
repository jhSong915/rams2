<?php
include $_SERVER['DOCUMENT_ROOT'] . "/Model/Model.php";

class ActivityPaperInfo extends Model
{
    var $table_name = "rams.activitypapert";

    function __construct()
    {
        parent::__construct();
    }

    public function activityListLoad()
    {
        $sql = "SELECT 
                      cu.curriculum_idx
                    , cu.book_idx
                    , a.activitypaper_idx
                    , b.book_isbn
                    , b.img_link
                    , b.book_name
                    , b.book_writer
                    , b.book_publisher
                    , c.detail 
                    , a.activity_student1
                    , a.activity_student2
                    , a.activity_teacher1
                    , a.activity_teacher2
                FROM rams.curriculumm cu
                JOIN rams.bookm b
                    ON cu.book_idx = b.book_idx
                LEFT OUTER JOIN rams.activitypapert a
                    ON a.book_idx = b.book_idx
                LEFT OUTER JOIN rams.codem c
                    ON (b.book_category1 = c.code_num1 AND b.book_category2 = c.code_num2 AND b.book_category3 = c.code_num3)
                GROUP BY cu.book_idx";

        $result = $this->db->sqlRowArr($sql);
        return $result;
    }

    public function activityListSelect($activitypaper_idx)
    {
        $sql = "select activity_student1, activity_student2, activity_teacher1, activity_teacher2 from {$this->table_name} where activitypaper_idx = '" . $activitypaper_idx . "'";

        $result = $this->db->sqlRow($sql);
        return $result;
    }
}
