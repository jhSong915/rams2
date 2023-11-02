<?php
include_once $_SERVER["DOCUMENT_ROOT"] . "/_config/session_start.php";
include_once $_SERVER["DOCUMENT_ROOT"] . "/common/dbClass.php";
$db = new DBCmp();
include_once $_SERVER["DOCUMENT_ROOT"] . "/common/commonClass.php";
include_once $_SERVER["DOCUMENT_ROOT"] . "/common/function.php";
$infoClassCmp = new infoClassCmp();
$teacherList = $infoClassCmp->teacherList($_SESSION['center_idx']);
?>
<script>
    var center_idx = '<?= $_SESSION['center_idx'] ?>';
    var user_idx = '<?= $_SESSION['logged_no'] ?>';
    var user_phone = '<?= $_SESSION['logged_phone'] ?>';
    var rev_arr = [];
    var seq_arr = [];
</script>
<script type="text/javascript" src="js/message_list.js?v=<?= date('YmdHis') ?>"></script>
<div class="row mt-2">

    <!-- 조회 목록 검색 조건 -->
    <div class="col-12 mb-2">
        <div class="card border-left-primary shadow">
            <div class="card-header">
                <h6>문자발송 내역</h6>
            </div>
            <div class="card-body">
                <div class="input-group input-group-sm mb-2">
                    <div class="form-inline align-self-center me-2">
                        <div class="form-floating">
                            <input type="month" id="dtSendMsgMonths" class="form-control" value="<?= date('Y-m') ?>" />
                            <label for="dtSendMsgMonths">발송년월</label>
                        </div>
                    </div>
                    <div class="form-inline align-self-center me-2">
                        <div class="form-floating">
                            <select id="selSendTeacher" class="form-select" <?= $_SESSION['is_admin'] == 'Y' ? '' : 'disabled' ?>>
                                <option value="">전체</option>
                                <?php
                                foreach ($teacherList as $key => $val) {
                                    if ($val['user_no'] == $_SESSION['logged_no']) {
                                        echo "<option value=\"" . $val['user_no'] . "\" selected>" . $val['user_name'] . "</option>";
                                    } else {
                                        echo "<option value=\"" . $val['user_no'] . "\">" . $val['user_name'] . "</option>";
                                    }
                                }
                                ?>

                            </select>
                            <label for="selSendTeacher">담당</label>
                        </div>
                    </div>
                    <div class="form-inline align-self-center me-2">
                        <button id="btnSearchSendMsgList" class="btn btn-sm btn-outline-secondary" type="button"><i class="fa-solid fa-magnifying-glass me-1"></i>검색</button>
                        <button id="btnRevMsgListDelete" class="btn btn-sm btn-outline-danger" type="button"><i class="fa-solid fa-xmark me-1"></i>예약취소</button>
                    </div>
                </div>
                <div class="row">
                    <div class="col-8">
                        <table id="msgTable" class="table table-sm table-bordered table-hover">
                            <thead class="align-middle text-center">
                                <th width="5%"><input type="checkbox" id="chkAllSendMsg" class="form-check-input" /></th>
                                <th width="5%">번호</th>
                                <th width="10%">수신번호</th>
                                <th width="10%">발신번호</th>
                                <th width="10%">메시지종류</th>
                                <th width="15%">상태</th>
                                <th width="15%">예약발송일시</th>
                                <th width="20%">등록일시(발송일시)</th>
                                <th width="10%">처리</th>
                            </thead>
                            <tbody id="msgList" class="align-middle text-center"></tbody>
                        </table>
                    </div>
                    <div class="col-4">
                        <div class="input-group">
                            <label for="txtMsgContentsView">메시지 내용</label>
                        </div>
                        <div class="input-group">
                            <textarea id="txtMsgContentsView" class="form-control" rows="18" readonly></textarea>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>