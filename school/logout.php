<?php
session_start();
unset($_SESSION);
session_destroy();

echo "<script> location.href = '/school/login.php'; </script>";