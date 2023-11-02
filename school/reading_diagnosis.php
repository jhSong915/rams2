<?php
$access_token = !empty($_POST["access_token"]) ? $_POST["access_token"] : "";
$std_school = !empty($_POST["school_idx"]) ? $_POST["school_idx"] : "";
$std_school_type = !empty($_POST["school_type"]) ? $_POST["school_type"] : "";
$std_gender = !empty($_POST["std_gender"]) ? $_POST["std_gender"] : "";
$std_grade = !empty($_POST["std_grade"]) ? $_POST["std_grade"] : "";
$std_class = !empty($_POST["std_class"]) ? $_POST["std_class"] : "";
$std_no = !empty($_POST["std_no"]) ? $_POST["std_no"] : "";

if (empty($std_school) || empty($std_school_type) || empty($std_gender) || empty($std_grade) || empty($std_class) || empty($std_no)) {
    echo "<script>alert('잘못된 접근입니다.'); location.href='/school/login.php';</script>";
    exit;
}
require_once $_SERVER['DOCUMENT_ROOT'] . "/common/dbClass.php";
$db = new DBCmp();

include_once $_SERVER["DOCUMENT_ROOT"] . "/common/common_script2.php";
?>
<script src="js/reading_diagnosis.js?v=<?= date('YmdHis') ?>"></script>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-7">
            <div class="card border-left-primary shadow mt-3">
                <div class="card-header">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h6 id="lblTitle" class="text-primary">도서선택과 이력관리 영역</h6>
                        </div>
                        <div>
                            <h6 id="lblSubTitle" class="text-muted">도서 선택 능력</h6>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="progress mb-3">
                        <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" style="width: 0%;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">0%</div>
                    </div>
                    <form id="reading_diagnosis_form" method="post">
                        <input type="hidden" id="hd_rd_school" value="<?= $std_school ?>" />
                        <input type="hidden" id="hd_rd_school_type" value="<?= $std_school_type ?>" />
                        <input type="hidden" id="hd_rd_Gender" value="<?= $std_gender ?>" />
                        <input type="hidden" id="hd_rd_Grade" value="<?= $std_grade ?>" />
                        <input type="hidden" id="hd_rd_Class" value="<?= $std_class ?>" />
                        <input type="hidden" id="hd_rd_No" value="<?= $std_no ?>" />
                    </form>
                    <div id="questionDiv">
                        <div class="form-floating mb-3">
                            <input type="text" id="txtQuestion" class="form-control bg-white" placeholder="문제 1" value="나는 수많은 책 중 어떤 책을 골라 읽을지 막막하다." readonly />
                            <label id="lblquiz" for="txtQuestion">문제 1</label>
                        </div>
                        <div class="input-group">
                            <div class="form-check form-check-inline">
                                <input type="radio" id="rdo1" class="form-check-input" name="rdoQuiz" value="5" />
                                <label id="lbl1" class="form-check-label qlabel" for="rdo1">1&#46; 정말아니다</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input type="radio" id="rdo2" class="form-check-input" name="rdoQuiz" value="4" />
                                <label id="lbl2" class="form-check-label qlabel" for="rdo2">2&#46; 아닌편이다</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input type="radio" id="rdo3" class="form-check-input" name="rdoQuiz" value="3" />
                                <label id="lbl3" class="form-check-label qlabel" for="rdo3">3&#46; 그저그렇다</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input type="radio" id="rdo4" class="form-check-input" name="rdoQuiz" value="2" />
                                <label id="lbl4" class="form-check-label qlabel" for="rdo4">4&#46; 그런편이다</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input type="radio" id="rdo5" class="form-check-input" name="rdoQuiz" value="1" />
                                <label id="lbl5" class="form-check-label qlabel" for="rdo5">5&#46; 정말그렇다</label>
                            </div>
                        </div>
                    </div>
                    <div id="endDiv" style="display: none;"></div>
                    <div class="text-end mt-2">
                        <button type="button" id="btnPrev" class="btn btn-outline-primary" style="display: none;">이전 문제</button>
                        <button type="button" id="btnNext" class="btn btn-outline-primary">다음 문제</button>
                        <button type="button" id="btnSend" class="btn btn-outline-success" style="display: none;">제출</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var answer = new Array();
    var score = new Array();
    var question = new Array();
    var prev_answer = "";
    var count = 0;
</script>