$(document).ready(function () {
    var school_idx = $("#hd_school_idx").val();
    getTotalAnalytics(school_idx);
    getGradeAnalytics(school_idx);
    getClassAnalytics(school_idx);
    getGenderAnalytics(school_idx)
    getGradeClass(school_idx);

    $("#btnLinkCopy").click(function () {
        var linkData = location.origin + "/school/reading_diagnosis_index.php?ackt=" + access_token;
        let tmpInput = document.createElement("input");
        tmpInput.value = linkData;

        document.body.appendChild(tmpInput);
        tmpInput.select();
        document.execCommand("copy");
        document.body.removeChild(tmpInput);
        var toast = new bootstrap.Toast(document.getElementById("AlertToast"));
        toast.show();
        return false;
    });

    $("#btnLinkQRCode").click(function () {
        $("#qrcode_div").qrcode({
            // mode : 0 - 일반, 1 - 라벨, 2 - 라벨 박스, 3 - 이미지, 4 - 이미지 박스
            mode: 0,
            //label: "라벨 문자열",
            text: location.origin + "/school/reading_diagnosis_index.php?ackt=" + access_token,
            //fontname: "폰트명",
            fontcolor: "#000000",
            //image: "/path/to/img.png",
            // "canvas", "image", "div"
            render: "image",
            //에러 레벨 "L", "M", "Q", "H"
            ecLevel: "L",
            //오프셋
            //top: 0,
            //left: 0,
            //사이즈 단위 PX
            size: 200,
            //코드 색상 또는 이미지
            //fill: "#000000",
            //백그라운드 색상 또는 이미지
            background: null,
            //테두리 둥글게
            radius: 0,
            quiet: 0,
            mSize: 0.1,
            mPosX: 0.5,
            mPosY: 0.5
        });
    })

    $("#btnQRImageSave").click(function() {
        html2canvas($("#qrcode_div")[0]).then(function(canvas) {
            var QRCode_img = document.createElement("a");
            QRCode_img.download = "접속링크qrcode.png";
            QRCode_img.href = canvas.toDataURL();
            document.body.appendChild(QRCode_img);
            QRCode_img.click();
            document.body.removeChild(QRCode_img);
        });
    });

    $("#grade_classTable > tbody").on("click", ".tc", function (e) {
        var targetClass = $(e.target).parents('tr');
        var std_grade = $(e.target).parent('tr').data('std_grade');
        var std_class = $(e.target).parent('tr').data('std_class');

        if ($(e.target).parents('.table-light').length) {
            targetClass.removeClass('table-light');
            $("#grade_classViewerTable").DataTable().destroy();
            $("#grade_classViewerTable > tbody").empty();
        } else {
            $('.tc').removeClass('table-light');
            targetClass.addClass('table-light');
            getGradeClassDetail(school_idx, std_grade, std_class);
        }
    });

    $("#btnAccountUpdate").click(function () {
        var email = $("#txtManagerEmail").val();
        var manager_name = $("#txtManagerName").val();
        var manager_tel = $("#txtManagerTel").val();
        var manager_hp = $("#txtManagerHp").val();
        var current_pw = $("#txtCurrentPassword").val();
        var password = $("#txtNewPassword").val();
        var password2 = $("#txtNewPassword2").val();

        if (!manager_name || manager_name == "") {
            alert("담당자 이름을 입력해주세요.");
            $("txtManagerName").focus();
            return false;
        }

        if (!manager_tel || manager_tel == "" || manager_tel.length < 8) {
            alert("담당자 연락처를 입력해주세요.");
            $("txtManagerTel").focus();
            return false;
        }

        if (!manager_hp || manager_hp == "" || manager_hp.length != 11) {
            alert("담당자 연락처(휴대전화)를 입력해주세요.");
            $("txtManagerHp").focus();
            return false;
        }

        if (email || email != "") {
            var regExp_email = new RegExp("([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\"\(\[\]!#-[^-~ \t]|(\\[\t -~]))+\")@([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\[[\t -Z^-~]*])");

            if (!regExp_email.test(email)) {
                alert("이메일 형식에 맞게 입력해주세요.");
                $("txtManagerEmail").focus();
                return false;
            }
        }
        getCurrentPassword(school_idx, current_pw);

        if (pw_chk !== true) {
            alert("현재 비밀번호가 일치하지 않습니다. 다시 한 번 확인해주세요.");
            $("#txtCurrentPassword").focus();
            return false;
        }
        if (!password || !password2) {
            if (current_pw == password || current_pw == password2) {
                alert("현재 비밀번호와 변경하려고 하는 비밀번호가 일치합니다. 다른 비밀번호를 입력해주세요.");
                return false;
            }

            if (password !== password2) {
                alert("변경할 비밀번호가 일치하지 않습니다. 다시 한 번 확인해주세요.");
                return false;
            }
        }

        password = CryptoJS.SHA256(password).toString();

        $.ajax({
            url: '/school/ajax/readingDiagnosis.ajax.php',
            dataType: 'JSON',
            type: 'POST',
            data: {
                action: "accountInfoUpdate",
                school_idx: school_idx,
                manager_email: email,
                manager_name: manager_name,
                manager_tel: manager_tel,
                manager_hp: manager_hp,
                password: password,
            },
            async: false,
            success: function (result) {
                if (result.success) {
                    alert(result.msg);
                    location.reload();
                    return false;
                }
            },
            error: function (request, status, error) {
                console.log("request : " + request + "\n" + "status : " + status + "\n" + "error : " + error);
                return false;
            }
        });
    });

    $('#txtManagerHp').on('propertychange change keyup paste input', function () {
        var value = $(this).val();
        $(this).val(value.replace(/[^0-9.]/g, ''));
    });

    $('#txtManagerTel').on('propertychange change keyup paste input', function () {
        var value = $(this).val();
        $(this).val(value.replace(/[^0-9.]/g, ''));
    });
});

