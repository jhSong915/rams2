$(document).ready(function () {
    getPointList();

    $("#dtYear").datepicker({
        language: 'ko-Kr',
        format: 'yyyy'
    });

    $("#btnSearch").click(function () {
        getPointList();
    })

    $('#txtPoint').on('propertychange change keyup paste input', function () {
        var value = $(this).val();
        $(this).val(value.replace(/[^0-9.]/g, ''));
    });

    $("#btnSave").click(function () {
        var franchise_idx = $("#selFranchisee").val();
        var point = $("#txtPoint").val();

        if (!franchise_idx) {
            alert("센터를 선택해주세요.");
            return false;
        }

        if (!point) {
            alert("지급할 포인트를 입력하세요.");
            $("#txtPoint").focus();
            return false;
        }

        if (confirm('포인트를 지급하시겠습니까?')) {
            $.ajax({
                url: '/adm/ajax/franchiseControll.ajax.php',
                dataType: 'JSON',
                type: 'POST',
                data: {
                    action: 'giveFranchiseePoint',
                    franchise_idx: franchise_idx,
                    point: point
                },
                success: function (result) {
                    if (result.success) {
                        alert(result.msg);
                        location.reload();
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
    });
});

function getPointList() {
    var year = $("#dtYear").val();
    $.ajax({
        url: '/adm/ajax/franchiseControll.ajax.php',
        dataType: 'JSON',
        type: 'POST',
        data: {
            action: 'getPointList',
            year: year
        },
        success: function (result) {
            if (result.success && result.data) {
                $("#pointList").html(result.data.tbl);
                return false;
            } else {
                alert(result.msg);
                $("#pointList").empty();
                return false;
            }
        },
        error: function (request, status, error) {
            alert("request : " + request + "\n" + "status : " + status + "\n" + "error : " + error);
        }
    });
}