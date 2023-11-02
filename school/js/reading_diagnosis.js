$(document).ready(function () {
    getRdQuestionNScore();

    $("input:radio[name=rdoQuiz]").click(function () {
        var target_id = $(this).attr("id");
        $(".qlabel").removeClass("text-danger");
        $("label[for=" + target_id + "]").addClass("text-danger");
    })

    $("#btnSend").click(function () {
        $.ajax({
            url: '/school/ajax/readingDiagnosis.ajax.php',
            dataType: 'JSON',
            type: 'POST',
            data: {
                action: "readingDiagnosisInsert",
                school_idx: $("#hd_rd_school").val(),
                school_type: $("#hd_rd_school_type").val(),
                std_gender: $("#hd_rd_Gender").val(),
                std_grade: $("#hd_rd_Grade").val(),
                std_class: $("#hd_rd_Class").val(),
                std_no: $("#hd_rd_No").val(),
                answer: answer
            },
            success: function (result) {
                if (result.success) {
                    $("#btnSend").attr("disabled", true);
                    alert(result.msg);
                    return false;
                }
            },
            error: function (request, status, error) {
                console.log("request : " + request + "\n" + "status : " + status + "\n" + "error : " + error);
            }
        });
    });

    $("#btnPrev").click(function () {
        $(".qlabel").removeClass("text-danger");
        if (count == 1) {
            $("#btnPrev").attr("disabled", true);
            $("#btnPrev").hide();
        }
        prev_answer = answer.pop();
        count--;

        $(".progress-bar").css('width', Math.round(count / 101 * 100) + "%");
        $(".progress-bar").text(Math.round(count / 101 * 100) + "%");
        $("#txtQuestion").val(question[count]);
        $("#rdo1").val(score[count][0]);
        $("#rdo2").val(score[count][1]);
        $("#rdo3").val(score[count][2]);
        $("#rdo4").val(score[count][3]);
        $("#rdo5").val(score[count][4]);
        $("#lblquiz").text("문제 " + (count + 1));
        if (count < 14) {
            $("#lblTitle").text("도서선택과 이력관리 영역");
            $("#lblSubTitle").text("도서 선택 능력");
        } else if (count > 13 && count < 24) {
            $("#lblTitle").text("도서선택과 이력관리 영역");
            $("#lblSubTitle").text("도서 이력관리 활용 능력");
        } else if (count > 23 && count < 34) {
            $("#lblTitle").text("독서활동영역");
            $("#lblSubTitle").text("독서전 활동");
        } else if (count > 33 && count < 46) {
            $("#lblSubTitle").text("독서중 활동");
        } else if (count > 45 && count < 63) {
            $("#lblSubTitle").text("독서후 활동");
        } else if (count > 62 && count < 82) {
            $("#lblTitle").text("과거 독서이력 영역");
            $("#lblSubTitle").text("분포도 - 편독");
        } else if (count > 81 && count < 101) {
            $("#lblTitle").text("현재 독서분야 및 분량 영역");
        }

        if (count >= 63 && count < 82) {
            $("#lbl1").text("1. 거의 읽지 않음");
            $("#lbl2").text("2. 조금 읽음");
            $("#lbl3").text("3. 보통");
            $("#lbl4").text("4. 많이 읽음");
            $("#lbl5").text("5. 매우 많이 읽음");
        } else if (count >= 82 && count <= 100) {
            $("#lbl1").text("1. 0권");
            $("#lbl2").text("2. 1권");
            $("#lbl3").text("3. 2권");
            $("#lbl4").text("4. 3권");
            $("#lbl5").text("5. 4권이상");
        } else {
            $("#lbl1").text("1. 정말아니다");
            $("#lbl2").text("2. 아닌편이다");
            $("#lbl3").text("3. 그저그렇다");
            $("#lbl4").text("4. 그런편이다");
            $("#lbl5").text("5. 정말그렇다");
        }
        $("input:radio[name=rdoQuiz][value='" + prev_answer + "']").prop("checked", true);
        $(".qlabel").removeClass("text-danger");
        $("#lbl" + prev_answer).addClass("text-danger");
    });

    $("#btnNext").click(function () {
        $(".qlabel").removeClass("text-danger");
        if ($("input:radio[name=rdoQuiz]").is(":checked") == true) {
            if ($("#hd_rd_school_type").val() == "1" && $("#hd_rd_Grade").val() <= 2) {
                if (count >= 86) {
                    $("#btnPrev").hide();
                    $("#btnPrev").attr("disabled", true);
                    $("#btnNext").hide();
                    $("#btnNext").attr("disabled", true);
                    $(".progress-bar").css('width', "100%");
                    $(".progress-bar").text("100%");
                    $("#lblTitle").text("제출하기");
                    $("#lblSubTitle").text("");
                    answer.push($("input:radio[name=rdoQuiz]:checked").val());
                    $("#questionDiv").hide();
                    $("#endDiv").show();
                    $("#endDiv").html("<h6>많은 문제를 푸느라 고생 많으셨습니다.<br>오른쪽 아래에 '제출' 버튼을 눌러 작성한 답을 제출해주세요.<br>제출 후에는 수정이 불가하며 다시 검사할 수 없습니다.</h6>");
                    $("#btnSend").show();
                    return;
                }
                answer.push($("input:radio[name=rdoQuiz]:checked").val());
                count++;
                if (count >= 1) {
                    $("#btnPrev").attr("disabled", false);
                    $("#btnPrev").show();
                }
                $(".progress-bar").css('width', Math.round(count / 87 * 100) + "%");
                $(".progress-bar").text(Math.round(count / 87 * 100) + "%");
                $("#txtQuestion").val(question[count]);
                $("#rdo1").val(score[count][0]);
                $("#rdo2").val(score[count][1]);
                $("#rdo3").val(score[count][2]);
                $("#rdo4").val(score[count][3]);
                $("#rdo5").val(score[count][4]);
                $("#lblquiz").text("문제 " + (count + 1));
                if (count < 14) {
                    $("#lblTitle").text("도서선택과 이력관리 영역");
                    $("#lblSubTitle").text("도서 선택 능력");
                } else if (count > 13 && count < 24) {
                    $("#lblTitle").text("도서선택과 이력관리 영역");
                    $("#lblSubTitle").text("도서 이력관리 활용 능력");
                } else if (count > 23 && count < 34) {
                    $("#lblTitle").text("독서활동영역");
                    $("#lblSubTitle").text("독서전 활동");
                } else if (count > 33 && count < 46) {
                    $("#lblSubTitle").text("독서중 활동");
                } else if (count > 45 && count < 63) {
                    $("#lblSubTitle").text("독서후 활동");
                } else if (count > 62 && count < 75) {
                    $("#lblTitle").text("과거 독서이력 영역");
                    $("#lblSubTitle").text("분포도 - 편독");
                } else if (count > 74 && count < 87) {
                    $("#lblTitle").text("현재 독서분야 및 분량 영역");
                }

                if (count >= 63 && count <= 74) {
                    $("#lbl1").text("1. 거의 읽지 않음");
                    $("#lbl2").text("2. 조금 읽음");
                    $("#lbl3").text("3. 보통");
                    $("#lbl4").text("4. 많이 읽음");
                    $("#lbl5").text("5. 매우 많이 읽음");
                } else if (count >= 74 && count <= 86) {
                    $("#lbl1").text("1. 0권");
                    $("#lbl2").text("2. 1권");
                    $("#lbl3").text("3. 2권");
                    $("#lbl4").text("4. 3권");
                    $("#lbl5").text("5. 4권이상");
                } else {
                    $("#lbl1").text("1. 정말아니다");
                    $("#lbl2").text("2. 아닌편이다");
                    $("#lbl3").text("3. 그저그렇다");
                    $("#lbl4").text("4. 그런편이다");
                    $("#lbl5").text("5. 정말그렇다");
                }

                // $("input:radio[name='rdoQuiz']").prop("checked", false);
            } else {
                if (count >= 100) {
                    $("#btnPrev").hide();
                    $("#btnPrev").attr("disabled", true);
                    $("#btnNext").hide();
                    $("#btnNext").attr("disabled", true);
                    $(".progress-bar").css('width', "100%");
                    $(".progress-bar").text("100%");
                    $("#lblTitle").text("제출하기");
                    $("#lblSubTitle").text("");
                    answer.push($("input:radio[name=rdoQuiz]:checked").val());
                    $("#questionDiv").hide();
                    $("#endDiv").show();
                    $("#endDiv").html("<h6>많은 문제를 푸느라 고생 많으셨습니다.<br>오른쪽 아래에 '제출' 버튼을 눌러 작성한 답을 제출해주세요.<br>제출 후에는 수정이 불가하며 다시 검사할 수 없습니다.</h6>");
                    $("#btnSend").show();
                    return;
                }
                answer.push($("input:radio[name=rdoQuiz]:checked").val());
                count++;
                if (count >= 1) {
                    $("#btnPrev").attr("disabled", false);
                    $("#btnPrev").show();
                }
                $(".progress-bar").css('width', Math.round(count / 101 * 100) + "%");
                $(".progress-bar").text(Math.round(count / 101 * 100) + "%");
                $("#txtQuestion").val(question[count]);
                $("#rdo1").val(score[count][0]);
                $("#rdo2").val(score[count][1]);
                $("#rdo3").val(score[count][2]);
                $("#rdo4").val(score[count][3]);
                $("#rdo5").val(score[count][4]);
                $("#lblquiz").text("문제 " + (count + 1));
                if (count < 14) {
                    $("#lblTitle").text("도서선택과 이력관리 영역");
                    $("#lblSubTitle").text("도서 선택 능력");
                } else if (count > 13 && count < 24) {
                    $("#lblTitle").text("도서선택과 이력관리 영역");
                    $("#lblSubTitle").text("도서 이력관리 활용 능력");
                } else if (count > 23 && count < 34) {
                    $("#lblTitle").text("독서활동영역");
                    $("#lblSubTitle").text("독서전 활동");
                } else if (count > 33 && count < 46) {
                    $("#lblSubTitle").text("독서중 활동");
                } else if (count > 45 && count < 63) {
                    $("#lblSubTitle").text("독서후 활동");
                } else if (count > 62 && count < 82) {
                    $("#lblTitle").text("과거 독서이력 영역");
                    $("#lblSubTitle").text("분포도 - 편독");
                } else if (count > 81 && count < 101) {
                    $("#lblTitle").text("현재 독서분야 및 분량 영역");
                }

                if (count >= 63 && count <= 82) {
                    $("#lbl1").text("1. 거의 읽지 않음");
                    $("#lbl2").text("2. 조금 읽음");
                    $("#lbl3").text("3. 보통");
                    $("#lbl4").text("4. 많이 읽음");
                    $("#lbl5").text("5. 매우 많이 읽음");
                } else if (count >= 83 && count <= 100) {
                    $("#lbl1").text("1. 0권");
                    $("#lbl2").text("2. 1권");
                    $("#lbl3").text("3. 2권");
                    $("#lbl4").text("4. 3권");
                    $("#lbl5").text("5. 4권이상");
                } else {
                    $("#lbl1").text("1. 정말아니다");
                    $("#lbl2").text("2. 아닌편이다");
                    $("#lbl3").text("3. 그저그렇다");
                    $("#lbl4").text("4. 그런편이다");
                    $("#lbl5").text("5. 정말그렇다");
                }
            }
            // $("input:radio[name='rdoQuiz']").prop("checked", false);
        } else {
            alert("문항의 답을 선택해주세요 !");
            return false;
        }
    });
});

function getRdQuestionNScore() {
    $.ajax({
        url: '/school/ajax/reading_question.ajax.php',
        dataType: 'JSON',
        type: 'POST',
        data: {
            school_type: $("#hd_rd_school_type").val(),
            grade: $("#hd_rd_Grade").val(),
        },
        async: false,
        success: function (data) {
            for (var i = 0; i < data.question.length; i++) {
                question.push(data.question[i]);
            }
        },
        error: function (request, status, error) {
            console.log("request : " + request + "\n" + "status : " + status + "\n" + "error : " + error);
        }
    });
    $.ajax({
        url: '/school/ajax/reading_answer.ajax.php',
        dataType: 'JSON',
        type: 'POST',
        data: {
            school_type: $("#hd_rd_school_type").val(),
            grade: $("#hd_rd_Grade").val(),
        },
        async: false,
        success: function (data) {
            for (var i = 0; i < data.answer.length; i++) {
                score.push(data.answer[i]);
            }
        },
        error: function (request, status, error) {
            console.log("request : " + request + "\n" + "status : " + status + "\n" + "error : " + error);
        }
    });
}