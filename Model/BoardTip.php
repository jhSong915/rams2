<?php
include $_SERVER['DOCUMENT_ROOT'] . "/Model/Model.php";

class BoardTipInfo extends Model
{
    var $table_name = "rams.board_lessontipt";
    var $comment_table = "rams.board_lessontip_commentt";

    function __construct()
    {
        parent::__construct();
    }

    public function boardTipDelete($board_idx)
    {
        $sql = "DELETE FROM {$this->comment_table} WHERE board_idx = '" . $board_idx . "';";
        $sql .= "  DELETE FROM {$this->table_name} WHERE board_idx = '" . $board_idx . "'";

        $result = $this->db->multiExecute($sql);
        return $result;
    }

    public function boardTipNoticeLoad()
    {
        $sql = "SELECT b.board_idx, b.title, c.code_name, '관리자' writer, COUNT(cc.comment_idx) cnt1, b.notice_yn, b.reg_date, b.file_name
                , (SELECT COUNT(0) FROM rams.board_lessontip_commentt WHERE likes = 'Y' AND board_idx = b.board_idx) cnt2
                FROM {$this->table_name} b 
                LEFT OUTER JOIN rams.codem c
                ON (b.board_kind = c.code_num2 AND c.code_num1 = '04' AND c.code_num2 <> '')
                LEFT OUTER JOIN rams.member_employeem m
                ON b.user_no = m.user_no
                LEFT OUTER JOIN rams.franchisem f
                ON m.franchise_idx = f.franchise_idx
                LEFT OUTER JOIN rams.board_lessontip_commentt cc
                ON b.board_idx = cc.board_idx AND cc.likes <> 'Y'
                WHERE b.notice_yn = 'Y'
                group by b.board_idx
                order by b.board_idx desc
                LIMIT 3";
        $result = $this->db->sqlRowArr($sql);

        return $result;
    }

    public function boardTipLoad()
    {
        $sql = "SELECT b.board_idx, b.title, c.code_name, m.user_name, f.center_name, COUNT(cc.comment_idx) cnt1, b.notice_yn, b.reg_date, b.file_name
                , (SELECT COUNT(0) FROM rams.board_lessontip_commentt WHERE likes = 'Y' AND board_idx = b.board_idx) cnt2
                FROM {$this->table_name} b 
                LEFT OUTER JOIN rams.codem c
                ON (b.board_kind = c.code_num2 AND c.code_num1 = '04' AND c.code_num2 <> '')
                LEFT OUTER JOIN rams.member_employeem m
                ON b.user_no = m.user_no
                LEFT OUTER JOIN rams.franchisem f
                ON m.franchise_idx = f.franchise_idx
                LEFT OUTER JOIN rams.board_lessontip_commentt cc
                ON b.board_idx = cc.board_idx AND cc.likes <> 'Y'
                group by b.board_idx
                order by b.board_idx desc";
        $result = $this->db->sqlRowArr($sql);

        return $result;
    }

    public function boardTipSelect($board_idx)
    {
        $sql = "SELECT user_no, board_kind, title, contents, file_name, origin_name, file_path, notice_yn FROM {$this->table_name} WHERE board_idx = '" . $board_idx . "'";
        $result = $this->db->sqlRow($sql);

        return $result;
    }

    public function boardTipCmtInsert($params)
    {
        $sql = "INSERT INTO {$this->comment_table} SET ";

        foreach ($params as $key => $val) {
            if ($val === 'NOW()') {
                $sql .= "{$key}=NOW(),";
            } else if ($val === 'NULL') {
                $sql .= "{$key}=NULL,";
            } else if (is_array($val)) {
                $sql .= "{$key}='" . json_encode($val) . "',";
            } else {
                $sql .= "{$key}='" . addslashes($val) . "',";
            }
        }

        $sql = substr($sql, 0, -1); // 콤마 제거

        try {
            $result = $this->db->execute($sql);
        } catch (Exception $e) {
            new Exception($e);
        }

        $this->last_sql = $sql;
        return $result;
    }

    public function boardTipCmtLoad($board_idx)
    {
        $sql = "SELECT c.comment_idx, c.user_no, m.user_name, f.center_name, c.comment, c.reg_date
                FROM {$this->comment_table} c 
                LEFT OUTER JOIN rams.member_employeem m 
                ON c.user_no = m.user_no 
                LEFT OUTER JOIN rams.franchisem f
                ON m.franchise_idx = f.franchise_idx
                WHERE c.board_idx = '" . $board_idx . "' AND c.likes <> 'Y'";
        $result = $this->db->sqlRowArr($sql);

        return $result;
    }

    public function getLikesCnt($board_idx)
    {
        $sql = "SELECT COUNT(0) FROM {$this->comment_table} WHERE board_idx = '" . $board_idx . "' AND likes = 'Y'";
        $result = $this->db->sqlRowOne($sql);

        return $result;
    }

    public function boardTipCmtDelete($comment_idx)
    {
        $sql = "DELETE FROM {$this->comment_table} WHERE comment_idx = '" . $comment_idx . "' AND comment <> '' AND likes = ''";
        $result = $this->db->execute($sql);

        return $result;
    }

    public function checkLikeCnt($board_idx, $user_no)
    {
        $sql = "SELECT comment_idx, likes FROM {$this->comment_table} WHERE board_idx = '" . $board_idx . "' AND user_no = '" . $user_no . "' AND likes <> ''";
        $result = $this->db->sqlRow($sql);

        return $result;
    }

    public function likeInsert($params)
    {
        $sql = "INSERT INTO {$this->comment_table} SET ";

        foreach ($params as $key => $val) {
            if ($val === 'NOW()') {
                $sql .= "{$key}=NOW(),";
            } else if ($val === 'NULL') {
                $sql .= "{$key}=NULL,";
            } else if (is_array($val)) {
                $sql .= "{$key}='" . json_encode($val) . "',";
            } else {
                $sql .= "{$key}='" . addslashes($val) . "',";
            }
        }

        $sql = substr($sql, 0, -1); // 콤마 제거

        try {
            $result = $this->db->execute($sql);
        } catch (Exception $e) {
            new Exception($e);
        }

        $this->last_sql = $sql;
        return $result;
    }

    public function likeDelete($comment_idx)
    {
        $sql = "DELETE FROM {$this->comment_table} WHERE comment_idx = '" . $comment_idx . "'";
        $result = $this->db->execute($sql);

        return $result;
    }
}
