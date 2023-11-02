<?php
include_once $_SERVER["DOCUMENT_ROOT"] . "/_config/session_start.php";
$school_idx = !empty($_SESSION["school_idx"]) ? $_SESSION["school_idx"] : "";
if (empty($school_idx)) {
    echo "<script>alert('잘못된 접근입니다.'); location.href='/school/login.php';</script>";
    exit;
}
include_once $_SERVER["DOCUMENT_ROOT"] . "/common/common_script2.php";
?>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/datatables.net-bs5/1.13.6/dataTables.bootstrap5.min.css" integrity="sha512-lh4coC5XUFMaH3vP6Xx6Rab4J0rm4ojKwQKZoawqk325K9e2PMGf2GZreDeYnetVTIoWpYsEphDS0Zy0QFYOFQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/datatables.net/1.13.6/jquery.dataTables.min.js" integrity="sha512-9v5y60iGzsycBi0bAsa5HMxnOfwME+llnA2KPdxv84En3cb+ZUlvfyFyFL0nR+EU2Jal6JePdsa+n5oMi82owQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/datatables.net-bs5/1.13.6/dataTables.bootstrap5.min.js" integrity="sha512-5rbrNGcjwSM6QsgvTO4USzLW98mfdXKsM807ENaySDbgb4PCZkrf3pwZkcBo9wXpUC89XvJIwPN+FoT9TOFp9w==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.0/chart.umd.min.js" integrity="sha512-SIMGYRUjwY8+gKg7nn9EItdD8LCADSDfJNutF9TPrvEo86sQmFMh6MyralfIyhADlajSxqc7G0gs7+MwWF/ogQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.qrcode/1.0/jquery.qrcode.min.js" integrity="sha512-NFUcDlm4V+a2sjPX7gREIXgCSFja9cHtKPOL1zj6QhnE0vcY695MODehqkaGYTLyL2wxe/wtr4Z49SvqXq12UQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js" integrity="sha512-BNaRQnYJYiPSqHHDb58B0yaPfCu+Wgds8Gp/gU33kqBtgNS4tSPHuGibyoeqMV/TJlSKda6FXzoEyYGjTe+vXA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>
    var access_token = "<?= $_SESSION["access_token"] ?>";
    var pw_chk = false;
