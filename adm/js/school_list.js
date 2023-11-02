$(document).ready(function () {
    getSchoolList();

    $("#btnSave").click(function () {
        schoolInsert();
    });

    $("#btnUpdate").click(function () {
        var school_idx = $("#school_idx").val();
        schoolUpdate(school_idx);
    });

    $("#dataTable").on("click", ".tc", function (e) {
        var school_idx = $(e.target).parent("tr").data("school_idx");
        var targetClass = $(e.target).parents('tr');
        var now_date = new Date();

        if ($(e.target).parent('.bg-light').length) {
            targetClass.removeClass('bg-light');
            $("#school_idx").val('');
            $("#btnUpdate").hide();
            $("#btnDelete").hide();
            $("#btnSave").show();
            $("#selSchoolType").val('');
            $("#selSchoolType").attr("disabled", false);
            $("#txtSchoolName").val('');
            $("#txtManagerName").val('');
            $("#txtManagerTel").val('');
            $("#txtManagerHp").val('');
            $("#txtManagerEmail").val('');
            $("#txtManagerPassword").val('');
            $("#dt_start_date").val(moment(now_date).format('YYYY-MM-DD'));
            $("#dt_end_date").val(moment(now_date).format('YYYY-MM-DD'));
            $("#selOrderState").val('');
            $("#selOrderState").attr("disabled", true);
            $("#txtOrderMethod").val('');
            $("#txtContractNo").val('');
            $("#txtOrderMoney").val('');
            $("#txtOrderMoney").attr("disabled", false);
            $("#txtAccessToken").val('');
            $("#txtAccessToken").attr("disabled", false);
        } else {
            $('.tc').removeClass('bg-light');
            targetClass.addClass('bg-light');
            $("#school_idx").val(school_idx);
            $.ajax({
                url: '/adm/ajax/schoolControll.ajax.php',
                dataType: 'JSON',
                type: 'POST',
                data: {
                    action: 'getSchoolInfo',
                    school_idx: school_idx
                },
                success: function (result) {
                    if (result.success) {
                        $("#selSchoolType option[value=" + result.data.school_type + "]").prop("selected", true);
                        $("#selSchoolType").attr("disabled", true);
                        $("#txtSchoolName").val(result.data.school_name);
                        $("#txtManagerName").val(result.data.manager_name);
                        $("#txtManagerTel").val(result.data.manager_tel);
                        $("#txtManagerHp").val(result.data.manager_hp);
                        $("#txtManagerEmail").val(result.data.manager_email);
                        $("#txtManagerPassword").val('');
                        $("#dt_start_date").val(result.data.start_date);
                        $("#dt_end_date").val(result.data.expire_date);
                        $("#selOrderState option[value=" + result.data.order_state + "]").prop("selected", true);
                        $("#txtOrderMethod").val(result.data.order_method);
                        $("#selOrderState").attr("disabled", false);
                        $("#txtContractNo").val(result.data.contract_no);
                        $("#txtOrderMoney").val(result.data.order_money);
                        $("#txtOrderMoney").attr("disabled", true);
                        $("#txtAccessToken").val(result.data.access_token);
                        $("#txtAccessToken").attr("disabled", true);
                        $("#btnUpdate").show();
                        $("#btnDelete").show();
                        $("#btnSave").hide();
                    } else {
                        alert(result.msg);
                        $("#selSchoolType").val('');
                        $("#selSchoolType").attr("disabled", false);
                        $("#txtSchoolName").val('');
                        $("#txtManagerName").val('');
                        $("#txtManagerTel").val('');
                        $("#txtManagerHp").val('');
                        $("#txtManagerEmail").val('');
                        $("#dt_start_date").val(moment(now_date).format('YYYY-MM-DD'));
                        $("#dt_end_date").val(moment(now_date).format('YYYY-MM-DD'));
                        $("#selOrderState").val('');
                        $("#txtOrderMethod").val('');
                        $("#selOrderState").attr("disabled", true);
                        $("#txtContractNo").val('');
                        $("#txtOrderMoney").val('');
                        $("#txtOrderMoney").attr("disabled", false);
                        $("#txtAccessToken").val('');
                        $("#txtAccessToken").attr("disabled", false);
                        return false;
                    }
                },
                error: function (request, status, error) {
                    alert("request : " + request + "\n" + "status : " + status + "\n" + "error : " + error);
                }
            });
        }
    })
});

