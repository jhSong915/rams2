<?php
$school_type = $_POST["school_type"];
$grade = $_POST["grade"];
if ($school_type == "1" && $grade <= 2) {
    $answer = array(
        "0" => "54321",
        "1" => "54321",
        "2" => "12345",
        "3" => "12345",
        "4" => "54321",
        "5" => "54321",
        "6" => "54321",
        "7" => "12345",
        "8" => "12345",
        "9" => "12345",
        "10" => "12345",
        "11" => "12345",
        "12" => "12345",
        "13" => "12345",
        "14" => "12345",
        "15" => "12345",
        "16" => "12345",
        "17" => "12345",
        "18" => "12345",
        "19" => "12345",
        "20" => "12345",
        "21" => "12345",
        "22" => "12345",
        "23" => "12345",
        "24" => "12345",
        "25" => "12345",
        "26" => "12345",
        "27" => "12345",
        "28" => "12345",
        "29" => "12345",
        "30" => "12345",
        "31" => "54321",
        "32" => "12345",
        "33" => "54321",
        "34" => "54321",
        "35" => "54321",
        "36" => "12345",
        "37" => "12345",
        "38" => "12345",
        "39" => "12345",
        "40" => "12345",
        "41" => "12345",
        "42" => "12345",
        "43" => "12345",
        "44" => "54321",
        "45" => "12345",
        "46" => "12345",
        "47" => "12345",
        "48" => "12345",
        "49" => "12345",
        "50" => "12345",
        "51" => "12345",
        "52" => "12345",
        "53" => "12345",
        "54" => "12345",
        "55" => "12345",
        "56" => "12345",
        "57" => "12345",
        "58" => "54321",
        "59" => "54321",
        "60" => "54321",
        "61" => "54321",
        "62" => "54321",
        "63" => "12345",
        "64" => "12345",
        "65" => "12345",
        "66" => "12345",
        "67" => "12345",
        "68" => "12345",
        "69" => "12345",
        "70" => "12345",
        "71" => "12345",
        "72" => "12345",
        "73" => "12345",
        "74" => "12345",
        "75" => "12345",
        "76" => "12345",
        "77" => "12345",
        "78" => "12345",
        "79" => "12345",
        "80" => "12345",
        "81" => "12345",
        "82" => "12345",
        "83" => "12345",
        "84" => "12345",
        "85" => "12345",
        "86" => "12345"
    );
    for ($i = 0; $i <= 86; $i++) {
        $data['answer'][] .= $answer[$i];
    }
} else {
    $answer = array(
        "0" => "54321",
        "1" => "54321",
        "2" => "12345",
        "3" => "12345",
        "4" => "54321",
        "5" => "54321",
        "6" => "54321",
        "7" => "12345",
        "8" => "12345",
        "9" => "12345",
        "10" => "12345",
        "11" => "12345",
        "12" => "12345",
        "13" => "12345",
        "14" => "12345",
        "15" => "12345",
        "16" => "12345",
        "17" => "12345",
        "18" => "12345",
        "19" => "12345",
        "20" => "12345",
        "21" => "12345",
        "22" => "12345",
        "23" => "12345",
        "24" => "12345",
        "25" => "12345",
        "26" => "12345",
        "27" => "12345",
        "28" => "12345",
        "29" => "12345",
        "30" => "12345",
        "31" => "54321",
        "32" => "12345",
        "33" => "54321",
        "34" => "54321",
        "35" => "54321",
        "36" => "12345",
        "37" => "12345",
        "38" => "12345",
        "39" => "12345",
        "40" => "12345",
        "41" => "12345",
        "42" => "12345",
        "43" => "12345",
        "44" => "54321",
        "45" => "12345",
        "46" => "12345",
        "47" => "12345",
        "48" => "12345",
        "49" => "12345",
        "50" => "12345",
        "51" => "12345",
        "52" => "12345",
        "53" => "12345",
        "54" => "12345",
        "55" => "12345",
        "56" => "12345",
        "57" => "12345",
        "58" => "54321",
        "59" => "54321",
        "60" => "54321",
        "61" => "54321",
        "62" => "54321",
        "63" => "12345",
        "64" => "12345",
        "65" => "12345",
        "66" => "12345",
        "67" => "12345",
        "68" => "12345",
        "69" => "12345",
        "70" => "12345",
        "71" => "12345",
        "72" => "12345",
        "73" => "12345",
        "74" => "12345",
        "75" => "12345",
        "76" => "12345",
        "77" => "12345",
        "78" => "12345",
        "79" => "12345",
        "80" => "12345",
        "81" => "12345",
        "82" => "12345",
        "83" => "12345",
        "84" => "12345",
        "85" => "12345",
        "86" => "12345",
        "87" => "12345",
        "88" => "12345",
        "89" => "12345",
        "90" => "12345",
        "91" => "12345",
        "92" => "12345",
        "93" => "12345",
        "94" => "12345",
        "95" => "12345",
        "96" => "12345",
        "97" => "12345",
        "98" => "12345",
        "99" => "12345",
        "100"   => "12345",
    );
    for ($i = 0; $i <= 100; $i++) {
        $data['answer'][] .= $answer[$i];
    }
}

echo json_encode($data);