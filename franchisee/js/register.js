$(document).ready(function () {
    $('#inputDiv').hide();

    $('#chkPrivacy').change(function () {
        if ($('#chkPrivacy').is(':checked') == true) {
            var chk = confirm('이용약관 및 개인정보 이용에 동의하시겠습니까?');
            if (chk == true) {
                $('#checkDiv').hide();
                $('#inputDiv').show();
            }
            else {
                $('#chkPrivacy').attr('checked', false);
            }
        }
    });

    $('#btnaddr').click(function () {
        new daum.Postcode({
            oncomplete: function (data) {
                $('#txtAddr').val(data.roadAddress);
                $('#txtZipCode').val(data.zonecode);
                $('#txtAddr').focus();
            }
        }).open();
    });

    $('#txtHp, #txtFax, #txtZipCode').on('propertychange change keyup paste', function () {
        var value = $(this).val();
        $(this).val(value.replace(/[^0-9.]/g, ''));
    });

    $("#btnSave").click(function () {
        var franchise_type = $("#selCenterType").val();
        var location = $("#selLocation").val();
        var center_name = $("#txtCenterName").val();
        var owner_name = $("#txtName").val();
        var email = $("#txtEmail").val();
        var tel_num = $("#txtHp").val();
        var fax_num = $("#txtFax").val();
        var address = $("#txtAddr").val();
        var zipcode = $("#txtZipCode").val();

        if (!center_name || !center_name.trim()) {
            alert('교육센터명을 입력해주세요.');
            $("#center_name").focus();
            return false;
        }

        if (!owner_name || !owner_name.trim()) {
            alert('대표자명을 입력해주세요');
            $("#owner_name").focus();
            return false;
        }

        if (!address || !address.trim()) {
            alert('주소를 입력해주세요');
            $("#txtAddr").focus();
            return false;
        }

        if (!zipcode || !zipcode.trim()) {
            alert('우편번호를 입력해주세요');
            $("#txtZipCode").focus();
            return false;
        }

        if (!tel_num || !tel_num.trim()) {
            alert('전화번호를 입력해주세요.');
            $("#txtTel").focus();
            return false;
        }

        if (!email || email == '') {
            alert('메일을 입력해주세요');
            $("#txtEmail").focus();
            return false;
        }

        if (!location || location == '') {
            alert('지역을 선택해주세요');
            $("#location").focus();
            return false;
        }

        $.ajax({
            url: "/adm/ajax/franchiseControll.ajax.php",
            dataType: 'JSON',
            type: 'POST',
            async: false,
            data: {
                action: 'centerInsert',
                franchise_type: franchise_type,
                center_name: center_name,
                owner_name: owner_name,
                useyn: 'N',
                address: address,
                zipcode: zipcode,
                tel_num: tel_num,
                fax_num: fax_num,
                email: email,
                location: location,
            },
            success: function (result) {
                if (result.success) {
                    alert(result.msg);
                    window.location.href = "/index.php";
                    return false;
                } else {
                    alert(result.msg);
                    return false;
                }
            },
            error: function () {
                alert("request : " + request + "\n" + "status : " + status + "\n" + "error : " + error);
            }
        });
    });
});

