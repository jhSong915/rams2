<?php
include_once $_SERVER["DOCUMENT_ROOT"] . "/_config/session_start.php";
include_once $_SERVER["DOCUMENT_ROOT"] . "/common/dbClass.php";
$db = new DBCmp();
include_once $_SERVER["DOCUMENT_ROOT"] . "/common/commonClass.php";
include_once $_SERVER["DOCUMENT_ROOT"] . "/common/function.php";
$infoClassCmp = new infoClassCmp();
$codeInfoCmp = new codeInfoCmp();
$teacherList = $infoClassCmp->teacherList($_SESSION['center_idx']);
$gradeList = $codeInfoCmp->getCodeInfo('02');
?>
<script>
    var center_idx = '<?= $_SESSION['center_idx'] ?>';
    var user_idx = '<?= $_SESSION['logged_no'] ?>';
    var user_phone = '<?= $_SESSION['logged_phone'] ?>';
    var msg_arr = [];
    var smslist_arr = [];
</script>
<script type="text/javascript" src="js/message.js?v=<?= date('YmdHis') ?>"></script>
<div class="row mt-2">

    <!-- 조회 목록 검색 조건 -->
    <div class="col-12 mb-2">
        <div class="card border-left-primary shadow">
            <div class="card-header">
                <h6>문자발송</h6>
            </div>
            <div class="card-body">
                <div class="input-group input-group-sm">
                    <div class="form-inline align-self-center me-2">
                        <div class="form-floating">
                            <select id="selKind" class="form-select">
                                <option value="">선택</option>
                                <option value="1">학생</option>
                                <option value="2">직원</option>
                                <option value="3">그룹</option>
                                <option value="4">수업</option>
                                <option value="5">휴원</option>
                                <option value="6">퇴원</option>
                                <option value="7">신규상담</option>
                                <option value="8">정규상담</option>
                            </select>
                            <label for="selKind">분류</label>
                        </div>
                    </div>
                    <div id="divGrade" class="form-inline align-self-center searchdiv me-2">
                        <div class="form-floating">
                            <select id="selMsgGrade" class="form-select">
                                <option value="">선택</option>
                                <?php
                                foreach ($gradeList as $key => $val) {
                                    echo "<option value=\"" . $val['code_num2'] . "\">" . $val['code_name'] . "</option>";
                                }
                                ?>
                            </select>
                            <label for="selMsgGrade">학년</label>
                        </div>
                    </div>

                    <div id="divTeacher" class="form-inline align-self-center searchdiv me-2">
                        <div class="form-floating">
                            <select id="selInCharge" class="form-select">
                                <option value="">선택</option>
                                <?php
                                foreach ($teacherList as $key => $val) {
                                    echo "<option value=\"" . $val['user_no'] . "\">" . $val['user_name'] . "</option>";
                                }
                                ?>
                            </select>
                            <label for="selInCharge">담당</label>
                        </div>
                    </div>

                    <div id="divGroup" class="form-inline align-self-center searchdiv me-2">
                        <div class="form-floating">
                            <select id="selGroup" class="form-select">
                                <option value="">선택</option>
                                <?php
                                $sql = "SELECT group_idx, group_name FROM msg_groupM WHERE franchise_idx = '" . $_SESSION['center_idx'] . "' AND user_idx = '" . $_SESSION['logged_no'] . "'";
                                $groupList = $db->sqlRowArr($sql);
                                foreach ($groupList as $key => $val) {
                                    echo "<option value=\"" . $val['group_idx'] . "\">" . $val['group_name'] . "</option>";
                                }
                                ?>
                            </select>
                            <label for="selGroup">그룹</label>
                        </div>
                    </div>

                    <div id="divLesson" class="form-inline align-self-center searchdiv me-2">
                        <div class="form-floating">
                            <select id="selLesson" class="form-select">
                                <option value="">선택</option>
                            </select>
                            <label for="selLesson">수업</label>
                        </div>
                    </div>

                    <div id="divRest" class="form-inline align-self-center searchdiv me-2">
                        <div class="form-floating">
                            <input type="month" id="dtRestMonth" class="form-control" value="<?= date('Y-m') ?>">
                            <label for="dtRestMonth">휴원</label>
                        </div>
                    </div>

                    <div id="divOut" class="form-inline align-self-center searchdiv me-2">
                        <div class="form-floating">
                            <input type="month" id="dtOutMonth" class="form-control" value="<?= date('Y-m') ?>">
                            <label for="dtOutMonth">퇴원</label>
                        </div>
                    </div>

                    <div id="divNewCounsel" class="form-inline align-self-center searchdiv me-2">
                        <div class="form-floating">
                            <input type="month" id="dtNewCounselMonth" class="form-control" value="<?= date('Y-m') ?>">
                            <label for="dtNewCounselMonth">신규상담</label>
                        </div>
                    </div>

                    <div id="divCounsel" class="form-inline align-self-center searchdiv me-2">
                        <div class="form-floating">
                            <input type="month" id="dtCounselMonth" class="form-control" value="<?= date('Y-m') ?>">
                            <label for="dtCounselMonth">정규상담</label>
                        </div>
                    </div>

                    <div class="form-inline align-self-center me-2">
                        <button id="btnSearchMsgList" class="btn btn-sm btn-outline-secondary" type="button"><i class="fa-solid fa-magnifying-glass me-1"></i>검색</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 조회 목록 (메세지 발송전) -->
    <div class="col-3">
        <div class="card border-left-primary shadow">
            <div class="card-header">
                <h6>조회목록</h6>
            </div>
            <div class="card-body">
                <table id="MsgInfoTable" class="table table-sm table-bordered table-hover">
                    <thead class="text-center align-middle">
                        <th><input type="checkbox" id="chkAllCheck" class="form-check-input" /></th>
                        <th>이름</th>
                        <th>전화번호</th>
                    </thead>
                    <tbody></tbody>
                </table>
                <div class="text-end">
                    <button type="button" id="btnMsgListMove" class="btn btn-sm btn-outline-secondary"><i class="fa-solid fa-arrow-right-to-bracket"></i></button>
                </div>
            </div>
        </div>
    </div>
    <div class="col-9">
        <div class="card border-left-primary shadow h-100">
            <div class="card-header">
                <div class="row">
                    <div class="col align-self-center">
                        <h6>메시지</h6>
                    </div>
                    <div class="col-auto">
                        <button type="button" id="btnMessageGuideView" class="btn btn-sm btn-outline-secondary" data-bs-target="#messageInfoModal" data-bs-toggle="modal"><i class="fa-regular fa-circle-question me-1"></i>도움말</button>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <div class="row">

                    <!-- 메세지 발송 목록 -->
                    <div class="col-5">
                        <div>
                            <label>직접입력</label>
                            <div class="input-group">
                                <div class="form-inline me-2">
                                    <div class="form-floating">
                                        <input type="text" id="txtSendMsgName" class="form-control" maxlength="10" placeholder="이름" />
                                        <label for="txtSendMsgName">이름</label>
                                    </div>
                                </div>
                                <div class="form-inline me-2">
                                    <div class="form-floating">
                                        <input type="text" id="txtSendMsgHp" class="form-control" maxlength="13" placeholder="전화번호" />
                                        <label for="txtSendMsgHp">전화번호</label>
                                    </div>
                                </div>
                                <div class="form-inline align-self-center">
                                    <button type="button" id="btnDirectAdd" class="btn btn-sm btn-outline-secondary"><i class="fa-solid fa-plus me-1"></i>추가</button>
                                </div>
                            </div>
                            <div>
                                <label class="form-label">발송목록</label>
                                <div class="input-group mb-2">
                                    <div class="form-inline me-2">
                                        <div class="form-floating">
                                            <input type="text" id="txtMsgGroupName" class="form-control" placeholder="그룹이름" />
                                            <label for="txtMsgGroupName">그룹이름</label>
                                        </div>
                                    </div>
                                    <div class="form-inline align-self-center">
                                        <button type="button" id="btnGroupAdd" class="btn btn-sm btn-outline-secondary"><i class="fa-solid fa-user-group me-1"></i>그룹저장</button>
                                    </div>
                                </div>
                                <table class="table table-sm table-bordered table-hover" style="width:fit-content; max-height: 550px; overflow-y:scroll; display:inline-block;">
                                    <thead class="text-center align-middle">
                                        <th>이름</th>
                                        <th>전화번호</th>
                                        <th>삭제</th>
                                    </thead>
                                    <tbody class="direct-add" id="smsList"></tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div class="col-7">
                        <!-- 저장 메세지 목록 (미리보기, 저장메세지 삭제) -->
                        <div class="input-group mb-2">
                            <div class="form-floating">
                                <select id="selSaveMsg" class="form-select">
                                    <option value="">선택</option>
                                </select>
                                <label for="selSaveMsg">저장 메시지</label>
                            </div>
                            <button type="button" id="btnSaveMsgDelete" class="btn btn-sm btn-outline-danger"><i class="fa-solid fa-trash me-1"></i>삭제</button>
                        </div>
                        <!-- 메세지 입력, 예약, 발송 -->
                        <div class="input-group input-group-sm">
                            <label class="form-label" for="txtMsg">내용</label>
                        </div>
                        <div class="input-group input-group-sm">
                            <textarea id="txtMsg" class="form-control form-control-sm" rows="16" maxlength="1500"></textarea>
                        </div>
                        <div class="input-group input-group-sm">
                            <input type="text" id="lblMsg" class="form-control text-end" value="SMS  |  0 Bytes" disabled>
                        </div>
                        <div class="form-floating align-middle">
                            <input type="text" id="txtMsgTitle" class="form-control" placeholder="메시지 저장 제목" maxlength="25">
                            <label for="txtMsgTitle">메시지 저장 제목</label>
                        </div>
                        <div class="input-group align-middle mb-2">
                            <input type="file" id="AttachImageFile" class="form-control" placeholder="첨부 이미지">
                        </div>
                        <div class="input-group">
                            <div class="form-inline align-self-center me-2">
                                <label for="chkCenterNumberSend">센터번호로 발송&nbsp;</label>
                                <input type="checkbox" id="chkCenterNumberSend" class="form-check-input" />
                            </div>
                            <div class="form-inline align-self-center me-2">
                                <label for="chkReservationMsg">예약문자&nbsp;</label>
                                <input type="checkbox" id="chkReservationMsg" class="form-check-input" />
                            </div>
                            <div class="form-inline">
                                <input type="date" id="dtReservationD" class="form-control" value="<?= date('Y-m-d') ?>" style="display: none;" />
                            </div>
                            <div class="form-inline">
                                <input type="time" id="dtReservationT" class="form-control" value="<?= (date('H:i') . ":00") ?>" style="display: none;" />
                            </div>
                        </div>
                    </div>
                    <div class="text-end mt-2">

                        <button type="button" id="btnMsgSave" class="btn btn-sm btn-outline-success"><i class="fa-solid fa-comment-medical me-1"></i>메시지저장</button>
                        <button type="button" id="btnMsgSend" class="btn btn-sm btn-outline-primary"><i class="fa-regular fa-message me-1"></i>발송</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="messageInfoModal" tabindex="-1" aria-labelledby="ModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="ModalLabel">문자메시지 발송 도움말</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body size-14">
                <p>1&#46; 발송하실 이름과 전화번호를 정확히 입력해주셔야 발송가능합니다&#46;</p>
                <p>예시)<br>이름 : 홍길동 &#40;문자메시지 발송내역에서 이름을 표시&#41;<br>전화번호 : 010-1234-5678<br>->010-0000-0000 다음과 같은 없는 번호로 발송할 경우 문자 메시지 발송에 실패하게 됩니다. &#40;통신사에서 필터링됨&#46;&#41;</p>
                <p>2&#46; 발송하실 때 편의를 위한 기능으로 '[이름]', '[이름이]'가 있습니다&#46;<br>[이름] → 전송 대상자의 이름 (이름)<br>예) [이름] → 길동<br>[이름이] → 전송 대상자의 이름 (이름 + (이))<br>예) [이름이]가 → 길동이가</p>
                <p>3&#46; 첨부파일을 발송하시려는 경우 확장자는 &#46;jpg만 사용가능하며&#44; 이미지의 가로길이와 세로길이는 1000px 이하 파일 크기는 100KB 이하로 제한됩니다.&#46;<br> &#40;더 큰 사이즈의 이미지도 전송은 되나, 실패하는 경우가 발생할 수 있음&#46;&#41;</p>
                <p>4&#46; &#46;</p>
            </div>
        </div>
    </div>
</div>