<?php
include_once $_SERVER['DOCUMENT_ROOT'] . "/school/Controller/Controller.php";
include_once $_SERVER['DOCUMENT_ROOT'] . "/school/Model/ReadingDiagnosis.php";
include_once $_SERVER['DOCUMENT_ROOT'] . "/common/function.php";
class ReadingDiagnosisController extends Controller
{
    private $readingDiagnosisInfo;

    function __construct()
    {
        $this->readingDiagnosisInfo = new ReadingDiagnosisInfo();
    }


    public function readingDiagnosisInsert($request)
    {
        $school_idx = !empty($request['school_idx']) ? $request['school_idx'] : '';
        $school_type = !empty($request['school_type']) ? $request['school_type'] : '';
        $std_gender = !empty($request['std_gender']) ? $request['std_gender'] : '';
        $std_grade = !empty($request['std_grade']) ? $request['std_grade'] : '';
        $std_class = !empty($request['std_class']) ? $request['std_class'] : '';
        $std_no = !empty($request['std_no']) ? $request['std_no'] : '';
        $answer = !empty($request['answer']) ? $request['answer'] : '';
        try {
            if (empty($school_idx) || empty($school_type) || empty($std_gender) || empty($std_grade) || empty($std_class) || empty($std_no) || empty($answer)) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }

            $score_a_1 = 0;
            $score_a_2 = 0;
            $score_b_1 = 0;
            $score_b_2 = 0;
            $score_b_3 = 0;
            $score_c = 0;
            $score_d = 0;
            $pliterary_score = 0;
            $pnliterary_score = 0;
            $literary_score = 0;
            $nliterary_score = 0;
            $dblAve = 0;
            $dblDevSum = 0;

            $str_answer = implode("", $answer);

            for ($i = 0; $i <= 12; $i++) { // 13문항
                $score_a_1 += (int)substr($str_answer, $i, 1);
            }
            for ($i = 13; $i <= 23; $i++) { // 11문항
                $score_a_2 += (int)substr($str_answer, $i, 1);
            }
            for ($i = 24; $i <= 33; $i++) { // 10문항
                $score_b_1 += (int)substr($str_answer, $i, 1);
            }
            for ($i = 34; $i <= 45; $i++) { // 12문항
                $score_b_2 += (int)substr($str_answer, $i, 1);
            }
            for ($i = 46; $i <= 62; $i++) { // 17문항
                $score_b_3 += (int)substr($str_answer, $i, 1);
            }
            if ($school_type == "1" && $std_grade <= 2) {
                for ($i = 63; $i <= 74; $i++) { // 12문항
                    $score_c += (int)substr($str_answer, $i, 1);
                }
                for ($i = 75; $i <= 86; $i++) { // 12문항
                    $score_d += (int)substr($str_answer, $i, 1);
                }
                for ($i = 63; $i < 69; $i++) { // 과거 문학 6
                    $pliterary_score += (int)substr($str_answer, $i, 1);
                }
                for ($i = 69; $i < 73; $i++) { // 과거 비문학 4
                    $pnliterary_score += (int)substr($str_answer, $i, 1);
                }
                for ($i = 75; $i < 81; $i++) { // 현재 문학 6
                    $literary_score += (int)substr($str_answer, $i, 1);
                }
                for ($i = 81; $i < 85; $i++) { // 현재 비문학 4
                    $nliterary_score += (int)substr($str_answer, $i, 1);
                }
                $pliterary_score = round($pliterary_score * 100 / 30, 1);
                $pnliterary_score = round($pnliterary_score * 100 / 20, 1);
                $literary_score = round($literary_score * 100 / 30, 1);
                $nliterary_score = round($nliterary_score * 100 / 20, 1);
            } else {
                for ($i = 63; $i <= 81; $i++) { // 19문항
                    $score_c += (int)substr($str_answer, $i, 1);
                }
                for ($i = 82; $i <= 100; $i++) { // 19문항
                    $score_d += (int)substr($str_answer, $i, 1);
                }
                for ($i = 63; $i < 72; $i++) { // 과거 문학 9
                    $pliterary_score += (int)substr($str_answer, $i, 1);
                }
                for ($i = 72; $i < 82; $i++) { // 과거 비문학 10
                    $pnliterary_score += (int)substr($str_answer, $i, 1);
                }
                for ($i = 82; $i < 91; $i++) { // 현재 문학 9
                    $literary_score += (int)substr($str_answer, $i, 1);
                }
                for ($i = 91; $i < 101; $i++) { // 현재 비문학 10
                    $nliterary_score += (int)substr($str_answer, $i, 1);
                }
                $pliterary_score = round($pliterary_score * 100 / 45, 1);
                $pnliterary_score = round($pnliterary_score * 100 / 50, 1);
                $literary_score = round($literary_score * 100 / 45, 1);
                $nliterary_score = round($nliterary_score * 100 / 50, 1);
            }

            $rq_arr = explode(",", "5,1,1,1,1,5,1,1,1,1,6,1,1,1,1,6,1,1,1,1,7,1,1,1,1,7,1,1,1,1");
            $calc_grade = $std_grade;
            if ($school_type >= 2) {
                $calc_grade = 6;
            }
            $cCnt = 19;
            if ($school_type == "1" && $std_grade <= 2) {
                $cCnt = 12;
            }
            $a_rq = $rq_arr[$calc_grade * 5 - 5];
            $b_rq = $rq_arr[$calc_grade * 5 - 4];
            $c_rq = $rq_arr[$calc_grade * 5 - 3];
            $d_rq = $rq_arr[$calc_grade * 5 - 2];
            $e_rq = $rq_arr[$calc_grade * 5 - 1];

            $dblAve = round($score_c / $cCnt);
            if ($school_type == "1" && $std_grade <= 2) {
                for ($i = 63; $i <= 74; $i++) { // 12문항
                    $dblDevSum += pow((int)substr($str_answer, $i, 1) - $dblAve, 1);
                }
            } else {
                for ($i = 63; $i <= 81; $i++) { // 19문항
                    $dblDevSum += pow((int)substr($str_answer, $i, 1) - $dblAve, 1);
                }
            }
            $dblVrb = $dblDevSum / $cCnt;
            $dblStdev = round(sqrt($dblVrb), 1);

            $rq_rate = round((($score_a_1 + $score_a_2) / 2 * $b_rq + ($score_b_1 + $score_b_2 + $score_b_3) / 3 * $c_rq + ($score_c - $a_rq * $dblStdev) * $d_rq + ($score_d - $a_rq * $dblStdev) * $e_rq) / 4, 1);

            if ($school_type == "1" && $std_grade <= 2) {
                $params = array(
                    "school_idx" => $school_idx,
                    "std_gender" => $std_gender,
                    "std_grade" => $std_grade,
                    "std_class" => $std_class,
                    "std_no" => $std_no,
                    "std_answer" => $str_answer,
                    "score_a_1" => round($score_a_1 * 100 / 65),
                    "score_a_2" => round($score_a_2 * 100 / 55),
                    "score_b_1" => round($score_b_1 * 100 / 50),
                    "score_b_2" => round($score_b_2 * 100 / 60),
                    "score_b_3" => round($score_b_3 * 100 / 85),
                    "score_c" => round($score_c * 100 / 60),
                    "score_d" => round($score_d * 100 / 60),
                    "score_a_1_sum" => $score_a_1,
                    "score_a_2_sum" => $score_a_2,
                    "score_b_1_sum" => $score_b_1,
                    "score_b_2_sum" => $score_b_2,
                    "score_b_3_sum" => $score_b_3,
                    "score_c_sum" => $score_c,
                    "score_d_sum" => $score_d,
                    "score_pliterary" => $pliterary_score,
                    "score_literary" => $literary_score,
                    "score_nliterary" => $nliterary_score,
                    "score_pnliterary" => $pnliterary_score,
                    "rq_rate" => $rq_rate,
                );
            } else {
                $params = array(
                    "school_idx" => $school_idx,
                    "std_gender" => $std_gender,
                    "std_grade" => $std_grade,
                    "std_class" => $std_class,
                    "std_no" => $std_no,
                    "std_answer" => $str_answer,
                    "score_a_1" => round($score_a_1 * 100 / 65),
                    "score_a_2" => round($score_a_2 * 100 / 55),
                    "score_b_1" => round($score_b_1 * 100 / 50),
                    "score_b_2" => round($score_b_2 * 100 / 60),
                    "score_b_3" => round($score_b_3 * 100 / 85),
                    "score_c" => round($score_c * 100 / 95),
                    "score_d" => round($score_d * 100 / 95),
                    "score_a_1_sum" => $score_a_1,
                    "score_a_2_sum" => $score_a_2,
                    "score_b_1_sum" => $score_b_1,
                    "score_b_2_sum" => $score_b_2,
                    "score_b_3_sum" => $score_b_3,
                    "score_c_sum" => $score_c,
                    "score_d_sum" => $score_d,
                    "score_pliteraray" => $pliterary_score,
                    "score_literaray" => $literary_score,
                    "score_nliterary" => $nliterary_score,
                    "score_pnliterary" => $pnliterary_score,
                    "rq_rate" => $rq_rate,
                );
            }

            $result = $this->readingDiagnosisInfo->insert($params);
            if ($result) {
                $return_data['msg'] = "독서이력진단 기록이 등록되었습니다.";
            } else {
                throw new Exception('독서이력진단 기록에 실패했습니다. 관리자에게 문의하세요.', 701);
            }
            return $return_data;
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }

