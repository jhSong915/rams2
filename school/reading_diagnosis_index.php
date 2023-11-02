<?php
include_once $_SERVER["DOCUMENT_ROOT"] . "/common/common_script2.php";
$access_token = !empty($_GET["ackt"]) ? $_GET["ackt"] : "";

if (empty($access_token)) {
    echo "<script>alert('잘못된 접근입니다.'); location.href='/school/login.php';</script>";
    exit;
}
require_once $_SERVER['DOCUMENT_ROOT'] . "/common/dbClass.php";
$db = new DBCmp();
$sql = "SELECT school_idx, school_type, school_name, start_date, expire_date FROM school_infoM WHERE access_token = '{$access_token}'";
$result = $db->sqlRow($sql);
if (empty($result)) {
    echo "<script>alert(\"학교 정보가 확인되지 않습니다. 관리자에게 문의하시기 바랍니다.\");</script>";
    exit;
}
if (date("Y-m-d") > $result['expire_date']) {
    echo "<script>alert(\"진단기간이 종료되었습니다. 관리자에게 문의하시기 바랍니다.\");</script>";
    exit;
}

$school_idx = $result['school_idx'];
$school_type = $result['school_type'];
$school_name = $result['school_name'];
?>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-7">
            <div class="card border-left-primary shadow mt-3">
                <div class="card-header">
                    <h6>도서이력진단 정보입력</h6>
                </div>
                <div class="card-body">
                    <form id="diagnosisBasicInfoForm" method="post" action="reading_diagnosis.php">
                        <div class="input-group mb-2">
                            <input type="hidden" id="hdschool_idx" name="school_idx" value="<?= $school_idx ?>" />
                            <input type="hidden" id="hdschool_type" name="school_type" value="<?= $school_type ?>" />
                            <input type="hidden" id="hdaccess_token" name="access_token" value="<?= $access_token ?>" />
                            <div class="form-floating">
                                <input type="text" id="txtSchoolName" class="form-control" value="<?= $school_name ?>" placeholder="학교 이름" readonly />
                                <label for="txtSchoolName">학교 이름</label>
                            </div>
                        </div>
                        <div class="input-group mb-2">
                            <div class="form-inline me-2">
                                <div class="form-floating">
                                    <select id="selSchoolGrade" class="form-select" name="std_grade">
                                        <option value="" selected disabled>선택</option>
                                        <option value="1">1학년</option>
                                        <option value="2">2학년</option>
                                        <option value="3">3학년</option>
                                        <?php
                                        if ($school_type < 2) {
                                            echo "<option value=\"4\">4학년</option>
                                                <option value=\"5\">5학년</option>
                                                <option value=\"6\">6학년</option>";
                                        }
                                        ?>

                                    </select>
                                    <label for="selSchoolGrade">학년</label>
                                </div>
                            </div>
                            <div class="form-inline me-2">
                                <div class="form-floating">
                                    <input type="number" id="txtSchoolClass" class="form-control" name="std_class" min="1" max="99" maxlength="2" value="" placeholder="반" oninput="maxLengthCheck2Number(this);" />
                                    <label for="txtSchoolClass">반</label>
                                </div>
                            </div>
                            <div class="form-inline me-3">
                                <div class="form-floating">
                                    <input type="number" id="txt_std_no" class="form-control" name="std_no" min="1" max="999" maxlength="3" value="" placeholder="번호" oninput="maxLengthCheck2Number(this);" />
                                    <label for="txt_std_no">번호</label>
                                </div>
                            </div>
                            <div class="form-check-inline align-self-center me-2">
                                <input type="radio" id="rdoGender1" class="form-check-input" name="std_gender" value="1" checked />
                                <label for="rdoGender1">남자</label>
                            </div>
                            <div class="form-check-inline align-self-center">
                                <input type="radio" id="rdoGender2" class="form-check-input" name="std_gender" value="2" />
                                <label for="rdoGender2">여자</label>
                            </div>
                        </div>
                        <div class="text-end">
                            <button type="button" id="btnStartDiagnosis" class="btn btn-sm btn-outline-primary">검사진행하기</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        $("#btnStartDiagnosis").click(function() {
            var school_idx = $("#hdschool_idx").val();
            var std_grade = $("#selSchoolGrade").val();
            var std_class = $("#txtSchoolClass").val();
            var std_no = $("#txt_std_no").val();
            var gender = $("input:radio[name=std_gender]").val();

            if (!school_idx) {
                alert("학교정보를 확인할 수 없습니다. 관리자에게 문의하세요.");
                return false;
            }
            if (!std_grade) {
                alert("학년을 선택해주세요.");
                $("#selSchoolGrade").focus();
                return false;
            }
            if (!std_class) {
                alert("반을 입력해주세요.");
                $("#txtSchoolClass").focus();
                return false;
            }
            if (!std_no) {
                alert("번호를 입력해주세요.");
                $("#txt_std_no").focus();
                return false;
            }
            if (!gender || gender < 1 || gender > 2) {
                alert("성별을 선택해주세요.");
                return false;
            }
            $("#diagnosisBasicInfoForm").submit();
        });
    });

    function maxLengthCheck2Number(object) {
        if (object.value.length > object.maxLength) {
            object.value = object.value.slice(0, object.maxLength);
        }
    }
</script>