function getCurrentPassword(school_idx, current_password) {
    current_password = CryptoJS.SHA256(current_password).toString();
    $.ajax({
        url: '/school/ajax/readingDiagnosis.ajax.php',
        dataType: 'JSON',
        type: 'POST',
        data: {
            action: "getPasswordCheck",
            school_idx: school_idx,
            current_password: current_password,
        },
        async: false,
        success: function (result) {
            if (result.success && result.data) {
                if (result.data.chk == "t") {
                    pw_chk = true;
                } else {
                    pw_chk = false;
                }
                return false;
            } else {
                pw_chk = false;
                return false;
            }
        },
        error: function (request, status, error) {
            console.log("request : " + request + "\n" + "status : " + status + "\n" + "error : " + error);
            return false;
        }
    });
}

function setPassword(school_idx, password) {
    password = CryptoJS.SHA256(password).toString();
    $.ajax({
        url: '/school/ajax/readingDiagnosis.ajax.php',
        dataType: 'JSON',
        type: 'POST',
        data: {
            action: "schoolPasswordUpdate",
            school_idx: school_idx,
            current_password: current_password,
        },
        async: false,
        success: function (result) {
            if (result.success && result.data) {
                console.log(result.data.chk);
                if (result.data.chk == "t") {
                    pw_chk = true;
                } else {
                    pw_chk = false;
                }
                return false;
            } else {
                pw_chk = false;
                return false;
            }
        },
        error: function (request, status, error) {
            console.log("request : " + request + "\n" + "status : " + status + "\n" + "error : " + error);
            return false;
        }
    });
}

function btnViewerClick(std_grade, std_class, std_no) {
    var form = document.getElementById("resultViewerFrom");
    $("#hd_std_grade").val(std_grade);
    $("#hd_std_class").val(std_class);
    $("#hd_std_no").val(std_no);
    window.open("", "popupName", "width=1000, height=800, left=" + Math.ceil((window.screen.width - 700) / 2) + ", top=" + Math.ceil((window.screen.height - 800) / 2));
    form.target = 'popupName';
    form.submit();
}

function getTotalAnalytics(school_idx) {
    $.ajax({
        url: '/school/ajax/readingDiagnosis.ajax.php',
        dataType: 'JSON',
        type: 'POST',
        data: {
            action: "getTotalAnalytics",
            school_idx: school_idx,
        },
        async: false,
        success: function (result) {
            if (result.success) {
                $("#totalTable").DataTable({
                    autoWidth: false,
                    destroy: true,
                    displayLength: 1,
                    data: result.data,
                    stripeClasses: [],
                    columns: [{
                        data: 'contract_no'
                    },{
                        data: 'cnt'
                    }],
                    createdRow: function (row, data) {
                        $("th").addClass('text-center align-middle');
                        $(row).addClass('align-middle text-center tc');
                    },
                    lengthChange: false,
                    ordering: false,
                    paging: false,
                    searching: false,
                    info: false,
                    dom: '<"col-sm-12"f>t<"col-sm-12"p>',
                    language: {
                        url: "/json/ko_kr.json",
                    },
                });
            }
        },
        error: function (request, status, error) {
            console.log("request : " + request + "\n" + "status : " + status + "\n" + "error : " + error);
        }
    });
}

function getGradeAnalytics(school_idx) {
    $.ajax({
        url: '/school/ajax/readingDiagnosis.ajax.php',
        dataType: 'JSON',
        type: 'POST',
        data: {
            action: "getGradeAnalytics",
            school_idx: school_idx,
        },
        async: false,
        success: function (result) {
            if (result.success) {
                $("#gradeTable").DataTable({
                    autoWidth: false,
                    destroy: true,
                    displayLength: 6,
                    data: result.data,
                    stripeClasses: [],
                    columns: [{
                        data: 'std_grade'
                    }, {
                        data: 'cnt'
                    }],
                    createdRow: function (row, data) {
                        $("th").addClass('text-center align-middle');
                        $(row).addClass('align-middle text-center tc');
                    },
                    lengthChange: false,
                    searching: false,
                    info: false,
                    dom: '<"col-sm-12"f>t<"col-sm-12"p>',
                    language: {
                        url: "/json/ko_kr.json",
                    },
                });
            }
        },
        error: function (request, status, error) {
            console.log("request : " + request + "\n" + "status : " + status + "\n" + "error : " + error);
        }
    });
}