    public function getDiagnosisResult1($request)
    {
        $school_idx = !empty($request['school_idx']) ? $request['school_idx'] : '';
        $std_grade = !empty($request['std_grade']) ? $request['std_grade'] : '';
        $std_class = !empty($request['std_class']) ? $request['std_class'] : '';
        $std_no = !empty($request['std_no']) ? $request['std_no'] : '';

        try {
            if (empty($school_idx) || empty($std_grade) || empty($std_class) || empty($std_no)) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }

            $result = $this->readingDiagnosisInfo->getDiagnosisResult1($school_idx, $std_grade, $std_class, $std_no);
            $comment1 = "우수 / 더욱 노력하기 바랍니다.";
            $comment2 = "보통 / 대책이 필요합니다.";
            $comment3 = "미흡 / 관심과 대책이 필요합니다.";
            if ($result) {
                if ($result[0]['score_a_1'] >= 70.0) {
                    $result[0]['score_a_1_c'] = $comment1;
                } else if ($result[0]['score_a_1'] < 70.0 && $result[0]['score_a_1'] >= 50.0) {
                    $result[0]['score_a_1_c'] = $comment2;
                } else if ($result[0]['score_a_1'] < 50.0) {
                    $result[0]['score_a_1_c'] = $comment3;
                }
                if ($result[0]['score_a_2'] >= 70.0) {
                    $result[0]['score_a_2_c'] = $comment1;
                } else if ($result[0]['score_a_2'] < 70.0 && $result[0]['score_a_2'] >= 50.0) {
                    $result[0]['score_a_2_c'] = $comment2;
                } else if ($result[0]['score_a_2'] < 50.0) {
                    $result[0]['score_a_2_c'] = $comment3;
                }
                if ($result[0]['score_a'] >= 70.0) {
                    $result[0]['score_a_c'] = $comment1;
                } else if ($result[0]['score_a'] < 70.0 && $result[0]['score_a'] >= 50.0) {
                    $result[0]['score_a_c'] = $comment2;
                } else if ($result[0]['score_a'] < 50.0) {
                    $result[0]['score_a_c'] = $comment3;
                }
                if ($result[0]['score_b_1'] >= 70.0) {
                    $result[0]['score_b_1_c'] = $comment1;
                } else if ($result[0]['score_b_1'] < 70.0 && $result[0]['score_b_1'] >= 50.0) {
                    $result[0]['score_b_1_c'] = $comment2;
                } else if ($result[0]['score_a'] < 50.0) {
                    $result[0]['score_b_1_c'] = $comment3;
                }
                if ($result[0]['score_b_2'] >= 70.0) {
                    $result[0]['score_b_2_c'] = $comment1;
                } else if ($result[0]['score_b_2'] < 70.0 && $result[0]['score_b_2'] >= 50.0) {
                    $result[0]['score_b_2_c'] = $comment2;
                } else if ($result[0]['score_b_2'] < 50.0) {
                    $result[0]['score_b_2_c'] = $comment3;
                }
                if ($result[0]['score_b_3'] >= 70.0) {
                    $result[0]['score_b_3_c'] = $comment1;
                } else if ($result[0]['score_b_3'] < 70.0 && $result[0]['score_b_3'] >= 50.0) {
                    $result[0]['score_b_3_c'] = $comment2;
                } else if ($result[0]['score_b_3'] < 50.0) {
                    $result[0]['score_b_3_c'] = $comment3;
                }
                if ($result[0]['score_b'] >= 70.0) {
                    $result[0]['score_b_c'] = $comment1;
                } else if ($result[0]['score_b'] < 70.0 && $result[0]['score_b'] >= 50.0) {
                    $result[0]['score_b_c'] = $comment2;
                } else if ($result[0]['score_b'] < 50.0) {
                    $result[0]['score_b_c'] = $comment3;
                }
                if ($result[0]['score_c'] >= 70.0) {
                    $result[0]['score_c_c'] = $comment1;
                } else if ($result[0]['score_c'] < 70.0 && $result[0]['score_c'] >= 50.0) {
                    $result[0]['score_c_c'] = $comment2;
                } else if ($result[0]['score_c'] < 50.0) {
                    $result[0]['score_c_c'] = $comment3;
                }
                if ($result[0]['score_d'] >= 70.0) {
                    $result[0]['score_d_c'] = $comment1;
                } else if ($result[0]['score_d'] < 70.0 && $result[0]['score_d'] >= 50.0) {
                    $result[0]['score_d_c'] = $comment2;
                } else if ($result[0]['score_d'] < 50.0) {
                    $result[0]['score_d_c'] = $comment3;
                }
                $literary_cnt_arr = array();
                $pliterary_cnt_arr = array();
                $literary_list = "";
                $nliterary_cnt_arr = array();
                $pnliterary_cnt_arr = array();
                $nliterary_list = "";
                if ($result[0]["school_type"] == "1" && $std_grade <= 2) {
                    $literary_list = '세계명작,전래동화,그림동화,창작동화,동시,위인전';
                    $nliterary_list = '사회문화,과학환경,논리철학,수학흥미';
                    for ($i = 63; $i < 69; $i++) { // 과거 문학 6
                        $pliterary_cnt_arr[] .= (int)substr($result[0]['std_answer'], $i, 1);
                    }
                    for ($i = 69; $i < 73; $i++) { // 과거 비문학 4
                        $pnliterary_cnt_arr[] .= (int)substr($result[0]['std_answer'], $i, 1);
                    }
                    for ($i = 75; $i < 81; $i++) { // 현재 문학 6
                        $literary_cnt_arr[] .= (int)substr($result[0]['std_answer'], $i, 1);
                    }
                    for ($i = 81; $i < 85; $i++) { // 현재 비문학 4
                        $nliterary_cnt_arr[] .= (int)substr($result[0]['std_answer'], $i, 1);
                    }
                } else {
                    $literary_list = '창작동화,전래동화,세계명작,동요시집,또래 주인공 삶을 그린 소설,실제생활을 그린 창작소설,글쓴이의 생활경험을 그린 책(수필),위인전기,고전문학';
                    $nliterary_list = '사회문화,과학환경,수학흥미,한국사,세계사,법과정치,경제경영,문화예술,철학논리,자기 계발서';
                    for ($i = 63; $i < 72; $i++) { // 과거 문학 9
                        $pliterary_cnt_arr[] .= (int)substr($result[0]['std_answer'], $i, 1);
                    }
                    for ($i = 72; $i < 82; $i++) { // 과거 비문학 10
                        $pnliterary_cnt_arr[] .= (int)substr($result[0]['std_answer'], $i, 1);
                    }
                    for ($i = 82; $i < 91; $i++) { // 현재 문학 9
                        $literary_cnt_arr[] .= (int)substr($result[0]['std_answer'], $i, 1);
                    }
                    for ($i = 91; $i < 101; $i++) { // 현재 비문학 10
                        $nliterary_cnt_arr[] .= (int)substr($result[0]['std_answer'], $i, 1);
                    }
                }
                $result[0]["score_lnliterary_sum_avg"] = round(($result[0]["score_literary_avg"] + $result[0]["score_nliterary_avg"]) / 2, 1);
                $result[1]["score_lnliterary_sum_avg"] = round(($result[1]["score_literary_avg"] + $result[1]["score_nliterary_avg"]) / 2, 1);
                $result[2]["score_lnliterary_sum_avg"] = round(($result[2]["score_literary_avg"] + $result[2]["score_nliterary_avg"]) / 2, 1);
                $result[3]["score_lnliterary_sum_avg"] = round(($result[3]["score_literary_avg"] + $result[3]["score_nliterary_avg"]) / 2, 1);
                $return_data = $result;
                $return_data['literary_cnt_arr'] = $literary_cnt_arr;
                $return_data['pliterary_cnt_arr'] = $pliterary_cnt_arr;
                $return_data['nliterary_cnt_arr'] = $nliterary_cnt_arr;
                $return_data['pnliterary_cnt_arr'] = $pnliterary_cnt_arr;
                $return_data['literary_list'] = explode(",", $literary_list);
                $return_data['nliterary_list'] = explode(",", $nliterary_list);
            }
            return $return_data;
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }

