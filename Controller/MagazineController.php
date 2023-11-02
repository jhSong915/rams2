<?php
include_once $_SERVER['DOCUMENT_ROOT'] . "/Controller/Controller.php";
include_once $_SERVER['DOCUMENT_ROOT'] . "/Model/Magazine.php";

class MagazineController extends Controller
{
    private $magazineInfo;

    function __construct()
    {
        $this->magazineInfo = new MagazineInfo();
    }

    public function magazineInsert($request)
    {
        $title = !empty($request['title']) ? $request['title'] : '';
        $franchise_idx = !empty($request['franchise_idx']) ? $request['franchise_idx'] : '';
        $months = !empty($request['months']) ? $request['months'] : '';
        $season = !empty($request['season']) ? $request['season'] : '';
        $pdf_link = !empty($request['pdf_link']) ? htmlspecialchars($request['pdf_link']) : '';

        try {
            if (empty($title)  || empty($months) || empty($season) || empty($franchise_idx) || empty($pdf_link) || empty($_FILES['file1'])) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }

            $params = array(
                "title"     => !empty($title) ? $title : '',
                "franchise_idx" => !empty($franchise_idx) ? $franchise_idx : '',
                "months" => !empty($months) ? $months : '',
                "season" => !empty($season) ? $season : '',
                "pdf_link" => !empty($pdf_link) ? $pdf_link : ''
            );

            //썸네일
            $nameArr1 = explode(".", $_FILES['file1']['name']);
            $extension1 = end($nameArr1);
            $file_name1 = $title . "." . $extension1;

            $path = $_SERVER['DOCUMENT_ROOT'] . "/files/magazine_file/";
            copy($_FILES['file1']['tmp_name'], $path . $file_name1);
            $params['thumbnail_name'] = $file_name1;

            $result = $this->magazineInfo->insert($params);

            if ($result) {
                $return_data['msg'] = '매거진이 등록되었습니다.';
            } else {
                throw new Exception('매거진 등록에 실패하였습니다.', 701);
            }

            return $return_data;
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }

    public function magazineUpdate($request)
    {
        $magazine_idx = !empty($request['magazine_idx']) ? $request['magazine_idx'] : '';
        $title = !empty($request['title']) ? $request['title'] : '';
        $franchise_idx = !empty($request['franchise_idx']) ? $request['franchise_idx'] : '';
        $months = !empty($request['months']) ? $request['months'] : '';
        $season = !empty($request['season']) ? $request['season'] : '';
        $pdf_link = !empty($request['pdf_link']) ? htmlspecialchars($request['pdf_link']) : '';

        try {
            if (empty($magazine_idx) || empty($title) || empty($months) || empty($season) || empty($franchise_idx) || empty($pdf_link)) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }

            $params = array(
                "title"     => !empty($title) ? $title : '',
                "franchise_idx" => !empty($franchise_idx) ? $franchise_idx : '',
                "months" => !empty($months) ? $months : '',
                "season" => !empty($season) ? $season : '',
                "pdf_link" => !empty($pdf_link) ? $pdf_link : ''
            );

            if (!empty($_FILES['file1'])) {
                //썸네일
                $nameArr1 = explode(".", $_FILES['file1']['name']);
                $extension1 = end($nameArr1);
                $file_name1 = $title . "." . $extension1;

                $path = $_SERVER['DOCUMENT_ROOT'] . "/files/magazine_file/";
                copy($_FILES['file1']['tmp_name'], $path . $file_name1);
                $params['thumbnail_name'] = $file_name1;
            }

            $this->magazineInfo->where_qry = " magazine_idx = '" . $magazine_idx . "'";
            $result = $this->magazineInfo->update($params);

            if ($result) {
                $return_data['msg'] = '매거진이 수정되었습니다.';
            } else {
                throw new Exception('매거진 수정에 실패하였습니다.', 701);
            }

            return $return_data;
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }

    public function magazineLoad($params)
    {
        $season = !empty($params['season']) ? $params['season'] : '01';

        try {
            $result = $this->magazineInfo->magazineLoad($season);

            return $result;
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }

    public function magazineSelect($params)
    {
        $magazine_idx = !empty($params['magazine_idx']) ? $params['magazine_idx'] : '';

        try {
            if (empty($magazine_idx)) {
                throw new Exception('필수값이 누락되었습니다.', 701);
            }
            $result = $this->magazineInfo->magazineSelect($magazine_idx);

            return $result;
        } catch (Exception $e) {
            return $this->getMsgException($e);
        }
    }
}


$magazineController = new MagazineController();