$(document).ready(function () {
    $("#loginForm").keypress(function (e) {
        if (e.keyCode === 13) {
            login_check();
        }
    });

    $("#inputId, #inputPassword").keyup(function (event) {
        if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
            var inputVal = $(this).val();
            var check = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
            if (check.test(inputVal)) {
                $(this).val("");
            }
        }
    });
});

function login_check() {
    var user_id = $("#inputId").val();
    var password = $("#inputPassword").val();

    if (!user_id || !user_id.trim()) {
        alert('아이디를 입력하세요.');
        $("#inputId").focus();
        return false;
    }

    if (!password || !password.trim()) {
        alert('비밀번호를 입력하세요.');
        $("#inputPassword").focus();
        return false;
    }

    password = CryptoJS.SHA256(password).toString();

    $.ajax({
        url: '/school/login2.php',
        dataType: 'JSON',
        type: 'POST',
        async: false,
        data: {
            user_id: user_id,
            password: password,
        },
        success: function (data) {
            if (data.status == "success") {
                location.href = '/school/reading_diagnosis_analytics.php';
            } else if (data.status == 'fail') {
                alert(data.msg);
                return false;
            } else {
                alert('처리 과정에서 오류가 발생하였습니다. 관리자에게 문의하시기 바랍니다.');
                return false;
            }
        },
        error: function (request, status, error) {
            alert("request : " + request + "\n" + "status : " + status + "\n" + "error : " + error);
        }
    });
}