</script>
<script src="js/reading_diagnosis_analytics.js"></script>
<main>
    <div class="container-fluid">
        <header class="d-flex flex-wrap justify-content-center py-2 mb-4 border-bottom bg-light">
            <a href="/" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-body-emphasis text-decoration-none">
                <i class="fa-solid fa-school me-2"></i>
                <span class="fs-4"><?= $_SESSION['school_name'] ?> 독서이력진단 검사 결과</span>
            </a>
            <ul class="nav nav-pills me-2">
                <?php
                if ($_SESSION["order_state"] != '02') {
                ?>
                    <input type="hidden" id="HdOrderState" value="<?= $_SESSION["order_state"] ?>" />
                    <input type="hidden" id="hd_order_num" name="order_num" value="<?= $_SESSION["order_num"] ?>" />
                    <input type="hidden" id="hdPrice" name="pay_amount" value="<?= $_SESSION['order_money'] ?>" />
                    <input type="hidden" id="hdPrice2" name="pay_tax_free_amount" value="0" />
                    <input type="hidden" id="hd_order_type" name="order_type" value="s" />
                    <input type="hidden" id="hd_order_name" name="order_name" value="독서이력진단 결제" />
                    <li class="nav-item align-self-center me-1">
                        <div class="form-floating">
                            <input type="text" id="txtOrderMoney" class="form-control" value="<?= $_SESSION["order_money"] ?>" placeholder="결제금액" disabled />
                            <label for="txtOrderState">결제금액</label>
                        </div>
                    </li>
                    <li class="nav-item align-self-center me-1">
                        <div class="form-floating">
                            <select id="selChargeMethod" class="form-select" name="pay_method">
                                <option value="CARD">카드</option>
                                <option value="TRANSFER">계좌이체</option>
                            </select>
                            <label for="selChargeMethod">결제방법</label>
                        </div>
                    </li>
                    <li class="nav-item align-self-center me-1">
                        <button type="button" id="btnPayment" class="btn btn-sm btn-outline-success"><i class="fa-solid fa-link me-1"></i>결제하기</button>
                    </li>
                <?php
                } else {
                ?>
                    <li class="nav-item align-self-center me-2">
                        <a id="btnLinkQRCode" class="btn btn-sm btn-outline-success" href="#GenerateDiagnosisLinkModal" data-bs-toggle="modal" data-bs-traget="#GenerateDiagnosisLinkModal"><i class="fa-solid fa-link me-1"></i>진단검사 링크</a>
                    </li>
                <?php
                }
                ?>
                <li class="nav-item align-self-center me-1">
                    <div class="form-floating">
                        <input type="text" id="txtOrderState" class="form-control" value="<?= $_SESSION["order_state_txt"] ?>" placeholder="결제상태" disabled />
                        <label for="txtOrderState">결제상태</label>
                    </div>
                </li>
                <li class="nav-item align-self-center me-1">
                    <div class="form-floating">
                        <input type="date" id="dt_start_date" class="form-control" value="<?= date('Y-m-d', strtotime($_SESSION['start_date'])) ?>" disabled />
                        <label for="dt_start_date">검사시작일</label>
                    </div>
                </li>
                <li class="nav-item align-self-center">
                    <div class="form-floating">
                        <input type="date" id="dt_expire_date" class="form-control" value="<?= date('Y-m-d', strtotime($_SESSION['expire_date'])) ?>" disabled />
                        <label for="dt_expire_date">검사종료일</label>
                    </div>
                </li>
            </ul>
            <div class="flex-shrink-0 align-self-center dropdown ms-2 me-3">
                <a href="#" class="d-block link-body-emphasis text-decoration-none dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false"><i class="fa-regular fa-user me-2"></i><?= ($_SESSION['manager_name'] . " 님") ?></a>
                <ul class="dropdown-menu text-small shadow">
                    <li><a class="dropdown-item" href="#AcoountUpdateModal" data-bs-toggle="modal" data-bs-traget="#AcoountUpdateModal">계정정보 변경</a></li>
                    <li><a class="dropdown-item" href="logout.php">로그아웃</a></li>
                </ul>
            </div>
        </header>
        <hr>
        <form id="resultViewerFrom" action="reading_diagnosis_result.php" method="post" target="_blank">
            <input type="hidden" id="hd_school_idx" name="school_idx" value="<?= $school_idx ?>" />
            <input type="hidden" id="hd_std_grade" name="std_grade" value="" />
            <input type="hidden" id="hd_std_class" name="std_class" value="" />
            <input type="hidden" id="hd_std_no" name="std_no" value="" />
        </form>
        <div class="row">
            <div class="col-4">
                <div class="card border-left-primary shadow mt-3">
                    <div class="card-header">전체 통계 | 학년별 통계 | 학년/반별 통계 | 성별 통계</div>
                    <div class="card-body">
                        <h6>전체통계</h6>
                        <table id="totalTable" class="table table-sm table-hover table-bordered mb-2">
                            <thead class="align-middle text-center">
                                <th width="50%">계약인원 수</th>
                                <th width="50%">참여자 수</th>
                            </thead>
                            <tbody class="align-middle text-center"></tbody>
                        </table>
                        <hr>
                        <h6>학년별 통계</h6>
                        <table id="gradeTable" class="table table-sm table-hover table-bordered mb-2">
                            <thead class="align-middle text-center">
                                <th width="50%">학년</th>
                                <th width="50%">참여자 수</th>
                            </thead>
                            <tbody class="align-middle text-center"></tbody>
                        </table>
                        <hr>
                        <h6>학년/반별 통계</h6>
                        <table id="classTable" class="table table-sm table-hover table-bordered mb-2">
                            <thead class="align-middle text-center">
                                <th>학년</th>
                                <th>반</th>
                                <th>참여자 수</th>
                            </thead>
                            <tbody class="align-middle text-center"></tbody>
                        </table>
                        <hr>
                        <h6>성별 통계</h6>
                        <table id="genderTable" class="table table-sm table-hover table-bordered">
                            <thead class="align-middle text-center">
                                <th width="50%">성별</th>
                                <th width="50%">참여자 수</th>
                            </thead>
                            <tbody class="align-middle text-center"></tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="col-4">
                <div class="card border-left-primary shadow mt-3">
                    <div class="card-header">검사결과목록</div>
                    <div class="card-body">
                        <table id="grade_classTable" class="table table-sm table-hover table-bordered">
                            <thead class="align-middle text-center">
                                <th>학년</th>
                                <th>반</th>
                                <th>참여자 수</th>
                            </thead>
                            <tbody class="align-middle text-center"></tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="col-4">
                <div class="card border-left-primary shadow mt-3">
                    <div class="card-header">검사결과목록&#40;상세&#41;</div>
                    <div class="card-body">
                        <table id="grade_classViewerTable" class="table table-sm table-hover table-bordered">
                            <thead class="align-middle text-center">
                                <th>학년</th>
                                <th>반</th>
                                <th>번호</th>
                                <th>결과보기</th>
                            </thead>
                            <tbody class="align-middle text-center"></tbody>
                        </table>

                    </div>
                </div>
            </div>
        </div>
        <?php
        $alertMsg = "진단검사 링크가 클립보드에 복사되었습니다.";
        include_once $_SERVER["DOCUMENT_ROOT"] . "/common/alert.php";
        ?>
    </div>
</main>

