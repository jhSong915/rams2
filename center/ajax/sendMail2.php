<?php
include_once $_SERVER['DOCUMENT_ROOT'] . "/common/dbClass.php";
$db = new DBCmp();
include_once $_SERVER['DOCUMENT_ROOT'] . "/common/commonClass.php";
include_once $_SERVER['DOCUMENT_ROOT'] . "/common/function.php";
require_once $_SERVER['DOCUMENT_ROOT'] . "/common/Mail.php";

$user_id = !empty($_POST['user_id']) ? $_POST['user_id'] : '';
$user_name = !empty($_POST['user_name']) ? $_POST['user_name'] : '';
$user_email = !empty($_POST['user_email']) ? $_POST['user_email'] : '';
$status = false;
if (empty($user_id) || empty($user_name) || empty($user_name)) {
    throw new Exception('잘못된 접근입니다.', 602);
} else {
    $permissionCmp = new permissionCmp();
    // 임시 비밀번호 생성
    $password = makePassword();
    $enc_password = hash("sha256", $password);
    $sql = "UPDATE member_centerM SET password = '{$enc_password}' WHERE user_id = '{$user_id}' AND user_name = '{$user_name}' AND email = '{$user_email}'";
    $result = $db->execute($sql);
    if ($result) {
        // 메일 발송
        $mail = new Mail();
        $subject = '임시 비밀번호 발급 안내';
        $params = array();

        $params = array(
            "user_id" => $user_id,
            "password" => $password
        );
        $content = import_ob($_SERVER['DOCUMENT_ROOT'] . '/common/mailform.html', $params);

        $result2 = $mail->sendMail($subject, $content, $user_email, $user_name);

        if ($result2) {
            $status = true;
            $return_data['msg'] = '임시 비밀번호가 메일로 발송되었습니다.';
        } else {
            throw new Exception('잘못된 접근입니다.', 602);
        }
    } else {
        throw new Exception('임시 비밀번호 생성에 실패했습니다.', 602);
    }
}

$jsonResult = array(
    'success' => $status,
    'msg'     => $return_data['msg']
);

echo json_encode($jsonResult);
