<?php
if (empty($_REQUEST['code'])) {
    header("Location : /index.php");
}
require_once $_SERVER['DOCUMENT_ROOT'] . "/common/dbClass.php";
$db = new DBCmp();
$code = $_REQUEST['code'];
$sql = "SELECT auth_idx, auth_code FROM franchise_authT WHERE auth_code = '{$code}' AND auth_expire <> 'Y'";
$result = $db->sqlRow($sql);
include_once $_SERVER["DOCUMENT_ROOT"] . "/common/common_script2.php";
if (!empty($_REQUEST['code']) != $result['auth_code']) {
?>
    <script type="text/javascript">
        $(document).ready(function() {
            alert("잘못된 가입코드입니다.");
            document.location.href = "/index.php";
        });
    </script>
<?php
} else {
    $sql = "UPDATE franchise_authT SET auth_expire = 'Y' WHERE auth_idx = '{$result['auth_idx']}'";
    $result2 = $db->execute($sql);
?>
    <form id="fd" method="post" action="/franchisee/register.html">
        <input type="hidden" name="code" value="<?= $_GET['code'] ?>">
    </form>
    <script type="text/javascript">
        $(document).ready(function() {
            setTimeout(() => {
                $('#fd').submit();
            }, 500);
        });
    </script>
<?php
}
?>