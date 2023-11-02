<?php
$school_idx = !empty($_POST["school_idx"]) ? $_POST["school_idx"] : "";
$std_grade = !empty($_POST["std_grade"]) ? $_POST["std_grade"] : "";
$std_class = !empty($_POST["std_class"]) ? $_POST["std_class"] : "";
$std_no = !empty($_POST["std_no"]) ? $_POST["std_no"] : "";

$StudentName = $std_grade . "학년 " . $std_class . "반 " . $std_no . "번";

if (empty($school_idx) || empty($std_grade) || empty($std_class) || empty($std_no)) {
    echo "<script>alert('잘못된 접근입니다.'); location.href='/school/login.php';</script>";
    exit;
}

include_once $_SERVER["DOCUMENT_ROOT"] . "/common/common_script2.php";
?>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.0/chart.umd.min.js" integrity="sha512-SIMGYRUjwY8+gKg7nn9EItdD8LCADSDfJNutF9TPrvEo86sQmFMh6MyralfIyhADlajSxqc7G0gs7+MwWF/ogQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>var student_name = "<?=$StudentName?>";</script>
<script src="js/reading_diagnosis_result.js"></script>
<div class="container-fluid">
    <input type="hidden" id="hd_school_idx" value="<?= $school_idx ?>" />
    <input type="hidden" id="hd_std_grade" value="<?= $std_grade ?>" />
    <input type="hidden" id="hd_std_class" value="<?= $std_class ?>" />
    <input type="hidden" id="hd_std_no" value="<?= $std_no ?>" />
    <div id="Result1" class="card border-left-primary shadow mt-3" style="page-break-before: always;">
        <div class="card-header">
            <div class="d-flex justify-content-between">
                <div>
                    <h5 id="lblTitle" class="align-self-center text-primary">독서이력진단 결과</h5>
                </div>
                <div>
                    <h6 id="lblSubTitle" class="align-self-center text-muted">종합결과 진단일 : <?= date('Y-m-d') ?> | <b><?= $StudentName ?></b> 님</h6>
                </div>
            </div>
        </div>
        <div class="card-body">
            <table id="table1" class="table table-bordered">
                <thead class="table-warning align-middle text-center">
                    <th>진단영역</th>
                    <th>진단요소</th>
                    <th>발달수준</th>
                    <th>백분위 점수</th>
                    <th>전체 평균</th>
                    <th>남학생 평균</th>
                    <th>여학생 평균</th>
                    <th>진단내용</th>
                </thead>
                <tbody class="align-middle text-center">
                    <tr id="table1_1">
                        <th class="table-warning" rowspan="3">A 도서선택이력<br>관리영역</th>
                        <td class="table-secondary">도서선택능력</td>
                        <td class="text-start"></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td class="text-start">도서 선택 준비도<br />도서 선택시 자기 주도 능력 의존도<br>전략적 독서상태</td>
                    </tr>
                    <tr id="table1_2">
                        <td class="table-secondary">독서관리<br>활용능력</td>
                        <td class="text-start"></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td class="text-start">독서 전 활동 상태<br>행동, 흥미, 배경지식, 상호작용</td>
                    </tr>
                    <tr id="table1_3">
                        <td class="table-secondary">소계</td>
                        <td class="text-start"></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td class="text-start">도서 선택 준비도<br />도서 선택시 자기 주도 능력 의존도<br>전략적 독서상태</td>
                    </tr>
                    <tr id="table1_4">
                        <th class="table-warning" rowspan="4">B 독서활동영역</th>
                        <td class="table-secondary">독서 전 활동</td>
                        <td class="text-start"></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td class="text-start">독서 전 활동 상태<br>행동, 흥미, 배경지식, 상호작용</td>
                    </tr>
                    <tr id="table1_5">
                        <td class="table-secondary">독서 중 활동</td>
                        <td class="text-start"></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td class="text-start">독서 중 활동 상태<br>행동, 흥미, 배경지식, 상호작용</td>
                    </tr>
                    <tr id="table1_6">
                        <td class="table-secondary">독서 후 활동</td>
                        <td class="text-start"></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td class="text-start">독서 후 활동 상태<br>행동, 흥미, 배경지식, 상호작용</td>
                    </tr>
                    <tr id="table1_7">
                        <td class="table-secondary">소계</td>
                        <td class="text-start"></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td class="text-start">독서 전 활동 상태<br>행동, 흥미, 배경지식, 상호작용</td>
                    </tr>
                    <tr id="table1_8">
                        <th class="table-warning">C 과거독서이력영역</th>
                        <td class="table-secondary">독서량<br>다양독<br>편중독</td>
                        <td class="text-start"></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td class="text-start">도서 선택 준비도<br />도서 선택시 자기 주도 능력 의존도</td>
                    </tr>
                    <tr id="table1_9">
                        <th class="table-warning">D 현재독서이력<br>분야분량영역</th>
                        <td class="table-secondary">독서량<br>다양독<br>편중독</td>
                        <td class="text-start"></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td class="text-start">도서 선택 준비도<br />도서 선택시 자기 주도 능력 의존도</td>
                    </tr>
                    <tr>
                        <td class="text-start" colspan="8"><small class="text-muted"> * 지표의 퍼센트가 높을수록 검사인원 중 우수함을 의미합니다.</small></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div id="Result2" class="card border-left-primary shadow mt-3" style="page-break-before: always;">
        <div class="card-header">
            <h5 class="text-primary">결과분석 &#40;문학, 비문학&#41; / 독서이력지수 &#40;RQ&#41;</h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-6">
                    <table class="table table-bordered">
                        <thead class="align-middle text-center">
                            <th>진단요소</th>
                            <th>점수</th>
                            <th>전체평균</th>
                            <th>남학생평균</th>
                            <th>여학생평균</th>
                        </thead>
                        <tbody class="align-middle text-center">
                            <tr id="table2_1">
                                <th>문학</th>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr id="table2_2">
                                <th>비문학</th>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr id="table2_3">
                                <th>합계</th>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="col-6">
                    <canvas id="result2_1"></canvas>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-6">
                    <table class="table table-bordered">
                        <thead class="align-middle text-center">
                            <th>진단요소</th>
                            <th>점수</th>
                            <th>전체평균</th>
                            <th>남학생평균</th>
                            <th>여학생평균</th>
                        </thead>
                        <tbody class="align-middle text-center">
                            <tr id="table2_4">
                                <th>독서이력지수</th>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="col-6">
                    <canvas id="result2_2"></canvas>
                </div>
            </div>
        </div>
    </div>
    <div id="Result3" class="card border-left-primary shadow mt-3" style="page-break-before: always;">
        <div class="card-header">
            <h5 class="text-primary">A 도서선택 이력관리 결과</h5>
        </div>
        <div class="card-body">
            <table class="table table-bordered">
                <thead class="align-middle text-center">
                    <th>진단요소</th>
                    <th>발달수준</th>
                    <th>점수</th>
                    <th>전체평균</th>
                    <th>남학생평균</th>
                    <th>여학생평균</th>
                </thead>
                <tbody class="align-middle text-center">
                    <tr id="table3_1">
                        <th>도서선택능력</th>
                        <td class="text-start"></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr id="table3_2">
                        <th>도서관리활용능력</th>
                        <td class="text-start"></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr id="table3_3">
                        <th>합계</th>
                        <td class="text-start"></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
            <canvas id="result3"></canvas>
            <table class="table table-bordered">
                <thead class="align-middle text-center">
                    <tr>
                        <th colspan="3">진단결과 분석 및 개선방안</th>
                    </tr>
                    <tr>
                        <th>구분</th>
                        <th>도서선택능력</th>
                        <th>독서관리 활용능력</th>
                    </tr>
                </thead>
                <tbody class="align-middle text-center">
                    <tr id="table4_1">
                        <th>결과</th>
                        <td class="text-start"></td>
                        <td class="text-start"></td>
                    </tr>
                    <tr id="table4_2">
                        <th>특징</th>
                        <td class="text-start"></td>
                        <td class="text-start"></td>
                    </tr>
                    <tr id="table4_3">
                        <th>개선방향</th>
                        <td class="text-start"></td>
                        <td class="text-start"></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div id="Result4" class="card border-left-primary shadow mt-3" style="page-break-before: always;">
        <div class="card-header">
            <h5 class="text-primary">B 독서 전중후 활동영역</h5>
        </div>
        <div class="card-body">
            <table class="table table-bordered">
                <thead class="align-middle text-center">
                    <tr>
                        <th width="20%">진단요소</th>
                        <th width="40%">발달수준</th>
                        <th width="10%">점수</th>
                        <th width="10%">전체평균</th>
                        <th width="10%">남학생평균</th>
                        <th width="10%">여학생평균</th>
                    </tr>
                </thead>
                <tbody class="align-middle text-center">
                    <tr id="table5_1">
                        <th>독서 전</th>
                        <td class="text-start"></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr id="table5_2">
                        <th>독서 중</th>
                        <td class="text-start"></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr id="table5_3">
                        <th>독서 후</th>
                        <td class="text-start"></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>

            <canvas id="result4_2"></canvas>

            <table class="table table-bordered">
                <thead class="align-middle text-center">
                    <tr>
                        <th colspan="4">진단결과 분석 및 개선방안</th>
                    </tr>
                    <tr>
                        <th width="10%">구분</th>
                        <th width="30%">독서 전</th>
                        <th width="30%">독서 중</th>
                        <th width="30%">독서 후</th>
                    </tr>
                </thead>
                <tbody class="align-middle text-start">
                    <tr id="table6_1">
                        <th class="text-center">결과</th>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr id="table6_2">
                        <th class="text-center">특징</th>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr id="table6_3">
                        <th class="text-center">개선방향</th>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>

        </div>
    </div>
    <div id="Result5" class="card border-left-primary shadow mt-3" style="page-break-before: always;">
        <div class="card-header">
            <h5 class="text-primary">C 과거 독서이력</h5>
        </div>
        <div class="card-body">
            <table class="table table-bordered">
                <thead class="align-middle text-center">
                    <th>진단요소</th>
                    <th>발달수준</th>
                    <th>점수</th>
                    <th>전체평균</th>
                    <th>남학생평균</th>
                    <th>여학생평균</th>
                </thead>
                <tbody class="align-middle text-center">
                    <tr id="table7_1">
                        <th>독서량<br>다양독<br>편중독</th>
                        <td class="text-start"></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>

            <canvas id="result5_2"></canvas>

            <table class="table table-bordered">
                <thead class="align-middle text-center">
                    <tr>
                        <th colspan="4">진단결과 분석 및 개선방안</th>
                    </tr>
                    <tr>
                        <th width="20%">구분</th>
                        <th width="80%">과거 독서이력</th>
                    </tr>
                </thead>
                <tbody class="align-middle text-start">
                    <tr id="table8_1">
                        <th class="text-center">결과</th>
                        <td></td>
                    </tr>
                    <tr id="table8_2">
                        <th class="text-center">특징</th>
                        <td></td>
                    </tr>
                    <tr id="table8_3">
                        <th class="text-center">개선방향</th>
                        <td></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div id="Result6" class="card border-left-primary shadow mt-3" style="page-break-before: always;">
        <div class="card-header">
            <h5 class="text-primary">D 현재 독서이력</h5>
        </div>
        <div class="card-body">
            <table class="table table-bordered">
                <thead class="align-middle text-center">
                    <th>진단요소</th>
                    <th>발달수준</th>
                    <th>점수</th>
                    <th>전체평균</th>
                    <th>남학생평균</th>
                    <th>여학생평균</th>
                </thead>
                <tbody class="align-middle text-center">
                    <tr id="table9_1">
                        <th>독서량<br>다양독<br>편중독</th>
                        <td class="text-start"></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>

            <canvas id="result6_2"></canvas>

            <table class="table table-bordered">
                <thead class="align-middle text-center">
                    <tr>
                        <th colspan="4">진단결과 분석 및 개선방안</th>
                    </tr>
                    <tr>
                        <th>구분</th>
                        <th>현재 독서이력</th>
                    </tr>
                </thead>
                <tbody class="align-middle text-start">
                    <tr id="table10_1">
                        <th class="text-center">결과</th>
                        <td></td>
                    </tr>
                    <tr id="table10_2">
                        <th class="text-center">특징</th>
                        <td></td>
                    </tr>
                    <tr id="table10_3">
                        <th class="text-center">개선방향</th>
                        <td></td>
                    </tr>
                </tbody>
            </table>
            <div class="row text-center">
                <div class="col-6"><canvas id="result6_3"></canvas></div>
                <div class="col-6"><canvas id="result6_4"></canvas></div>
            </div>
        </div>
    </div>
</div>