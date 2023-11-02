<!DOCTYPE html>
<html>

<head>
    <!-- css / script -->
    <?php
    $stat = 'adm';
    include_once($_SERVER['DOCUMENT_ROOT'] . '/common/common_script.php');
    include_once $_SERVER['DOCUMENT_ROOT'] . "/common/commonClass.php";
    $codeInfoCmp = new codeInfoCmp();

    $order_method_info = $codeInfoCmp->getCodeInfo('41'); //결제방법
    $order_state_info = $codeInfoCmp->getCodeInfo('46'); //결제상태
    ?>
    <script src="/adm/js/school_list.js?v=<?= date("YmdHis") ?>"></script>
</head>

<body class="sb-nav-fixed size-14">
    <!-- header navbar -->
    <?php include_once('navbar.html'); ?>
    <div id="layoutSidenav">
        <!-- sidebar -->
        <?php include_once('sidebar.html'); ?>
        <div id="Maincontent">
            <main>
                <div class="container-fluid px-4">
                    <!-- 콘텐츠 -->
                    <div class="row">
                        <div class="col-12 mt-3">
                            <div class="card border-left-primary shadow h-100">
                                <div class="card-header">
                                    <h6>학교관리&#40;독서이력진단&#41;</h6>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-6">
                                            <table id="dataTable" class="table table-bordered table-hover">
                                                <thead class="text-center">
                                                    <th>번호</th>
                                                    <th>학교종류</th>
                                                    <th>학교이름</th>
                                                    <th>접근보안코드</th>
                                                    <th>시작일</th>
                                                    <th>종료일</th>
                                                    <th>등록일</th>
                                                </thead>
                                                <tbody class="text-center" id="schoolList">
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="col-6">
                                            <form>
                                                <table class="table table-sm table-bordered">
                                                    <input type="hidden" id="school_idx">
                                                    <tbody>
                                                        <tr class="align-middle">
                                                            <th class="text-center" scope="row" colspan="3">학교종류</th>
                                                            <td colspan="3">
                                                                <select id="selSchoolType" class="form-select">
                                                                    <option value="">선택</option>
                                                                    <option value="1">초등학교</option>
                                                                    <option value="2">중학교</option>
                                                                    <option value="3">고등학교</option>
                                                                </select>
                                                            </td>
                                                            <th class="text-center" scope="row" colspan="3">학교이름</th>
                                                            <td colspan="3"><input type="text" id="txtSchoolName" class="form-control" maxlength="25" value="" placeholder="학교 이름 (한글 25자까지)" /></td>
                                                        </tr>
                                                        <tr class="align-middle">
                                                            <th class="text-center" scope="row" colspan="3">담당자 이름</th>
                                                            <td colspan="3"><input type="text" id="txtManagerName" class="form-control" maxlength="15" value="" placeholder="이름 (한글 15자까지)" /></td>
                                                            <th class="text-center" scope="row" colspan="3">접근보안코드</th>
                                                            <td colspan="3">
                                                                <input type="text" id="txtAccessToken" class="form-control" maxlength="20" value="" placeholder="접근보안코드 (영문+숫자만)" />
                                                            </td>
                                                        </tr>
                                                        <tr class="align-middle">
                                                            <th class="text-center" colspan="3">담당자 전화번호</th>
                                                            <td colspan="3"><input type="text" id="txtManagerTel" class="form-control" maxlength="15" value="" placeholder="전화번호 (숫자만)" numberOnly /></td>
                                                            <th class="text-center" scope="row" colspan="3">담당자 휴대전화</th>
                                                            <td colspan="3"><input type="text" id="txtManagerHp" class="form-control" maxlength="15" value="" placeholder="휴대전화번호 (숫자만)" numberOnly /></td>
                                                        </tr>
                                                        <tr class="align-middle">
                                                            <th class="text-center" colspan="3">담당자 이메일(아이디)</th>
                                                            <td colspan="3"><input type="text" id="txtManagerEmail" class="form-control" maxlength="50" value="" placeholder="이메일 주소" /></td>
                                                            <th class="text-center" colspan="3">담당자 비밀번호</th>
                                                            <td colspan="3"><input type="password" id="txtManagerPassword" class="form-control" maxlength="50" value="" placeholder="비밀번호 4자리 이상" autocomplete="new-password" /></td>
                                                        </tr>
                                                        <tr class="align-middle">
                                                            <th class="text-center" scope="row" colspan="3">진단 시작일</th>
                                                            <td colspan="3"><input type="date" id="dt_start_date" class="form-control" value="<?= date('Y-m-d') ?>" /></td>
                                                            <th class=" text-center" colspan="3">진단 종료일</th>
                                                            <td colspan="3"><input type="date" id="dt_end_date" class="form-control" value="<?= date('Y-m-d') ?>" /></td>
                                                        </tr>
                                                        <tr class="align-middle">
                                                            <th class="text-center" scope="row" colspan="3">계약 인원수</th>
                                                            <td colspan="3"><input type="text" id="txtContractNo" class="form-control" value="" placeholder="계약인원 수 (숫자만)" numberOnly /></td>
                                                            <th class="text-center" scope="row" colspan="3">결제 금액</th>
                                                            <td colspan="3"><input type="text" id="txtOrderMoney" class="form-control" value="" placeholder="결제금액 (숫자만)" numberOnly /></td>
                                                        </tr>
                                                        <tr class="align-middle">
                                                            <th class="text-center" scope="row" colspan="3">결제상태</th>
                                                            <td colspan="3">
                                                                <select id="selOrderState" class="form-select" disabled>
                                                                    <option value="">선택</option>
                                                                    <?php
                                                                    foreach ($order_state_info as $key => $val) {
                                                                        echo "<option value=\"{$val['code_num2']}\">{$val['code_name']}</option>";
                                                                    }
                                                                    ?>
                                                                </select>
                                                            </td>
                                                            <th class=" text-center" colspan="3">결제방법</th>
                                                            <td colspan="3">
                                                                <input type="text" id="txtOrderMethod" class="form-control" value="" placeholder="결제방법" disabled />
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </form>
                                            <div class="text-end mt-2">
                                                <button type="button" class="btn btn-danger" id="btnDelete" style="display: none;"><i class="fas fa-trash me-1"></i>삭제</button>
                                                <button type="button" class="btn btn-success" id="btnUpdate" style="display: none;"><i class="fa-solid fa-floppy-disk me-1"></i>수정</button>
                                                <button type="button" class="btn btn-primary" id="btnSave"><i class="fa-solid fa-floppy-disk me-1"></i>저장</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            <!-- footer -->
            <?php
            include_once('footer.html');
            ?>
        </div>
    </div>
    <script>
        $('input:text[numberOnly]').on('propertychange change keyup paste', function() {
            $(this).val($(this).val().replace(/[^0-9]/g, ""));
        });
    </script>
</body>

</html>