function getClassAnalytics(school_idx) {
    $.ajax({
        url: '/school/ajax/readingDiagnosis.ajax.php',
        dataType: 'JSON',
        type: 'POST',
        data: {
            action: "getClassAnalytics",
            school_idx: school_idx,
        },
        async: false,
        success: function (result) {
            if (result.success) {
                $("#classTable").DataTable({
                    autoWidth: false,
                    destroy: true,
                    displayLength: 10,
                    data: result.data,
                    stripeClasses: [],
                    columns: [{
                        data: 'std_grade'
                    }, {
                        data: 'std_class'
                    }, {
                        data: 'cnt'
                    }],
                    createdRow: function (row, data) {
                        $("th").addClass('text-center align-middle');
                        $(row).addClass('align-middle text-center tc');
                    },
                    lengthChange: false,
                    searching: false,
                    info: false,
                    dom: '<"col-sm-12"f>t<"col-sm-12"p>',
                    language: {
                        url: "/json/ko_kr.json",
                    },
                });
            }
        },
        error: function (request, status, error) {
            console.log("request : " + request + "\n" + "status : " + status + "\n" + "error : " + error);
        }
    });
}

function getGenderAnalytics(school_idx) {
    $.ajax({
        url: '/school/ajax/readingDiagnosis.ajax.php',
        dataType: 'JSON',
        type: 'POST',
        data: {
            action: "getGenderAnalytics",
            school_idx: school_idx,
        },
        async: false,
        success: function (result) {
            if (result.success) {
                $("#genderTable").DataTable({
                    autoWidth: false,
                    destroy: true,
                    displayLength: 3,
                    data: result.data,
                    stripeClasses: [],
                    columns: [{
                        data: 'std_gender'
                    }, {
                        data: 'cnt'
                    }],
                    createdRow: function (row, data) {
                        $("th").addClass('text-center align-middle');
                        $(row).addClass('align-middle text-center tc');
                    },
                    lengthChange: false,
                    paging: false,
                    searching: false,
                    info: false,
                    dom: '<"col-sm-12"f>t<"col-sm-12"p>',
                    language: {
                        url: "/json/ko_kr.json",
                    },
                });
            }
        },
        error: function (request, status, error) {
            console.log("request : " + request + "\n" + "status : " + status + "\n" + "error : " + error);
        }
    });
}

function getGradeClass(school_idx) {
    $.ajax({
        url: '/school/ajax/readingDiagnosis.ajax.php',
        dataType: 'JSON',
        type: 'POST',
        data: {
            action: "getGradeClass",
            school_idx: school_idx,
        },
        async: false,
        success: function (result) {
            if (result.success) {
                $("#grade_classTable").DataTable({
                    autoWidth: false,
                    destroy: true,
                    displayLength: 10,
                    data: result.data,
                    stripeClasses: [],
                    columns: [{
                        data: 'std_grade'
                    }, {
                        data: 'std_class'
                    }, {
                        data: 'cnt'
                    }],
                    createdRow: function (row, data) {
                        $(row).addClass('align-middle tc');
                        $(row).attr('data-std_grade', data.std_grade);
                        $(row).attr('data-std_class', data.std_class);
                    },
                    lengthChange: false,
                    info: false,
                    dom: '<"col-sm-12"f>t<"col-sm-12"p>',
                    language: {
                        url: "/json/ko_kr.json",
                    },
                });
            }
        },
        error: function (request, status, error) {
            console.log("request : " + request + "\n" + "status : " + status + "\n" + "error : " + error);
        }
    });
}



function getGradeClassDetail(school_idx, std_grade, std_class) {
    $.ajax({
        url: '/school/ajax/readingDiagnosis.ajax.php',
        dataType: 'JSON',
        type: 'POST',
        data: {
            action: "getGradeClassDetail",
            school_idx: school_idx,
            std_grade: std_grade,
            std_class: std_class,
        },
        async: false,
        success: function (result) {
            if (result.success) {
                $("#grade_classViewerTable").DataTable({
                    autoWidth: false,
                    destroy: true,
                    displayLength: 15,
                    data: result.data,
                    stripeClasses: [],
                    columns: [{
                        data: 'std_grade'
                    }, {
                        data: 'std_class'
                    }, {
                        data: 'std_no'
                    }, {
                        data: 'view_btn'
                    }],
                    createdRow: function (row, data) {
                        $(row).addClass('align-middle vtc');
                        $(row).attr('data-std_grade', data.std_grade);
                        $(row).attr('data-std_class', data.std_class);
                        $(row).attr('data-std_no', data.std_no);
                    },
                    lengthChange: false,
                    info: false,
                    dom: '<"col-sm-12"f>t<"col-sm-12"p>',
                    language: {
                        url: "/json/ko_kr.json",
                    },
                });
            } else {
                $('#grade_classViewerTable').DataTable().destroy();
            }
        },
        error: function (request, status, error) {
            console.log("request : " + request + "\n" + "status : " + status + "\n" + "error : " + error);
        }
    });
}