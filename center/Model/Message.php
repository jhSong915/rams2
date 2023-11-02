<?php
include $_SERVER['DOCUMENT_ROOT'] . "/center/Model/Model.php";

class MessageInfo extends Model
{
    var $table_name = "messageT";

    function __construct()
    {
        parent::__construct();
    }

    public function msgListLoad($franchise_idx, $user_idx, $months)
    {
        if (empty($user_idx)) {
            $where_qry = " AND send_user_idx = '{$user_idx}' ";
        }

        $sql = "SELECT msg_idx, msg_seq, from_no, to_no, to_name, 
        CASE WHEN msgType = 's' THEN '단문'
        WHEN msgType = 'l' THEN '장문'
        WHEN msgType = 'm' THEN '멀티' ELSE '' END AS msgType, 
        msg_state, 
        CASE WHEN msg_state = '0' THEN '성공' WHEN msg_state = '1' THEN '전송시간 초과' WHEN msg_state = '99' THEN '예약취소' WHEN msg_state = 'A' THEN '휴대전화 호 처리 중'
        WHEN msg_state = 'B' THEN '음영지역' WHEN msg_state = 'C' THEN '휴대전화 전원꺼짐' WHEN msg_state = 'D' THEN '메시지 저장개수 초과' 
        WHEN msg_state = '2' THEN '잘못된 전화번호' WHEN msg_state = 'a' THEN '서비스 일시 정지' WHEN msg_state = 'b' THEN '기타 휴대전화 문제'
        WHEN msg_state = 'c' THEN '착신거절' WHEN msg_state = 'd' THEN '기타' WHEN msg_state = 'e' THEN '통신사 SMC 형식 오류' 
        WHEN msg_state = 's' THEN '메시지 스팸차단' WHEN msg_state = 'n' THEN '수신번호 스팸차단' WHEN msg_state = 'r' THEN '회신번호 스팸차단'
        WHEN msg_state = 't' THEN '스팸차단 중 2개 이상 중복차단' WHEN msg_state = 'f' THEN '형식 오류' WHEN msg_state = 'g' THEN 'SMS/LMS/MMS 서비스 불가 휴대전화'
        WHEN msg_state = 'h' THEN '휴대전화 호 불가 상태' WHEN msg_state = 'i' THEN 'SMC 운영자가 메시지 삭제' WHEN msg_state = 'j' THEN '이통사 내부 메시지 Que Full'
        WHEN msg_state = 'k' THEN '통신사 스팸처리' WHEN msg_state = 'l' THEN 'nospam.go.kr 등록된 번호 스팸차단' WHEN msg_state = 'm' THEN '벤더사 스팸 차단'
        WHEN msg_state = 'n' THEN '발송건수 제한' WHEN msg_state = 'o' THEN '메시지 길이 초과' WHEN msg_state = 'p' THEN '휴대전화 번호 형식 오류' 
        WHEN msg_state = 'q' THEN '필드 형식 오류(내용 없음 등)' WHEN msg_state = 'x' THEN 'MMS 콘텐츠 정보 오류' WHEN msg_state = 'u' THEN '바코드 생성 실패'
        WHEN msg_state = 'y' THEN '1일 수신번호 당 발송횟수 초과' WHEN msg_state = 'w' THEN '키워드에 의한 스팸차단' WHEN msg_state = 'z' THEN '기타 오류' WHEN msg_state = '' THEN '대기'
        ELSE '' END AS msg_state_detail,
        rev_datetime,
        CONCAT(CONVERT(VARCHAR, reg_date, 120), '(', CONVERT(VARCHAR, send_date, 120), ')') AS reg_send_date
        FROM {$this->table_name} WHERE franchise_idx = '{$franchise_idx}' {$where_qry}  
        AND reg_date BETWEEN '" . $months . "-01 00:00:00.000' AND '" . ($months . '-' . date('t', strtotime($months))) . " 23:59:59.999'";
        $result = $this->db->sqlRowArr($sql);
        return $result;
    }

    public function msgContentLoad($msg_idx)
    {
        $sql = "SELECT msg_contents FROM {$this->table_name} WHERE msg_idx = '{$msg_idx}'";
        $result = $this->db->sqlRow($sql);

        return $result;
    }

    public function getMsgSeq($center_idx)
    {
        $sql = "SELECT TOP(100) msg_seq FROM {$this->table_name} WHERE franchise_idx = '{$center_idx}' AND syncYn = '' AND msg_state = '' ORDER BY msg_idx DESC";
        $result = $this->db->sqlRowArr($sql);

        return $result;
    }
}