function getSchoolList() {
    $.ajax({
        url: '/adm/ajax/schoolControll.ajax.php',
        dataType: 'JSON',
        type: 'POST',
        data: {
            action: 'getSchoolList'
        },
        success: function (result) {
            if (result.success && result.data) {
                $('#dataTable').DataTable({
                    autoWidth: false,
                    destroy: true,
                    data: result.data,
                    stripeClasses: [],
                    dom: "<'col-sm-12'f>t<'col-sm-12'p>",
                    columns: [{
                        data: 'school_idx'
                    },
                    {
                        data: 'school_type'
                    },
                    {
                        data: 'school_name'
                    },
                    {
                        data: 'access_token'
                    },
                    {
                        data: 'start_date'
                    },
                    {
                        data: 'expire_date'
                    },
                    {
                        data: 'reg_date'
                    }],
                    lengthChange: false,
                    info: false,
                    order: [[0, 'desc']],
                    createdRow: function (row, data) {
                        $(row).attr('data-school_idx', data.school_idx);
                        $(row).addClass('text-center align-middle tc');
                        $("td:eq(0)", row).addClass('text-center align-middle');
                        $("td:eq(1)", row).addClass('text-center align-middle');
                        $("td:eq(2)", row).addClass('text-start align-middle');
                        $("td:eq(3)", row).addClass('text-center align-middle');
                        $("td:eq(4)", row).addClass('text-center align-middle');
                        $("td:eq(5)", row).addClass('text-center align-middle');
                        $("td:eq(6)", row).addClass('text-center align-middle');
                        $("th").addClass('text-center align-middle');
                    },
                    displayLength: 15,
                    language: {
                        url: "/json/ko_kr.json",
                    }
                });
            }
        },
        error: function (request, status, error) {
            alert("request : " + request + "\n" + "status : " + status + "\n" + "error : " + error);
        }
    });
}

function schoolInsert() {
    var school_type = $("#selSchoolType").val();
    var school_name = $("#txtSchoolName").val();
    var manager_name = $("#txtManagerName").val();
    var manager_tel = $("#txtManagerTel").val();
    var manager_hp = $("#txtManagerHp").val();
    var manager_email = $("#txtManagerEmail").val();
    var manager_password = $("#txtManagerPassword").val();
    var start_date = $("#dt_start_date").val();
    var end_date = $("#dt_end_date").val();
    var contarct_no = $("#txtContractNo").val();
    var order_money = $("#txtOrderMoney").val();
    var access_token = $("#txtAccessToken").val();

    if (!school_type) {
        alert("학교종류를 선택해주세요.");
        $("#selSchoolType").focus();
        return false;
    }

    if (!school_name) {
        alert("학교이름을 입력해주세요.");
        $("#txtSchoolName").focus();
        return false;
    }

    if (!manager_name) {
        alert("담당자이름을 입력해주세요.");
        $("#txtManagerName").focus();
        return false;
    }

    if (!manager_tel) {
        alert("담당자 전화번호를 입력해주세요.");
        $("#txtManagerTel").focus();
        return false;
    }

    if (!manager_hp) {
        alert("담당자 휴대전화번호를 입력해주세요.");
        $("#txtManagerHp").focus();
        return false;
    }

    if (!manager_email) {
        alert("담당자 이메일을 입력해주세요.");
        $("#txtManagerEmail").focus();
        return false;
    }

    if (!manager_password) {
        alert("담당자 비밀번호를 입력해주세요.");
        $("#txtManagerPassword").focus();
        return false;
    }

    if (manager_password.length < 4) {
        alert("담당자 비밀번호는 4자리 이상으로 입력해주세요.");
        $("#txtManagerPassword").focus();
        return false;
    }

    if (!start_date) {
        alert("시작일을 선택해주세요.");
        $("#dt_start_date").focus();
        return false;
    }

    if (!end_date) {
        alert("종료일을 입력해주세요.");
        $("#dt_end_date").focus();
        return false;
    }

    if (start_date > end_date) {
        alert("시작일, 종료일을 확인해주세요.");
        return false;
    }

    if (!contarct_no) {
        alert("계약 인원수를 입력해주세요.");
        $("#txtContractNo").focus();
        return false;
    }

    if (!order_money) {
        alert("결제금액을 입력해주세요.");
        $("#txtOrderMoney").focus();
        return false;
    }

    if (order_money < 1000) {
        alert("최소 결제 금액은 1000원입니다.");
        $("#txtOrderMoney").focus();
        return false;
    }

    if (!access_token) {
        alert("접근보안코드를 입력해주세요.");
        $("#txtAccessToken").focus();
        return false;
    } else {
        manager_password = CryptoJS.SHA256(manager_password).toString();
        $.ajax({
            url: '/adm/ajax/schoolControll.ajax.php',
            dataType: 'JSON',
            type: 'POST',
            data: {
                action: 'getAccessTokenCheck',
                access_token: access_token
            },
            success: function (result) {
                if (result.success) {
                    if (result.data > 0) {
                        alert("이미 사용 중인 접근보안코드입니다. 다른 접근보안코드를 입력해주세요.");
                        $("#txtAccessToken").focus();
                        return false;
                    } else {
                        $.ajax({
                            url: '/adm/ajax/schoolControll.ajax.php',
                            dataType: 'JSON',
                            type: 'POST',
                            data: {
                                action: 'schoolInfoInsert',
                                school_type: school_type,
                                school_name: school_name,
                                manager_name: manager_name,
                                manager_tel: manager_tel,
                                manager_hp: manager_hp,
                                manager_email: manager_email,
                                manager_password: manager_password,
                                start_date: start_date,
                                end_date: end_date,
                                contarct_no: contarct_no,
                                order_money: order_money,
                                access_token: access_token
                            },
                            success: function (result) {
                                if (result.success) {
                                    alert(result.msg);
                                    getSchoolList();
                                    chk_val = false;
                                    return false;
                                }
                            },
                            error: function (request, status, error) {
                                alert("request : " + request + "\n" + "status : " + status + "\n" + "error : " + error);
                            }
                        });
                    }
                }
            },
            error: function (request, status, error) {
                alert("request : " + request + "\n" + "status : " + status + "\n" + "error : " + error);
                return false;
            }
        });
    }
}