    public function getTotalAnalytics($request)
    {
        $school_idx = !empty($request['school_idx']) ? $request['school_idx'] : '';

        try {
            if (empty($school_idx)) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }

            $result = $this->readingDiagnosisInfo->getTotalAnalytics($school_idx);
            return $result;
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }

    public function getGradeAnalytics($request)
    {
        $school_idx = !empty($request['school_idx']) ? $request['school_idx'] : '';

        try {
            if (empty($school_idx)) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }

            $result = $this->readingDiagnosisInfo->getGradeAnalytics($school_idx);
            return $result;
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }

    public function getClassAnalytics($request)
    {
        $school_idx = !empty($request['school_idx']) ? $request['school_idx'] : '';

        try {
            if (empty($school_idx)) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }

            $result = $this->readingDiagnosisInfo->getClassAnalytics($school_idx);
            return $result;
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }

    public function getGenderAnalytics($request)
    {
        $school_idx = !empty($request['school_idx']) ? $request['school_idx'] : '';

        try {
            if (empty($school_idx)) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }

            $result = $this->readingDiagnosisInfo->getGenderAnalytics($school_idx);
            return $result;
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }

    public function getGradeClass($request)
    {
        $school_idx = !empty($request['school_idx']) ? $request['school_idx'] : '';

        try {
            if (empty($school_idx)) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }

            $result = $this->readingDiagnosisInfo->getGradeClass($school_idx);
            return $result;
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }

