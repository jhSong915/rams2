<?php
include $_SERVER['DOCUMENT_ROOT'] . "/Model/Model.php";

class BookInfo extends Model
{
    var $table_name = "rams.bookm";

    function __construct()
    {
        parent::__construct();
    }

    public function bookLoad()
    {
        $sql = "select 
                    b.book_idx
                  , b.book_isbn
                  , b.book_name
                  , b.book_writer
                  , b.book_publisher
                  , b.book_category1
                  , b.book_category2
                  , b.book_category3
                  , b.img_link
                  , b.reg_date
                  , c.detail
                from {$this->table_name} b
                left join rams.codem c
                   on (b.book_category1 = c.code_num1 and b.book_category2 = c.code_num2 and b.book_category3 = c.code_num3)
                where useYn = 'Y'
                and c.code_num2 <> ''
                order by book_idx desc";

        $result = $this->db->sqlRowArr($sql);
        return $result;
    }

    public function bookSelect($book_idx)
    {
        $sql = "select 
                  book_idx
                  , book_isbn
                  , book_name
                  , book_writer
                  , book_publisher
                  , book_category1
                  , book_category2
                  , book_category3
                from {$this->table_name} 
                where book_idx='" . $book_idx . "'";

        $result = $this->db->sqlRow($sql);
        return $result;
    }

    public function bookCategory($position, $category1=null, $category2=null)
    {
      if($position == '1'){
        $sql = "select code_num1, code_name from rams.codem where code_num1 between '80' and '89' and code_num2 = '' and code_num3 = '' and code_use = 'Y'";
      }else if($position == '2'){
        $sql = "select code_num2, code_name from rams.codem where code_num1 = '".$category1."' and code_num2 <> '' and code_num3 = '' and code_use = 'Y'";
      }else {
        $sql = "select code_num3, detail from rams.codem where code_num1 = '".$category1."' and code_num2 = '".$category2."' and code_num3 <> '' and code_use = 'Y'";
      }
      
      $result = $this->db->sqlRowArr($sql);

      return $result;
    }

    public function bookSearch($book_name)
    {
      $sql = "select 
                  b.book_idx
                , b.book_isbn
                , b.book_name
                , b.book_writer
                , b.book_publisher
                , c.detail
              from {$this->table_name} b
              left join rams.codem c
                 on (b.book_category1 = c.code_num1 and b.book_category2 = c.code_num2 and b.book_category3 = c.code_num3)
              where useYn = 'Y'
              and c.code_num2 <> '' 
              and book_name like '%".addslashes($book_name)."%'";

      $result = $this->db->sqlRowArr($sql);
      return $result;
    }
}