function schoolUpdate(school_idx) {
    var school_name = $("#txtSchoolName").val();
    var manager_name = $("#txtManagerName").val();
    var manager_tel = $("#txtManagerTel").val();
    var manager_hp = $("#txtManagerHp").val();
    var manager_email = $("#txtManagerEmail").val();
    var manager_password = $("#txtManagerPassword").val();
    var start_date = $("#dt_start_date").val();
    var end_date = $("#dt_end_date").val();
    var order_state = $("#selOrderState").val();
    var contract_no = $("#txtContractNo").val();

    if (!school_idx) {
        alert("학교정보가 존재하지 않습니다.");
        return false;
    }

    if (!school_name) {
        alert("학교이름을 입력해주세요.");
        $("#txtSchoolName").focus();
        return false;
    }

    if (!manager_name) {
        alert("담당자이름을 입력해주세요.");
        $("#txtManagerName").focus();
        return false;
    }

    if (!manager_tel) {
        alert("담당자 전화번호를 입력해주세요.");
        $("#txtManagerTel").focus();
        return false;
    }

    if (!manager_hp) {
        alert("담당자 휴대전화번호를 입력해주세요.");
        $("#txtManagerHp").focus();
        return false;
    }

    if (!manager_email) {
        alert("담당자 이메일을 입력해주세요.");
        $("#txtManagerEmail").focus();
        return false;
    }

    if (manager_password && manager_password.length > 1) {
        if (manager_password.length < 4) {
            alert("담당자 비밀번호는 4자리 이상으로 입력해주세요.");
            $("#txtManagerPassword").focus();
            return false;
        } else {
            manager_password = CryptoJS.SHA256(manager_password).toString();
        }
    }

    if (!start_date) {
        alert("시작일을 선택해주세요.");
        $("#dt_start_date").focus();
        return false;
    }

    if (!end_date) {
        alert("종료일을 입력해주세요.");
        $("#dt_end_date").focus();
        return false;
    }

    if (start_date > end_date) {
        alert("시작일, 종료일을 확인해주세요.");
        return false;
    }

    if (!contract_no) {
        alert("계약 인원수를 입력해주세요.");
        $("#txtContractNo").focus();
        return false;
    }

    if (!order_state) {
        alert("결제상태를 선택해주세요.");
        $("#selOrderState").focus();
        return false;
    }

    $.ajax({
        url: '/adm/ajax/schoolControll.ajax.php',
        dataType: 'JSON',
        type: 'POST',
        data: {
            action: 'schoolInfoUpdate',
            school_idx: school_idx,
            school_name: school_name,
            manager_name: manager_name,
            manager_tel: manager_tel,
            manager_hp: manager_hp,
            manager_email: manager_email,
            manager_password: manager_password,
            start_date: start_date,
            end_date: end_date,
            order_state: order_state,
            contract_no: contract_no
        },
        success: function (result) {
            if (result.success) {
                alert(result.msg);
                getSchoolList();
                chk_val = false;
                return false;
            }
        },
        error: function (request, status, error) {
            alert("request : " + request + "\n" + "status : " + status + "\n" + "error : " + error);
        }
    });
}