<?php
$grade = $_GET['grade'];
if (empty($grade)) {
    header("Location:https://" . $_SERVER['HTTP_HOST']);
}
?>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>리딩엠 RAMS - 글쓰기 진단</title>
    <link rel="icon" href="/img/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="/css/styles.css" />
    <?php include_once $_SERVER["DOCUMENT_ROOT"] . "/common/common_script2.php" ?>
</head>

<body>
    <div class="container">
        <div class="card border-left-primary shadow mt-2">
            <div class="card-header">
                <h6>글쓰기진단</h6>
            </div>
            <div class="card-body">
                <?php
                include_once $_SERVER['DOCUMENT_ROOT'] . "/reading_analysis/writing_question.php";
                echo $form;
                ?>
            </div>
            <div class="input-group justify-content-end mb-2">
                <div class="form-inline form-check-inline me-2">
                    <button type="button" id="btnAnalyze" class="btn btn-outline-primary">진단하기</button>
                </div>
            </div>
        </div>
    </div>
</body>
<script>
    $(document).ready(function() {
        $(".answer_chk1").click(function(e) {
            $(".answer_chk1").removeClass("text-danger");
            $(this).addClass("text-danger");
        });

        $(".answer_chk2").click(function(e) {
            $(".answer_chk2").removeClass("text-danger");
            $(this).addClass("text-danger");
        });

        $(".answer_chk3").click(function(e) {
            $(".answer_chk3").removeClass("text-danger");
            $(this).addClass("text-danger");
        });

        $(".answer_chk4").click(function(e) {
            $(".answer_chk4").removeClass("text-danger");
            $(this).addClass("text-danger");
        });

        $("#btnAnalyze").click(function() {
            if (!$("input[name='answer1']:checked").val()) {
                alert("1번 문제를 풀어보세요.");
                $("input[name='answer1']").focus();
                return false;
            } else if (!$("input[name='answer2']:checked").val()) {
                alert("2번 문제를 풀어보세요.");
                $("input[name='answer2']").focus();
                return false;
            } else if (!$("input[name='answer3']:checked").val()) {
                alert("3번 문제를 풀어보세요.");
                $("input[name='answer3']").focus();
                return false;
            } else if (!$("input[name='answer4']:checked").val()) {
                alert("4번 문제를 풀어보세요.");
                $("input[name='answer4']").focus();
                return false;
            } else {
                $("#writingForm").append("grade", "<?= $grade ?>");
                $("#writingForm").append("analyzeType", "w");
                $("#writingForm").submit();
            }
        });

    });
</script>

</html>