<div class="modal fade" id="AcoountUpdateModal" tabindex="-1" aria-labelledby="ModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 id="ModalLabel" class="modal-title">계정정보 변경</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="AcoountUpdateForm">
                    <div class="input-group mb-2">
                        <div class="form-floating">
                            <input type="text" id="txtManagerEmail" class="form-control" placeholder="담당자 이메일(아이디)" value="<?= $_SESSION["manager_email"] ?>" autocomplete="off" />
                            <label for="txtManagerEmail">담당자 이메일(아이디)</label>
                        </div>
                    </div>
                    <div class="input-group mb-2">
                        <div class="form-floating">
                            <input type="text" id="txtManagerName" class="form-control" placeholder="담당자 이름" value="<?= $_SESSION["manager_name"] ?>" autocomplete="off" />
                            <label for="txtManagerName">담당자 이름</label>
                        </div>
                    </div>
                    <div class="input-group mb-2">
                        <div class="form-floating">
                            <input type="text" id="txtManagerTel" class="form-control" placeholder="담당자 연락처" value="<?= $_SESSION["manager_tel"] ?>" autocomplete="off" />
                            <label for="txtManagerTel">담당자 연락처</label>
                        </div>
                    </div>
                    <div class="input-group mb-2">
                        <div class="form-floating">
                            <input type="text" id="txtManagerHp" class="form-control" placeholder="담당자 연락처(휴대전화)" value="<?= $_SESSION["manager_hp"] ?>" autocomplete="off" />
                            <label for="txtManagerHp">담당자 연락처(휴대전화)</label>
                        </div>
                    </div>
                    <div class="input-group mb-2">
                        <div class="form-floating">
                            <input type="password" id="txtCurrentPassword" class="form-control" placeholder="현재 비밀번호" autocomplete="current-password" />
                            <label for="txtCurrentPassword">현재 비밀번호</label>
                        </div>
                    </div>
                    <div class="input-group mb-2">
                        <div class="form-floating">
                            <input type="password" id="txtNewPassword" class="form-control" placeholder="변경할 비밀번호" autocomplete="new-password" />
                            <label for="txtNewPassword">변경할 비밀번호</label>
                        </div>
                    </div>
                    <div class="input-group mb-2">
                        <div class="form-floating">
                            <input type="password" id="txtNewPassword2" class="form-control" placeholder="변경할 비밀번호 확인" autocomplete="new-password" />
                            <label for="txtNewPassword2">변경할 비밀번호 확인</label>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                <button type="button" id="btnAccountUpdate" class="btn btn-primary">계정정보 변경</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="GenerateDiagnosisLinkModal" tabindex="-1" aria-labelledby="ModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 id="ModalLabel" class="modal-title">진단검사 링크</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container d-flex justify-content-center">
                    <div id="qrcode_div"></div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-sm btn-outline-secondary" data-bs-dismiss="modal">닫기</button>
                <button type="button" id="btnLinkCopy" class="btn btn-sm btn-outline-success"><i class="fa-solid fa-clipboard me-1"></i>진단검사 링크 복사</button>
                <button type="button" id="btnQRImageSave" class="btn btn-sm btn-outline-primary"><i class="fa-solid fa-qrcode me-1"></i>QRCode 저장</button>
            </div>
        </div>
    </div>
</div>
<?php
if ($_SESSION["order_state"] != '02') {
?>
    <script>
        $("#btnPayment").click(function() {
            var form = document.createElement("form");
            var order_num = document.createElement("input");
            order_num.setAttribute("type", "hidden");
            order_num.setAttribute("name", "order_num");
            order_num.setAttribute("value", $("#hd_order_num").val());

            var pay_method = document.createElement("input");
            pay_method.setAttribute("type", "hidden");
            pay_method.setAttribute("name", "pay_method");
            pay_method.setAttribute("value", $("#selChargeMethod").val());

            var pay_amount = document.createElement("input");
            pay_amount.setAttribute("type", "hidden");
            pay_amount.setAttribute("name", "pay_amount");
            pay_amount.setAttribute("value", $("#hdPrice").val());

            var pay_tax_free_amount = document.createElement("input");
            pay_tax_free_amount.setAttribute("type", "hidden");
            pay_tax_free_amount.setAttribute("name", "pay_tax_free_amount");
            pay_tax_free_amount.setAttribute("value", $("#hdPrice2").val());

            var order_type = document.createElement("input");
            order_type.setAttribute("type", "hidden");
            order_type.setAttribute("name", "order_type");
            order_type.setAttribute("value", $("#hd_order_type").val());

            var order_name = document.createElement("input");
            order_name.setAttribute("type", "hidden");
            order_name.setAttribute("name", "order_name");
            order_name.setAttribute("value", $("#hd_order_name").val());

            form.method = "POST";
            form.action = "/TossPayment/index.php";
            form.target = "_blank";
            form.appendChild(order_num);
            form.appendChild(pay_method);
            form.appendChild(pay_amount);
            form.appendChild(pay_tax_free_amount);
            form.appendChild(order_type);
            form.appendChild(order_name);
            document.body.appendChild(form);
            window.open("", "popupName", "width=700, height=800, left=" + Math.ceil((window.screen.width - 700) / 2) + ", top=" + Math.ceil((window.screen.height - 800) / 2));
            form.target = 'popupName';
            form.submit();
            document.body.removeChild(form);
        });
    </script>
<?php
}
?>