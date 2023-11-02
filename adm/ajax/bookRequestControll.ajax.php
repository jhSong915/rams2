<?php 
// error_reporting( E_ALL );
// ini_set( "display_errors", 1 );
if(empty($_POST)){
    header('HTTP/2 403 Forbidden');
    exit;
}
require_once $_SERVER['DOCUMENT_ROOT']."/common/dbClass.php";
$db = new DBCmp();

include_once $_SERVER['DOCUMENT_ROOT']."/adm/Controller/BookRequestController.php";
$result = $bookRequestController->{$_POST['action']}($_POST);

$jsonResult = array (
    'success' => $result['error'] ? false : true,
    'data'    => !$result['error'] ? $result  : null,
    'msg'     => $result['msg']
);

echo json_encode($jsonResult);