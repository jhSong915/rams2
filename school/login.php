<?php
include_once $_SERVER['DOCUMENT_ROOT'] . "/_config/session_start.php";
if (!empty($_SESSION['logged_no'])) {
    unset($_SESSION);
    session_destroy();
}
?>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>리딩엠 RAMS - 독서이력진단 로그인</title>
    <link rel="icon" href="/img/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="/css/styles.css" />
    <?php include_once $_SERVER["DOCUMENT_ROOT"] . "/common/common_script2.php" ?>
    <script src="/school/js/login.js?v=<?= date('YmdHis') ?>"></script>
</head>

<body class="bg-dark">
    <div id="layoutAuthentication">
        <div id="layoutAuthentication_content">
            <main>
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-lg-5">
                            <div class="card shadow-lg border-0 rounded-lg mt-5">
                                <div class="card-header">
                                    <h3 class="text-center font-weight-light my-4"><span id="headTxt" class="align-middle ms-2">로그인</span></h3>
                                </div>
                                <div class="card-body">
                                    <form id="loginForm">
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="inputId" type="email" placeholder="아이디(이메일)" maxlength="50" />
                                            <label for="inputId">아이디</label>
                                        </div>
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="inputPassword" type="password" placeholder="비밀번호" maxlength="50" />
                                            <label for="inputPassword">비밀번호</label>
                                        </div>
                                        <div class="d-flex align-items-center justify-content-end mt-4 mb-0">
                                            <a class="btn btn-primary" href="javascript:void(0)" onclick="login_check()">로그인</a>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>

</html>