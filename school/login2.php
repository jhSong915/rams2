<?php
if (empty($_POST)) {
    header('HTTP/2 403 Forbidden');
    exit;
}
include_once $_SERVER['DOCUMENT_ROOT'] . "/_config/session_start.php";
include_once $_SERVER['DOCUMENT_ROOT'] . "/common/dbClass.php";

$db = new DBCmp();

$status = 'fail';
$returnMsg = '아이디 또는 비밀번호가 일치하지 않습니다.';

$user_id  = !empty($_POST['user_id']) ? $_POST['user_id'] : '';
$password = !empty($_POST['password']) ? $_POST['password'] : '';

if (empty($user_id) || empty($password)) {
    $result_arr = array(
        "status" => $status,
        "msg"    => $returnMsg
    );
    $result = json_encode($result_arr);
    echo $result;
    exit;
}

$sql = "SELECT TOP(1) M.school_idx, M.school_name, M.manager_email, M.manager_tel, M.manager_hp, M.manager_password, M.manager_name
, M.start_date, M.expire_date, M.order_state, C.code_name, M.order_money, M.contract_no, M.access_token FROM school_infoM M
LEFT OUTER JOIN codeM C ON C.code_num1 = '46' AND M.order_state = C.code_num2
WHERE manager_email = '{$user_id}'";
$result = $db->sqlRow($sql);
//등록된 아이디일때
if (!empty($result)) {
    if (password_verify($password, $result['manager_password'])) {
        $status = 'success';
        $_SESSION['school_idx'] = $result["school_idx"];
        $_SESSION['school_name'] = $result["school_name"];
        $_SESSION['manager_name'] = $result["manager_name"];
        $_SESSION['manager_email'] = $result["manager_email"];
        $_SESSION['manager_tel'] = $result["manager_tel"];
        $_SESSION['manager_hp'] = $result["manager_hp"];
        $_SESSION['start_date'] = $result["start_date"];
        $_SESSION['expire_date'] = $result["expire_date"];
        $_SESSION['order_state'] = $result["order_state"];
        $_SESSION['order_state_txt'] = $result["code_name"];
        $_SESSION['order_money'] = $result["order_money"];
        $_SESSION['contract_no'] = $result["contract_no"];
        $_SESSION['access_token'] = $result["access_token"];

        session_write_close();
    } else {
        $returnMsg = "아이디 혹은 비밀번호를 확인해주세요.";
    }
} else {
    $returnMsg = "아이디 혹은 비밀번호를 확인해주세요.";
}

$result_arr = array(
    "status" => $status,
    "msg"    => $returnMsg
);

$result = json_encode($result_arr);
echo $result;
