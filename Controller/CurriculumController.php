<?php
include_once $_SERVER['DOCUMENT_ROOT'] . "/Controller/Controller.php";
include_once $_SERVER['DOCUMENT_ROOT'] . "/Model/Curriculum.php";

class CurriculumController extends Controller
{
    private $curriculumInfo;

    function __construct()
    {
        $this->curriculumInfo = new CurriculumInfo();
    }

    //커리큘럼 등록
    public function curriculumInsert($request)
    {
        $book_idx  = !empty($request['book_idx']) ? $request['book_idx'] : '';
        $odr       = !empty($request['odr']) ? $request['odr'] : '';
        $month     = !empty($request['month']) ? $request['month'] : '';
        $grade     = !empty($request['grade']) ? $request['grade'] : '';

        try{
            if (empty($book_idx) || empty($odr) || empty($month) || empty($grade)) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }

            if( ($month == '00') || ($grade == '00') ){
                throw new Exception('월 및 학년을 지정하여 등록하세요.', 701);
            }

            $params = array(
                "book_idx" => $book_idx,
                "orders" => $odr,
                "months" => $month,
                "grade" => $grade
            );

            $result = $this->curriculumInfo->insert($params);

            if($result){
                $return_data['msg'] = '커리큘럼이 등록되었습니다.';
                return $return_data;
            }else{
                throw new Exception('커리큘럼 등록에 실패하였습니다.', 701);
            }
        }catch(Exception $e){
            return $this->getMsgException($e);
        }
    }

    //커리큘럼 수정
    public function curriculumUpadte($request)
    {
        $curriculum_idx = !empty($request['curriculum_idx']) ? $request['curriculum_idx'] : '';
        $book_idx       = !empty($request['book_idx']) ? $request['book_idx'] : '';
        $odr            = !empty($request['odr']) ? $request['odr'] : '';
        $month          = !empty($request['month']) ? $request['month'] : '';
        $grade          = !empty($request['grade']) ? $request['grade'] : '';

        try{
            if (empty($curriculum_idx) || empty($book_idx) || empty($odr) || empty($month) || empty($grade)) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }

            if( ($month == '00') || ($grade == '00') ){
                throw new Exception('월 및 학년을 지정하여 등록하세요.', 701);
            }

            $params = array(
                "book_idx" => $book_idx,
                "orders" => $odr,
                "months" => $month,
                "grade" => $grade,
                "mod_date" => "NOW()"
            );

            $this->curriculumInfo->where_qry = " curriculum_idx = '{$curriculum_idx}'";
            $result = $this->curriculumInfo->update($params);

            if($result){
                $return_data['msg'] = '커리큘럼이 수정되었습니다.';
                return $return_data;
            }else{
                throw new Exception('커리큘럼이 수정에 실패하였습니다.', 701);
            }
        }catch(Exception $e){
            return $this->getMsgException($e);
        }
    }

    //커리큘럼 삭제
    public function curriculumDelete($request)
    {
        $curriculum_idx = !empty($request['curriculum_idx']) ? $request['curriculum_idx'] : '';

        try{
            if (empty($curriculum_idx)) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }

            $this->curriculumInfo->where_qry = " curriculum_idx = '{$curriculum_idx}'";
            $result = $this->curriculumInfo->delete();

            if($result){
                $return_data['msg'] = '커리큘럼이 삭제되었습니다.';
                return $return_data;
            }else{
                throw new Exception('커리큘럼이 삭제에 실패하였습니다.', 701);
            }
        }catch(Exception $e){
            return $this->getMsgException($e);
        }
    }

    //커리큘럼 불러오기
    public function curriculumLoad($request)
    {
        $month     = !empty($request['month']) ? $request['month'] : '';
        $grade     = !empty($request['grade']) ? $request['grade'] : '';

        try{
            $params = array(
                "months" => ($month != '00') ? $month : '',
                "grade" => ($grade != '00') ? $grade : ''
            );

            $result = $this->curriculumInfo->curriculumLoad($params);

            return $result;
        }catch(Exception $e){
            return $this->getMsgException($e);
        }
        
    }
}

$curriculumController = new CurriculumController();