function register_member() {
    var user_name = $("#txtName").val();
    var user_id = $("#txtUserId").val();
    var password = $("#txtPassword").val();
    var password_tmp = $("#txtPasswordConfirm").val();
    var email = $("#txtEmail").val();
    var birth = $("#dtBirthday").val();
    var gender = $("#chkGender").is(':checked') ? 'M' : 'F';
    var user_phone = $("#txtHp").val();
    var address = $("#txtAddr").val();
    var zipcode = $("#txtZipCode").val();

    if (!user_name || !user_name.trim()) {
        alert('이름을 입력하세요.');
        $("#txtName").focus();
        return false;
    }

    if (!validatBlank(user_name)) {
        alert('이름에 공백이 존재합니다.');
        $("#txtName").focus();
        return false;
    }

    if (validateNumber(user_name)) {
        alert('이름에 숫자가 존재합니다.');
        $("#txtName").focus();
        return false;
    }

    if (!user_id || !user_id.trim()) {
        alert('아이디를 입력하세요.');
        $("#txtUserId").focus();
        return false;
    }

    if (!validatBlank(user_id)) {
        alert('아이디에 공백이 존재합니다.');
        $("#txtUserId").focus();
        return false;
    }

    if (user_id.length < 5 || user_id.length > 20) {
        alert('아이디는 영문으로 시작하는 5자 이상 20자 이하로 입력하세요.');
        $("#txtUserId").focus();
        return false;
    }

    if (!validateKorean(user_id)) {
        alert('아이디에 한글이 존재합니다.');
        $("#txtUserId").focus();
        return false;
    }

    if (!validateId(user_id)) {
        alert('아이디는 영문으로 시작하는 5자 이상 20자 이하로 입력하세요.');
        $("#txtUserId").focus();
        return false;
    }

    if ($("#txtUserId").data("id-check") != 'Y') {
        alert('아이디 중복확인 버튼을 클릭하세요.');
        return false;
    }

    if (!password || !password.trim()) {
        alert('비밀번호를 입력하세요.');
        $("#txtPassword").focus();
        return false;
    }

    if (!validatBlank(password)) {
        alert('비밀번호에 공백이 존재합니다.');
        $("#txtPassword").focus();
        return false;
    }

    if (password.length < 4) {
        alert('비밀번호를 4자리 이상으로 입력해주세요.');
        $("#txtPassword").focus();
        return false;
    }

    if (password != password_tmp) {
        alert('비밀번호가 일치하지 않습니다.\n다시 확인해주세요');
        $("#txtPasswordConfirm").focus();
        return false;
    }

    if (!email || !email.trim()) {
        alert('이메일을 입력하세요.');
        $("#txtEmail").focus();
        return false;
    }

    if (!validateEmail(email)) {
        alert('정확한 이메일을 입력하세요.');
        $("#txtEmail").focus();
        return false;
    }

    if (!validatBlank(email)) {
        alert('이메일에 공백이 존재합니다.');
        $("#txtEmail").focus();
        return false;
    }

    if (!birth || !birth.trim()) {
        alert('생년월일을 입력하세요.');
        $("#dtBirthday").focus();
        return false;
    }

    if (!user_phone || !user_phone.trim()) {
        alert('전화번호를 입력하세요.');
        $("#txtHp").focus();
        return false;
    }

    if (!validatePhone(user_phone)) {
        alert('정확한 전화번호를 입력하세요.');
        $("#txtHp").focus();
        return false;
    }

    if (!address || !address.trim()) {
        alert('주소를 입력하세요.');
        $("#txtAddr").focus();
        return false;
    }

    if (!zipcode || !zipcode.trim()) {
        alert('우편번호를 입력하세요.');
        $("#txtZipCode").focus();
        return false;
    }

    $.ajax({
        url: '/ajax/employeeControll.ajax.php',
        dataType: 'JSON',
        type: 'POST',
        async: false,
        data: {
            action: 'employeeInsert',
            user_name: user_name,
            user_id: user_id,
            password: password,
            email: email,
            birth: birth,
            gender: gender,
            user_phone: user_phone,
            address: address,
            zipcode: zipcode
        },
        success: function (result) {
            if (result.success) {
                alert(result.msg);
                location.href = '/adm/login.html';
                return false;
            } else {
                alert(result.msg);
                return false;
            }
        },
        error: function (request, status, error) {
            alert("request : " + request + "\n" + "status : " + status + "\n" + "error : " + error);
        }
    });


}

//아이디 유효성 검사
function validateId(text) {
    var check = /^[a-z]+[a-z0-9]{4,19}$/g;
    if (!check.test(text) == true) {
        return false;
    } else {
        return true;
    }
}

//전화번호 체크
function validatePhone(phone) {
    var check = /^[0-9]+$/;
    if (!check.test(phone)) {
        return false;
    } else {
        var regExp = /^01([0|1|6|7|8|9])([0-9]{3,4})([0-9]{4})$/;
        if (!regExp.test(phone)) {
            return false
        } else {
            return true;
        }
    }
}

// Email 유효성 검사
function validateEmail(email) {
    var check = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
    if (check.test(email)) {
        return true;
    } else {
        return false;
    }
}

//한글 체크
function validateKorean(text) {
    var check = /[\u3131-\u314e|\u314f-\u3163|\uac00-\ud7a3]/g;
    if (check.test(text) == true) {
        return false;
    } else {
        return true;
    }
}

//숫자 체크
function validateNumber(text) {
    var check = /[0-9]/g;
    if (check.test(text)) {
        return true;
    } else {
        return false;
    }
}

//공백 체크
function validatBlank(text) {
    var check = /[\s]/g;
    if (check.test(text) == true) {
        return false;
    } else {
        return true;
    }
}