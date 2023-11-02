<?php
include $_SERVER['DOCUMENT_ROOT'] . "/school/Model/Model.php";

class ReadingDiagnosisInfo extends Model
{
    var $table_name = 'school_rd_infoT';
    var $master_table_name = 'school_infoM';

    function __construct()
    {
        parent::__construct();
    }

    public function getDiagnosisResult1($school_idx, $std_grade, $std_class, $std_no)
    {
        # 1 => 본인 / 2 => 전체 / 3 => 남자 / 4 => 여자
        $sql = "SELECT '1' AS std_flag, std_answer, M.school_type, score_a_1, score_a_2, FORMAT((score_a_1 + score_a_2) / 2, '##0.#') AS 'score_a',
        score_b_1,score_b_2,score_b_3, FORMAT((score_b_1 + score_b_2 + score_b_3) / 3, '##0.#') AS 'score_b' ,score_c, score_d, score_pliterary, score_literary, score_nliterary, score_pnliterary,
        FORMAT(SUM(score_literary + score_pliterary) / 2, '##0.#') AS 'score_literary_avg',
        FORMAT(SUM(score_nliterary + score_pnliterary) / 2, '##0.#') AS 'score_nliterary_avg',
        score_a_1_sum, score_a_2_sum, score_b_1_sum, score_b_2_sum, score_b_3_sum, score_c_sum, score_d_sum, rq_rate FROM school_rd_infoT T
        LEFT OUTER JOIN {$this->master_table_name} M ON T.school_idx = M.school_idx
        WHERE T.school_idx = '{$school_idx}' AND std_grade = '{$std_grade}' AND std_class = '{$std_class}' ANd std_no = '{$std_no}'
        GROUP BY std_answer, school_type, score_a_1,score_a_2,score_b_1,score_b_2,score_b_3,score_c, score_d, score_pliterary, score_literary, score_nliterary, score_pnliterary,score_a_1_sum, score_a_2_sum, score_b_1_sum, score_b_2_sum, score_b_3_sum, score_c_sum, score_d_sum, rq_rate
        UNION
        SELECT '2' AS std_flag,  '' AS 'school_type', '' AS 'std_answer',
        FORMAT((SUM(score_a_1) / COUNT(0)), '##0.#') AS 'score_a_1',
        FORMAT((SUM(score_a_2) / COUNT(0)), '##0.#') AS 'score_a_2', 
        FORMAT((SUM((score_a_1 + score_a_2) / 2) / COUNT(0)), '##0.#') AS 'score_a', 
        FORMAT((SUM(score_b_1) / COUNT(0)), '##0.#') AS 'score_b_1',
        FORMAT((SUM(score_b_2) / COUNT(0)), '##0.#') AS 'score_b_2',
        FORMAT((SUM(score_b_3) / COUNT(0)), '##0.#') AS 'score_b_3', 
        FORMAT((SUM((score_b_1 + score_b_2 + score_b_3) / 3) / COUNT(0)), '##0.#') AS 'score_b',
        FORMAT((SUM(score_c) / COUNT(0)), '##0.#') AS 'score_c',
        FORMAT((SUM(score_d) / COUNT(0)), '##0.#') AS 'score_d',
        FORMAT(SUM(score_a_1_sum) / COUNT(0), '##0.#') AS 'score_a_1_sum',
        FORMAT(SUM(score_a_2_sum) / COUNT(0), '##0.#') AS 'score_a_2_sum',
        FORMAT(SUM(score_b_1_sum) / COUNT(0), '##0.#') AS 'score_b_1_sum',
        FORMAT(SUM(score_b_2_sum) / COUNT(0), '##0.#') AS 'score_b_2_sum',
        FORMAT(SUM(score_b_3_sum) / COUNT(0), '##0.#') AS 'score_b_3_sum',
        FORMAT(SUM(score_c_sum) / COUNT(0), '##0.#') AS 'score_c_sum',
        FORMAT(SUM(score_d_sum) / COUNT(0), '##0.#') AS 'score_d_sum',
        FORMAT(SUM(score_pliterary) / COUNT(0), '##0.#') AS 'score_pliterary',
        FORMAT(SUM(score_literary) / COUNT(0), '##0.#') AS 'score_literary',
        FORMAT(SUM(score_nliterary) / COUNT(0), '##0.#') AS 'score_nliterary',
        FORMAT(SUM(score_pnliterary) / COUNT(0), '##0.#') AS 'score_pnliterary',
        FORMAT(SUM(score_literary + score_pliterary) / 2 / COUNT(0), '##0.#') AS 'score_literary_avg',
        FORMAT(SUM(score_nliterary + score_pnliterary) / 2 / COUNT(0), '##0.#') AS 'score_nliterary_avg',
        FORMAT(SUM(rq_rate) / COUNT(0), '##0.#') AS 'rq_rate' FROM school_rd_infoT T
        WHERE T.school_idx = '{$school_idx}'
        UNION
        SELECT '3' AS std_flag,  '' AS 'school_type', '' AS 'std_answer',
        FORMAT((SUM(score_a_1) / COUNT(0)), '##0.#') AS 'score_a_1',
        FORMAT((SUM(score_a_2) / COUNT(0)), '##0.#') AS 'score_a_2', 
        FORMAT((SUM((score_a_1 + score_a_2) / 2) / COUNT(0)), '##0.#') AS 'score_a', 
        FORMAT((SUM(score_b_1) / COUNT(0)), '##0.#') AS 'score_b_1',
        FORMAT((SUM(score_b_2) / COUNT(0)), '##0.#') AS 'score_b_2',
        FORMAT((SUM(score_b_3) / COUNT(0)), '##0.#') AS 'score_b_3', 
        FORMAT((SUM((score_b_1 + score_b_2 + score_b_3) / 3) / COUNT(0)), '##0.#') AS 'score_b',
        FORMAT((SUM(score_c) / COUNT(0)), '##0.#') AS 'score_c',
        FORMAT((SUM(score_d) / COUNT(0)), '##0.#') AS 'score_d',
        FORMAT(SUM(score_a_1_sum) / COUNT(0), '##0.#') AS 'score_a_1_sum',
        FORMAT(SUM(score_a_2_sum) / COUNT(0), '##0.#') AS 'score_a_2_sum',
        FORMAT(SUM(score_b_1_sum) / COUNT(0), '##0.#') AS 'score_b_1_sum',
        FORMAT(SUM(score_b_2_sum) / COUNT(0), '##0.#') AS 'score_b_2_sum',
        FORMAT(SUM(score_b_3_sum) / COUNT(0), '##0.#') AS 'score_b_3_sum',
        FORMAT(SUM(score_c_sum) / COUNT(0), '##0.#') AS 'score_c_sum',
        FORMAT(SUM(score_d_sum) / COUNT(0), '##0.#') AS 'score_d_sum',
        FORMAT(SUM(score_pliterary) / COUNT(0), '##0.#') AS 'score_pliterary',
        FORMAT(SUM(score_literary) / COUNT(0), '##0.#') AS 'score_literary',
        FORMAT(SUM(score_nliterary) / COUNT(0), '##0.#') AS 'score_nliterary',
        FORMAT(SUM(score_pnliterary) / COUNT(0), '##0.#') AS 'score_pnliterary',
        FORMAT(SUM(score_literary + score_pliterary) / 2 / COUNT(0), '##0.#') AS 'score_literary_avg',
        FORMAT(SUM(score_nliterary + score_pnliterary) / 2 / COUNT(0), '##0.#') AS 'score_nliterary_avg',
        FORMAT(SUM(rq_rate) / COUNT(0), '##0.#') AS 'rq_rate' FROM school_rd_infoT T
        WHERE T.school_idx = '{$school_idx}' AND T.std_gender = '1'
        UNION
        SELECT '4' AS std_flag,  '' AS 'school_type', '' AS 'std_answer',
        FORMAT((SUM(score_a_1) / COUNT(0)), '##0.#') AS 'score_a_1',
        FORMAT((SUM(score_a_2) / COUNT(0)), '##0.#') AS 'score_a_2', 
        FORMAT((SUM((score_a_1 + score_a_2) / 2) / COUNT(0)), '##0.#') AS 'score_a', 
        FORMAT((SUM(score_b_1) / COUNT(0)), '##0.#') AS 'score_b_1',
        FORMAT((SUM(score_b_2) / COUNT(0)), '##0.#') AS 'score_b_2',
        FORMAT((SUM(score_b_3) / COUNT(0)), '##0.#') AS 'score_b_3', 
        FORMAT((SUM((score_b_1 + score_b_2 + score_b_3) / 3) / COUNT(0)), '##0.#') AS 'score_b',
        FORMAT((SUM(score_c) / COUNT(0)), '##0.#') AS 'score_c',
        FORMAT((SUM(score_d) / COUNT(0)), '##0.#') AS 'score_d',
        FORMAT(SUM(score_a_1_sum) / COUNT(0), '##0.#') AS 'score_a_1_sum',
        FORMAT(SUM(score_a_2_sum) / COUNT(0), '##0.#') AS 'score_a_2_sum',
        FORMAT(SUM(score_b_1_sum) / COUNT(0), '##0.#') AS 'score_b_1_sum',
        FORMAT(SUM(score_b_2_sum) / COUNT(0), '##0.#') AS 'score_b_2_sum',
        FORMAT(SUM(score_b_3_sum) / COUNT(0), '##0.#') AS 'score_b_3_sum',
        FORMAT(SUM(score_c_sum) / COUNT(0), '##0.#') AS 'score_c_sum',
        FORMAT(SUM(score_d_sum) / COUNT(0), '##0.#') AS 'score_d_sum',
        FORMAT(SUM(score_pliterary) / COUNT(0), '##0.#') AS 'score_pliterary',
        FORMAT(SUM(score_literary) / COUNT(0), '##0.#') AS 'score_literary',
        FORMAT(SUM(score_nliterary) / COUNT(0), '##0.#') AS 'score_nliterary',
        FORMAT(SUM(score_pnliterary) / COUNT(0), '##0.#') AS 'score_pnliterary',
        FORMAT(SUM(score_literary + score_pliterary) / 2 / COUNT(0), '##0.#') AS 'score_literary_avg',
        FORMAT(SUM(score_nliterary + score_pnliterary) / 2 / COUNT(0), '##0.#') AS 'score_nliterary_avg',
        FORMAT(SUM(rq_rate) / COUNT(0), '##0.#') AS 'rq_rate' FROM school_rd_infoT T
        WHERE T.school_idx = '{$school_idx}' AND T.std_gender = '2'";
        $result = $this->db->sqlRowArr($sql);
        return $result;
    }

