<?php
include $_SERVER['DOCUMENT_ROOT'] . "/center/Model/Model.php";

class ReportInfo extends Model
{
    var $setting_table_name = 'report_settingm';
    var $report_table_name = 'reportt';

    function __construct()
    {
        parent::__construct();
    }

    public function reportLoad($params)
    {
        $user_no = !empty($params['user_no']) ? $params['user_no'] : '';
        $franchise_idx = !empty($params['franchise_idx']) ? $params['franchise_idx'] : '';
        $months = !empty($params['months']) ? $params['months'] : '';

        if (empty($user_no) || empty($months)) {
            throw new Exception('필수값이 누락되었습니다.', 701);
        }

        $sql = "SELECT R.report_idx, M.user_name, CONVERT(varchar(19), R.reg_date, 120) reg_date
                FROM {$this->report_table_name} R
                LEFT OUTER JOIN member_centerm M
                ON R.user_no = M.user_no
                WHERE R.user_no = '" . $user_no . "' 
                AND R.franchise_idx = '" . $franchise_idx . "'
                AND R.months = '" . $months . "' 
                ORDER BY R.report_idx DESC";
        $result = $this->db->sqlRowArr($sql);

        return $result;
    }

    public function settingCheck($user_no, $franchise_idx)
    {
        $sql = "SELECT COUNT(0) FROM {$this->setting_table_name} WHERE user_no = '" . $user_no . "' AND franchise_idx = '" . $franchise_idx . "'";
        $result = $this->db->sqlRowOne($sql);

        return $result;
    }

    public function reportSettingInsert($params)
    {
        $user_no = !empty($params['user_no']) ? $params['user_no'] : '';
        $franchise_idx = !empty($params['franchise_idx']) ? $params['franchise_idx'] : '';
        $title_array = !empty($params['title_array']) ? array_values(array_filter($params['title_array'])) : '';
        $title_key = array();
        $title_val = array();

        if (!empty($title_array)) {
            $num = count($title_array);

            for ($i = 1; $i <= $num; $i++) {
                $title_key[] .= "title" . $i;
                $title_val[] .= "'" . str_replace("'", "''", $title_array[$i - 1]) . "'";
            }
        }

        $title_key_str = implode(",", $title_key);
        $title_val_str = implode(",", $title_val);

        $sql = "INSERT INTO {$this->setting_table_name} (user_no, franchise_idx, " . $title_key_str . ") VALUES ('" . $user_no . "','" . $franchise_idx . "'," . $title_val_str . ")";
        $result = $this->db->execute($sql);
        return $result;
    }

    public function reportSettingUpdate($params)
    {
        $title_array = !empty($params['title_array']) ? array_values($params['title_array']) : '';
        $title_cnt = !empty($params['title_cnt']) ? $params['title_cnt'] : '';
        $title_qry = "";

        if (!empty($title_array)) {
            $num = ($title_cnt >= count($title_array)) ? $title_cnt : count($title_array);

            for ($i = 1; $i <= $num; $i++) {
                $title_qry .= ", title" . $i . "='" . str_replace("'", "''", $title_array[$i - 1]) . "'";
            }
        }

        $sql = "UPDATE {$this->setting_table_name} SET
                  mod_date = getdate()
                " . $title_qry . "
                WHERE franchise_idx = '" . $params['franchise_idx'] . "' AND user_no = '" . $params['user_no'] . "'";

        $result = $this->db->execute($sql);
        return $result;
    }

    public function reportInsert($params)
    {
        $user_no = $params['user_no'];
        $franchise_idx = $params['franchise_idx'];
        $months = $params['months'];
        $title_arr = array_filter($params['title_arr']);

        $title_num = count($title_arr);

        $title_key = array();
        $title_val = array();

        for ($i = 1; $i <= $title_num; $i++) {
            $title_key[] .= "title" . $i;
            $title_val[] .= "'" . str_replace("'", "''", $title_arr[$i - 1]) . "'";
        }

        $title_key_str = implode(",", $title_key);
        $title_val_str = implode(",", $title_val);

        $contents_arr = $params['contents_arr'];

        $contents_key = array();
        $contents_val = array();
        foreach ($contents_arr as $key => $val) {
            $contents_key[] .= "content" . ($key + 1);
            $contents_val[] .= "'" . str_replace("'", "''", $val) . "'";
        }

        $contents_key_str = implode(",", $contents_key);
        $contents_val_str = implode(",", $contents_val);

        $sql = "INSERT INTO {$this->report_table_name} (user_no, franchise_idx, months, " . $title_key_str . "," . $contents_key_str . ") 
                VALUES ('" . $user_no . "','" . $franchise_idx . "','" . $months . "', " . $title_val_str . ", " . $contents_val_str . ")";

        $result = $this->db->execute($sql);
        return $result;
    }

    public function reportUpdate($params)
    {
        $report_idx = $params['report_idx'];
        $contents_arr = $params['contents_arr'];
        $contents_qry = '';

        foreach ($contents_arr as $key => $val) {
            $contents_qry .= ", content" . ($key + 1) . "='" . $val . "'";
        }

        $contents_qry = substr($contents_qry, 1);

        $sql = "UPDATE {$this->report_table_name} SET
                " . $contents_qry . "
                WHERE report_idx = '" . $report_idx . "'";

        $result = $this->db->execute($sql);
        return $result;
    }

    public function reportDelete($report_idx)
    {
        $sql = "DELETE FROM {$this->report_table_name} WHERE report_idx = '" . $report_idx . "'";
        $result = $this->db->execute($sql);

        return $result;
    }

    public function reportSettingLoad($franchise_idx, $user_no)
    {
        $sql = "SELECT title1, title2, title3, title4, title5, title6, title7, title8, title9, title10
        FROM {$this->setting_table_name} WHERE franchise_idx = '{$franchise_idx}' AND user_no = '{$user_no}'";
        $result = $this->db->sqlRow($sql);

        return $result;
    }

    public function reportContentsLoad($franchise_idx, $user_no)
    {
        $sql = "SELECT TOP (1)
                  title1 , title2 , title3 , title4 , title5 , title6 , title7 , title8 , title9 , title10
                , content1 , content2 , content3 , content4 , content5 , content6 , content7 , content8 , content9 , content10
                FROM {$this->report_table_name}
                WHERE franchise_idx = '{$franchise_idx}' AND user_no = '{$user_no}' ORDER BY reg_date DESC";
        $result = $this->db->sqlRow($sql);

        return $result;
    }

    public function selectReportData($user_no, $franchise_idx, $report_idx)
    {
        $sql = "SELECT title1 , title2 , title3 , title4 , title5 , title6 , title7 , title8 , title9 , title10
        , content1 , content2 , content3 , content4 , content5 , content6 , content7 , content8 , content9 , content10
        FROM {$this->report_table_name}
        WHERE franchise_idx = '{$franchise_idx}' AND user_no = '{$user_no}' AND report_idx = '{$report_idx}'";

        $result['report_data'] = $this->db->sqlRow($sql);

        $sql = "SELECT TOP(1) title1 , title2 , title3 , title4 , title5 , title6 , title7 , title8 , title9 , title10
        , content1 , content2 , content3 , content4 , content5 , content6 , content7 , content8 , content9 , content10
        FROM {$this->report_table_name}
        WHERE franchise_idx = '{$franchise_idx}' AND user_no = '{$user_no}' AND report_idx < '{$report_idx}' ORDER BY reg_date DESC";

        $result['pre_report_data'] = $this->db->sqlRow($sql);

        return $result;
    }
}
