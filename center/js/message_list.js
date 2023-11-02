$(document).ready(function () {
    getSendMsgList();

    $("#btnSearchSendMsgList").click(function () {
        getSendMsgList();
    });

    $("#btnRevMsgListDelete").click(function () {
        if (rev_arr.length == 0) {
            alert("예약취소하려는 메시지를 선택해주세요.");
            return false;
        }
        $.ajax({
            url: '/center/ajax/messageControll.ajax.php',
            dataType: 'JSON',
            type: 'POST',
            data: {
                action: 'msgListDelete2',
                center_idx: center_idx,
                msg_seq: msg_arr,
                msg_idx: rev_arr
            },
            success: function (result) {
                if (result.success) {
                    alert(result.msg);
                    getSendMsgList();
                    rev_arr = [];
                    return false;
                } else {
                    alert(result.msg);
                    return false;
                }
            },
            error: function (request, status, error) {
                alert("request : " + request + "\n" + "status : " + status + "\n" + "error : " + error);
                return false;
            }
        });
    });

    $("#msgList").on("click", ".tc", function (e) {
        var target_idx = $(e.target).parents("tr").data("msg_idx");
        var targetClass = $(e.target).parents('tr');
        if ($(e.target).parent('.bg-light').length) {
            $('.tc').removeClass('bg-light');
        } else {
            $('.tc').removeClass('bg-light');
            targetClass.addClass('bg-light');
            if (!target_idx) {
                return false;
            } else {
                $.ajax({
                    url: '/center/ajax/messageControll.ajax.php',
                    dataType: 'JSON',
                    type: 'POST',
                    data: {
                        action: 'msgContentLoad',
                        msg_idx: target_idx
                    },
                    success: function (result) {
                        if (result.success && result.data) {
                            $("#txtMsgContentsView").val(result.data.msg_contents);
                            return false;
                        } else {
                            $("#txtMsgContentsView").val('');
                            return false;
                        }
                    },
                    error: function (request, status, error) {
                        alert("request : " + request + "\n" + "status : " + status + "\n" + "error : " + error);
                        $("#txtMsgContentsView").val('');
                        return false;
                    }
                });
            }
        }
    });

    $("#msgTable").on('page.dt', function () {
        $('#chkAllSendMsg').prop('checked', false);
    });

    // 리스트 체크박스 체크 이벤트
    $("#msgList").on("change", ".revchk", function (e) {
        chkRevMsgArray(e);
    });

    // 리스트 항목 예약취소 버튼 클릭 이벤트
    $("#msgList").on("click", ".revdelbtn", function () {
        var target_idx = $(this).parents("tr").data("msg_idx");
        var target_seq = $(this).parents("tr").data("msg_seq");
        if (!target_idx) {
            return false;
        } else {
            $.ajax({
                url: '/center/ajax/messageControll.ajax.php',
                dataType: 'JSON',
                type: 'POST',
                data: {
                    action: 'msgListDelete',
                    center_idx: center_idx,
                    msg_seq: target_seq,
                    msg_idx: target_idx
                },
                success: function (result) {
                    if (result.success) {
                        alert(result.msg);
                        getSendMsgList();
                        return false;
                    } else {
                        alert(result.msg);
                        return false;
                    }
                },
                error: function (request, status, error) {
                    alert("request : " + request + "\n" + "status : " + status + "\n" + "error : " + error);
                    return false;
                }
            });
        }
    });

    // 리스트 헤더 체크박스 체크 이벤트
    $('#msgTable > thead').on('change', "#chkAllSendMsg", function () {
        if ($('#chkAllSendMsg').is(':checked') == true) {
            $('.revchk').prop('checked', true);
            $('.revchk').trigger("change");
        } else {
            $('.revchk').prop('checked', false);
            $('.revchk').trigger("change");
        }
    });
});

function getSendMsgList() {
    var user_idx = $("#selSendTeacher").val();
    var months = $("#dtSendMsgMonths").val();

    $.ajax({
        url: '/center/ajax/messageControll.ajax.php',
        dataType: 'JSON',
        type: 'POST',
        data: {
            action: 'msgListLoad',
            center_idx: center_idx,
            user_idx: user_idx,
            months: months
        },
        success: function (result) {
            if (result.success && result.data) {
                $('#msgTable').DataTable({
                    autoWidth: false,
                    destroy: true,
                    data: result.data,
                    stripeClasses: [],
                    dom: "<'col-sm-12'f>t<'col-sm-12'p>",
                    columns: [{
                        data: 'regchk'
                    },
                    {
                        data: 'no'
                    },
                    {
                        data: 'to_no'
                    },
                    {
                        data: 'from_no'
                    },
                    {
                        data: 'msgType'
                    },
                    {
                        data: 'msg_state_detail'
                    },
                    {
                        data: 'rev_datetime'
                    },
                    {
                        data: 'reg_send_date'
                    },
                    {
                        data: 'revdelbtn'
                    }],
                    order: [[1, 'desc']],
                    lengthChange: false,
                    info: false,
                    displayLength: 15,
                    createdRow: function (row, data) {
                        $("td:eq(0)", row).addClass('text-center align-middle');
                        $("td:eq(1)", row).addClass('text-center align-middle');
                        $("td:eq(3)", row).addClass('text-center align-middle');
                        $("td:eq(4)", row).addClass('text-center align-middle');
                        $("td:eq(5)", row).addClass('text-center align-middle');
                        $("td:eq(6)", row).addClass('text-center align-middle');
                        $("td:eq(7)", row).addClass('text-center align-middle');
                        $("td:eq(8)", row).addClass('text-center align-middle');
                        $("th").addClass('text-center align-middle');
                        $(row).attr('data-msg_idx', data.msg_idx);
                        $(row).attr('data-msg_seq', data.msg_seq);
                        $(row).attr('data-msg_state', data.msg_state);
                        $(row).addClass('tc text-center align-middle');
                    },
                    language: {
                        url: '/json/ko_kr.json'
                    }
                });
            } else {
                alert(result.msg);
                $('#msgTable').DataTable().destroy();
                $("#msgList").empty();
                return false;
            }
        },
        error: function (request, status, error) {
            alert("request : " + request + "\n" + "status : " + status + "\n" + "error : " + error);
            $('#msgTable').DataTable().destroy();
            $("#msgList").empty();
            return false;
        }
    });
}

function getRevMsgChkList() {
    rev_arr = new Array();
    seq_arr = new Array();
    $("#msgList tr").each(function () {
        if (!this.rowIndex) return false;
        rev_arr.push($(this).parents("tr").data("msg_idx"));
        seq_arr.push($(this).parents("tr").data("msg_seq"));
    });
}

function chkRevMsgArray(e) {
    if ($(e.target).is(":checked") == true) {
        rev_arr.push($(e.target).parents("tr").data("msg_idx"));
        seq_arr.push($(e.target).parents("tr").data("msg_seq"));
    } else {
        rev_arr = rev_arr.filter((element) => element[0] !== $(e.target).parents("tr").data("msg_idx"));
        seq_arr = seq_arr.filter((element) => element[0] !== $(e.target).parents("tr").data("msg_seq"));
    }
}