    public function getGradeClassDetail($request)
    {
        $school_idx = !empty($request['school_idx']) ? $request['school_idx'] : '';
        $std_grade = !empty($request['std_grade']) ? $request['std_grade'] : '';
        $std_class = !empty($request['std_class']) ? $request['std_class'] : '';

        try {
            if (empty($school_idx) || empty($std_grade) || empty($std_class)) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }

            $result = $this->readingDiagnosisInfo->getGradeClassDetail($school_idx, $std_grade, $std_class);

            if ($result) {
                foreach ($result as $key => $val) {
                    $result[$key]["view_btn"] = "<button type=\"button\" class=\"btn btn-sm btn-outline-success view_btn\" onclick=\"btnViewerClick({$std_grade},{$std_class},{$val['std_no']})\">결과보기</button>";
                }
            }
            return $result;
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }

    public function getPasswordCheck($request)
    {
        $school_idx = !empty($request['school_idx']) ? $request['school_idx'] : '';
        $current_password = !empty($request['current_password']) ? $request['current_password'] : '';

        try {
            if (empty($school_idx) || empty($current_password)) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }

            $result = $this->readingDiagnosisInfo->getPasswordCheck($school_idx);
            if (!empty($result)) {
                if (password_verify($current_password, $result["manager_password"])) {
                    $return_data['chk'] = "t";
                } else {
                    $return_data['chk'] = "f";
                }
            } else {
                throw new Exception('학교정보를 확인할 수 없습니다.', 701);
            }
            return $return_data;
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }

