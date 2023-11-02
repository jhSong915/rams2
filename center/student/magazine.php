<?php
include_once $_SERVER['DOCUMENT_ROOT'] . "/_config/session_start.php";
?>
<!DOCTYPE html>
<html>

<head>
    <link rel="icon" href="/img/favicon.ico" type="image/x-icon" />

    <?php
    $stat = 'student';
    include_once($_SERVER['DOCUMENT_ROOT'] . '/common/common_script.php');
    ?>
    <script src="/center/student/js/magazine.js?v=<?= date("YmdHis") ?>"></script>
</head>

<body class="size-14">
    <!-- 헤더 -->
    <?php include "navbar.php"; ?>

    <!-- 컨텐츠 -->
    <main style="min-height: 79vh;">
        <div class="container-fluid">
            <div class="card border-left-primary shadow mt-2 mb-2">
                <div class="card-header">
                    <div class="row align-items-center">
                        <div class="col align-items-start align-self-center">
                            <h6>매거진</h6>
                        </div>
                        <div class="col-auto align-items-end">
                            <div class="form-floating">
                                <select class="form-select" id="selYear" onchange="magazineLoad()">
                                    <?php
                                    for ($i = date('Y'); $i >= '2013'; $i--) {
                                    ?>
                                        <option value="<?= $i ?>"><?= $i ?>년</option>
                                    <?php
                                    }
                                    ?>
                                </select>
                                <label for="selYear">연도</label>
                            </div>
                        </div>
                        <?php
                        $now_month = date('m');
                        if ($now_month == '03' || $now_month == '04' || $now_month == '05') {
                            $magazine_season = '1';
                        } else if ($now_month == '06' || $now_month == '07' || $now_month == '08') {
                            $magazine_season = '2';
                        } else if ($now_month == '09' || $now_month == '10' || $now_month == '11') {
                            $magazine_season = '3';
                        } else if ($now_month == '12' || $now_month == '01' || $now_month == '02') {
                            $magazine_season = '4';
                        } else {
                            $magazine_season = '0';
                        }
                        ?>
                        <div class="col-auto align-items-end">
                            <div class="form-floating">
                                <select class="form-select" id="selSeason" onchange="magazineLoad()">
                                    <option value="01" <?= $magazine_season == '1' ? "selected" : "" ?> >봄</option>
                                    <option value="02" <?= $magazine_season == '2' ? "selected" : "" ?> >여름</option>
                                    <option value="03" <?= $magazine_season == '3' ? "selected" : "" ?> >가을</option>
                                    <option value="04" <?= $magazine_season == '4' ? "selected" : "" ?> >겨울</option>
                                </select>
                                <label for="selSeason">계절</label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row mt-2 mb-2" id="magazineList"></div>
                </div>
            </div>
        </div>
    </main>

    <!-- 푸터 -->
    <?php include "footer.php"; ?>
</body>

</html>