    public function getTotalAnalytics($school_idx)
    {
        $sql = "SELECT M.contract_no, COUNT(T.diagnosis_idx) AS 'cnt' FROM {$this->table_name} T
        LEFT OUTER JOIN {$this->master_table_name} M ON T.school_idx = M.school_idx
        WHERE T.school_idx = '{$school_idx}'
        GROUP BY M.contract_no";
        $result = $this->db->sqlRowArr($sql);
        return $result;
    }

    public function getGradeAnalytics($school_idx)
    {
        $sql = "SELECT std_grade, COUNT(0) AS 'cnt' FROM {$this->table_name} T WHERE T.school_idx = '{$school_idx}' GROUP BY std_grade";
        $result = $this->db->sqlRowArr($sql);
        return $result;
    }

    public function getClassAnalytics($school_idx)
    {
        $sql = "SELECT std_grade, std_class, COUNT(0) AS 'cnt' FROM {$this->table_name} T WHERE T.school_idx = '{$school_idx}' GROUP BY std_grade, std_class";
        $result = $this->db->sqlRowArr($sql);
        return $result;
    }

    public function getGenderAnalytics($school_idx)
    {
        $sql = "SELECT CASE WHEN std_gender = '1' THEN '남자' WHEN std_gender = '2' THEN '여자' ELSE '' END AS 'std_gender', COUNT(0) AS 'cnt' FROM {$this->table_name} T WHERE T.school_idx = '{$school_idx}' GROUP BY std_gender";
        $result = $this->db->sqlRowArr($sql);
        return $result;
    }

    public function getGradeClass($school_idx)
    {
        $sql = "SELECT DISTINCT std_grade, std_class, COUNT(0) AS cnt FROM {$this->table_name} T WHERE T.school_idx = '{$school_idx}' GROUP BY std_grade, std_class";
        $result = $this->db->sqlRowArr($sql);
        return $result;
    }

    public function getGradeClassDetail($school_idx, $std_grade, $std_class)
    {
        $sql = "SELECT std_grade, std_class, std_no FROM {$this->table_name} T WHERE T.school_idx = '{$school_idx}' AND T.std_grade = '{$std_grade}' AND T.std_class = '{$std_class}'";
        $result = $this->db->sqlRowArr($sql);
        return $result;
    }

    public function getPasswordCheck($school_idx)
    {
        $sql = "SELECT TOP(1) manager_password FROM {$this->master_table_name} WHERE school_idx = '{$school_idx}'";
        $result = $this->db->sqlRow($sql);
        return $result;
    }
}