    public function accountInfoUpdate($request)
    {
        $school_idx = !empty($request['school_idx']) ? $request['school_idx'] : '';
        $manager_email = !empty($request['manager_email']) ? $request['manager_email'] : '';
        $manager_name = !empty($request['manager_name']) ? $request['manager_name'] : '';
        $manager_tel = !empty($request['manager_tel']) ? $request['manager_tel'] : '';
        $manager_hp = !empty($request['manager_hp']) ? $request['manager_hp'] : '';
        $manager_password = !empty($request['password']) ? $request['password'] : '';
        try {
            if (empty($school_idx) || empty($manager_email) || empty($manager_name) || empty($manager_tel) || empty($manager_hp) || empty($manager_password)) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }

            $manager_password = password_hash($manager_password, PASSWORD_DEFAULT);

            $params = array(
                "manager_email" => !empty($manager_email) ? $manager_email : '',
                "manager_name" => !empty($manager_name) ? $manager_name : '',
                "manager_tel" => !empty($manager_tel) ? $manager_tel : '',
                "manager_hp" => !empty($manager_hp) ? $manager_hp : '',
                "manager_password" => !empty($manager_password) ? $manager_password : '',
                "mod_date" => "getdate()"
            );

            $this->readingDiagnosisInfo->where_qry = " school_idx = '{$school_idx}' ";
            $this->readingDiagnosisInfo->table_name = "school_infoM";
            $result = $this->readingDiagnosisInfo->update($params);
            if (!empty($result)) {
                $return_data['msg'] = "계정 정보가 수정되었습니다.";
            } else {
                throw new Exception('계정 정보 수정에 실패했습니다.', 701);
            }
            return $return_data;
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }
}

$readingDiagnosisController = new ReadingDiagnosisController();
