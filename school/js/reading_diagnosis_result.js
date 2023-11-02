$(document).ready(function () {
    getDiagnosisResult();
});

function getDiagnosisResult() {
    var school_idx = $("#hd_school_idx").val();
    var std_grade = $("#hd_std_grade").val();
    var std_class = $("#hd_std_class").val();
    var std_no = $("#hd_std_no").val();

    $.ajax({
        url: '/school/ajax/readingDiagnosis.ajax.php',
        dataType: 'JSON',
        type: 'POST',
        data: {
            action: "getDiagnosisResult1",
            school_idx: school_idx,
            std_grade: std_grade,
            std_class: std_class,
            std_no: std_no
        },
        success: function (result) {
            if (result.success && result.data) {
                $("#table1_1 > td:eq(1)").text(result.data[0]["score_a_1_c"]);
                $("#table1_1 > td:eq(2)").text(result.data[0]["score_a_1"]);
                $("#table1_1 > td:eq(3)").text(result.data[1]["score_a_1"]);
                $("#table1_1 > td:eq(4)").text(result.data[2]["score_a_1"]);
                $("#table1_1 > td:eq(5)").text(result.data[3]["score_a_1"]);
                $("#table1_2 > td:eq(1)").text(result.data[0]["score_a_2_c"]);
                $("#table1_2 > td:eq(2)").text(result.data[0]["score_a_2"]);
                $("#table1_2 > td:eq(3)").text(result.data[1]["score_a_2"]);
                $("#table1_2 > td:eq(4)").text(result.data[2]["score_a_2"]);
                $("#table1_2 > td:eq(5)").text(result.data[3]["score_a_2"]);
                $("#table1_3 > td:eq(1)").text(result.data[0]["score_a_c"]);
                $("#table1_3 > td:eq(2)").text(result.data[0]["score_a"]);
                $("#table1_3 > td:eq(3)").text(result.data[1]["score_a"]);
                $("#table1_3 > td:eq(4)").text(result.data[2]["score_a"]);
                $("#table1_3 > td:eq(5)").text(result.data[3]["score_a"]);
                var data1 = new Array(
                    [result.data[0]["score_a_1"], result.data[0]["score_a_2"], result.data[0]["score_a"]],
                    [result.data[1]["score_a_1"], result.data[1]["score_a_2"], result.data[1]["score_a"]],
                    [result.data[2]["score_a_1"], result.data[2]["score_a_2"], result.data[2]["score_a"]],
                    [result.data[3]["score_a_1"], result.data[3]["score_a_2"], result.data[3]["score_a"]],
                );
                result3Load(student_name, data1);
                $("#table3_1 > td:eq(0)").text(result.data[0]["score_a_1_c"]);
                $("#table3_2 > td:eq(0)").text(result.data[0]["score_a_2_c"]);
                $("#table3_3 > td:eq(0)").text(result.data[0]["score_a_c"]);
                $("#table1_4 > td:eq(1)").text(result.data[0]["score_b_1_c"]);
                $("#table1_4 > td:eq(2)").text(result.data[0]["score_b_1"]);
                $("#table1_4 > td:eq(3)").text(result.data[1]["score_b_1"]);
                $("#table1_4 > td:eq(4)").text(result.data[2]["score_b_1"]);
                $("#table1_4 > td:eq(5)").text(result.data[3]["score_b_1"]);
                $("#table1_5 > td:eq(1)").text(result.data[0]["score_b_2_c"]);
                $("#table1_5 > td:eq(2)").text(result.data[0]["score_b_2"]);
                $("#table1_5 > td:eq(3)").text(result.data[1]["score_b_2"]);
                $("#table1_5 > td:eq(4)").text(result.data[2]["score_b_2"]);
                $("#table1_5 > td:eq(5)").text(result.data[3]["score_b_2"]);
                $("#table1_6 > td:eq(1)").text(result.data[0]["score_b_3_c"]);
                $("#table1_6 > td:eq(2)").text(result.data[0]["score_b_3"]);
                $("#table1_6 > td:eq(3)").text(result.data[1]["score_b_3"]);
                $("#table1_6 > td:eq(4)").text(result.data[2]["score_b_3"]);
                $("#table1_6 > td:eq(5)").text(result.data[3]["score_b_3"]);
                $("#table1_7 > td:eq(1)").text(result.data[0]["score_b_c"]);
                $("#table1_7 > td:eq(2)").text(result.data[0]["score_b"]);
                $("#table1_7 > td:eq(3)").text(result.data[1]["score_b"]);
                $("#table1_7 > td:eq(4)").text(result.data[2]["score_b"]);
                $("#table1_7 > td:eq(5)").text(result.data[3]["score_b"]);
                $("#table1_8 > td:eq(1)").text(result.data[0]["score_c_c"]);
                $("#table1_8 > td:eq(2)").text(result.data[0]["score_c"]);
                $("#table1_8 > td:eq(3)").text(result.data[1]["score_c"]);
                $("#table1_8 > td:eq(4)").text(result.data[2]["score_c"]);
                $("#table1_8 > td:eq(5)").text(result.data[3]["score_c"]);
                $("#table1_9 > td:eq(1)").text(result.data[0]["score_d_c"]);
                $("#table1_9 > td:eq(2)").text(result.data[0]["score_d"]);
                $("#table1_9 > td:eq(3)").text(result.data[1]["score_d"]);
                $("#table1_9 > td:eq(4)").text(result.data[2]["score_d"]);
                $("#table1_9 > td:eq(5)").text(result.data[3]["score_d"]);
                var data2 = new Array(
                    [result.data[0]["score_literary_avg"], result.data[0]["score_nliterary_avg"], result.data[0]["score_lnliterary_sum_avg"]],
                    [result.data[1]["score_literary_avg"], result.data[1]["score_nliterary_avg"], result.data[1]["score_lnliterary_sum_avg"]],
                    [result.data[2]["score_literary_avg"], result.data[2]["score_nliterary_avg"], result.data[2]["score_lnliterary_sum_avg"]],
                    [result.data[3]["score_literary_avg"], result.data[3]["score_nliterary_avg"], result.data[3]["score_lnliterary_sum_avg"]]
                );
                result2_1Load(student_name, data2);
                result2_2Load(student_name, result.data[0]["rq_rate"], result.data[1]["rq_rate"], result.data[2]["rq_rate"], result.data[3]["rq_rate"]);
                $("#table5_1 > td:eq(0)").text(result.data[0]["score_b_1_c"]);
                $("#table5_2 > td:eq(0)").text(result.data[0]["score_b_2_c"]);
                $("#table5_3 > td:eq(0)").text(result.data[0]["score_b_3_c"]);
                var data4 = new Array(
                    [result.data[0]["score_b_1"], result.data[1]["score_b_1"], result.data[2]["score_b_1"], result.data[3]["score_b_1"]],
                    [result.data[0]["score_b_2"], result.data[1]["score_b_2"], result.data[2]["score_b_2"], result.data[3]["score_b_2"]],
                    [result.data[0]["score_b_3"], result.data[1]["score_b_3"], result.data[2]["score_b_3"], result.data[3]["score_b_3"]],
                    [result.data[0]["score_b"], result.data[1]["score_b"], result.data[2]["score_b"], result.data[3]["score_b"]],
                );
                result4Load(student_name, data4);

                $("#table7_1 > td:eq(0)").text(result.data[0]["score_c_c"]);
                var data5 = [result.data[0]["score_c"], result.data[1]["score_c"], result.data[2]["score_c"], result.data[3]["score_c"]];
                result5Load(student_name, data5);

                $("#table9_1 > td:eq(0)").text(result.data[0]["score_d_c"]);
                var data6_1 = [result.data[0]["score_d"], result.data[1]["score_d"], result.data[2]["score_d"], result.data[3]["score_d"]];
                var data6_2 = new Array(
                    result.data["literary_list"],
                    result.data["pliterary_cnt_arr"],
                    result.data["literary_cnt_arr"],
                );
                var data6_3 = new Array(
                    result.data["nliterary_list"],
                    result.data["pnliterary_cnt_arr"],
                    result.data["nliterary_cnt_arr"],
                );

                result6Load(student_name, data6_1, data6_2, data6_3)
                return false;
            }
        },
        error: function (request, status, error) {
            console.log("request : " + request + "\n" + "status : " + status + "\n" + "error : " + error);
        }
    });
}

function result2_1Load(std_name, data) {
    $("#table2_1 > td:eq(0)").text(data[0][0]);
    $("#table2_1 > td:eq(1)").text(data[1][0]);
    $("#table2_1 > td:eq(2)").text(data[2][0]);
    $("#table2_1 > td:eq(3)").text(data[3][0]);
    $("#table2_2 > td:eq(0)").text(data[0][1]);
    $("#table2_2 > td:eq(1)").text(data[1][1]);
    $("#table2_2 > td:eq(2)").text(data[2][1]);
    $("#table2_2 > td:eq(3)").text(data[3][1]);
    $("#table2_3 > td:eq(0)").text(data[0][2]);
    $("#table2_3 > td:eq(1)").text(data[1][2]);
    $("#table2_3 > td:eq(2)").text(data[2][2]);
    $("#table2_3 > td:eq(3)").text(data[3][2]);
    const ctx1 = document.getElementById("result2_1");

    const chart1 = new Chart(ctx1, {
        type: 'bar',
        data: {
            labels: ['문학', '비문학', '합계'],
            datasets: [{
                label: std_name + '님 점수',
                data: data[0],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.7)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)'
                ],
                borderWidth: 1
            }, {
                label: '전체평균',
                data: data[1],
                backgroundColor: [
                    'rgba(54, 162, 235, 0.7)'
                ],
                borderColor: [
                    'rgba(54, 162, 235, 1)'
                ],
                borderWidth: 1
            }, {
                label: '남학생평균',
                data: data[2],
                backgroundColor: [
                    'rgba(75, 192, 192, 0.7)'
                ],
                borderColor: [
                    'rgba(75, 192, 192, 1)'
                ],
                borderWidth: 1
            }, {
                label: '여학생평균',
                data: data[3],
                backgroundColor: [
                    'rgba(153, 102, 255, 0.7)'
                ],
                borderColor: [
                    'rgba(153, 102, 255, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true,
                    max: 100
                }
            }
        }
    });
}

function result2_2Load(std_name, data2_1, data2_2, data2_3, data2_4) {
    $("#table2_4 > td:eq(0)").text(data2_1);
    $("#table2_4 > td:eq(1)").text(data2_2);
    $("#table2_4 > td:eq(2)").text(data2_3);
    $("#table2_4 > td:eq(3)").text(data2_4);
    const ctx2 = document.getElementById("result2_2");
    const chart2 = new Chart(ctx2, {
        type: 'bar',
        data: {
            labels: [std_name + '님 점수', '전체평균', '남학생평균', '여학생평균'],
            datasets: [{
                data: [data2_1, data2_2, data2_3, data2_4],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.7)',
                    'rgba(54, 162, 235, 0.7)',
                    'rgba(75, 192, 192, 0.7)',
                    'rgba(153, 102, 255, 0.7)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            plugins: {
                legend: {
                    display: false
                },
                title: {
                    display: true,
                    text: '독서이력지수'
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    max: 100
                }
            }
        }
    });
}

function result3Load(std_name, data) {
    $("#table3_1 > td:eq(1)").text(data[0][0]);
    $("#table3_1 > td:eq(2)").text(data[1][0]);
    $("#table3_1 > td:eq(3)").text(data[2][0]);
    $("#table3_1 > td:eq(4)").text(data[3][0]);
    $("#table3_2 > td:eq(1)").text(data[0][1]);
    $("#table3_2 > td:eq(2)").text(data[1][1]);
    $("#table3_2 > td:eq(3)").text(data[2][1]);
    $("#table3_2 > td:eq(4)").text(data[3][1]);
    $("#table3_3 > td:eq(1)").text(data[0][2]);
    $("#table3_3 > td:eq(2)").text(data[1][2]);
    $("#table3_3 > td:eq(3)").text(data[2][2]);
    $("#table3_3 > td:eq(4)").text(data[3][2]);
    getResult3_Comment(data[0][0], data[0][1]);
    const ctx3 = document.getElementById("result3");
    const chart3 = new Chart(ctx3, {
        type: 'bar',
        data: {
            labels: ['도서선택능력', '독서관리능력', '합계'],
            datasets: [{
                label: std_name + '님 점수',
                data: data[0],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.7)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)'
                ],
                borderWidth: 1
            }, {
                label: '전체평균',
                data: data[1],
                backgroundColor: [
                    'rgba(54, 162, 235, 0.7)'
                ],
                borderColor: [
                    'rgba(54, 162, 235, 1)'
                ],
                borderWidth: 1
            }, {
                label: '남학생평균',
                data: data[2],
                backgroundColor: [
                    'rgba(75, 192, 192, 0.7)'
                ],
                borderColor: [
                    'rgba(75, 192, 192, 1)'
                ],
                borderWidth: 1
            }, {
                label: '여학생평균',
                data: data[3],
                backgroundColor: [
                    'rgba(153, 102, 255, 0.7)'
                ],
                borderColor: [
                    'rgba(153, 102, 255, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true,
                    max: 100
                }
            }
        }
    });
}

function result4Load(std_name, data) {
    getResult4_Comment(data[0][0], data[1][0], data[2][0]);
    $("#table5_1 > td:eq(1)").text(data[0][0]);
    $("#table5_1 > td:eq(2)").text(data[0][1]);
    $("#table5_1 > td:eq(3)").text(data[0][2]);
    $("#table5_1 > td:eq(4)").text(data[0][3]);
    $("#table5_2 > td:eq(1)").text(data[1][0]);
    $("#table5_2 > td:eq(2)").text(data[1][1]);
    $("#table5_2 > td:eq(3)").text(data[1][2]);
    $("#table5_2 > td:eq(4)").text(data[1][3]);
    $("#table5_3 > td:eq(1)").text(data[2][0]);
    $("#table5_3 > td:eq(2)").text(data[2][1]);
    $("#table5_3 > td:eq(3)").text(data[2][2]);
    $("#table5_3 > td:eq(4)").text(data[2][3]);
    const ctx1 = document.getElementById("result4_2");
    const chart1 = new Chart(ctx1, {
        type: 'bar',
        data: {
            labels: ['독서 전', '독서 중', '독서 후', '평균'],
            datasets: [{
                label: std_name + '님 점수',
                data: data[0],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.7)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)'
                ],
                borderWidth: 1
            }, {
                label: '전체평균',
                data: data[1],
                backgroundColor: [
                    'rgba(54, 162, 235, 0.7)'
                ],
                borderColor: [
                    'rgba(54, 162, 235, 1)'
                ],
                borderWidth: 1
            }, {
                label: '남학생평균',
                data: data[2],
                backgroundColor: [
                    'rgba(75, 192, 192, 0.7)'
                ],
                borderColor: [
                    'rgba(75, 192, 192, 1)'
                ],
                borderWidth: 1
            }, {
                label: '여학생평균',
                data: data[3],
                backgroundColor: [
                    'rgba(153, 102, 255, 0.7)'
                ],
                borderColor: [
                    'rgba(153, 102, 255, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true,
                    max: 100
                }
            }
        }
    });
}

function result5Load(std_name, data) {
    $("#table7_1 > td:eq(1)").text(data[0]);
    $("#table7_1 > td:eq(2)").text(data[1]);
    $("#table7_1 > td:eq(3)").text(data[2]);
    $("#table7_1 > td:eq(4)").text(data[3]);
    getResult5_Comment(data[0]);
    const ctx1 = document.getElementById("result5_2");
    const chart1 = new Chart(ctx1, {
        type: 'bar',
        data: {
            labels: [std_name + '님 점수', '전체평균', '남학생평균', '여학생평균'],
            datasets: [{
                data: data,
                backgroundColor: [
                    'rgba(255, 99, 132, 0.7)',
                    'rgba(54, 162, 235, 0.7)',
                    'rgba(75, 192, 192, 0.7)',
                    'rgba(153, 102, 255, 0.7)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            plugins: {
                legend: {
                    display: false
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    max: 100
                }
            }
        }
    });
}

function result6Load(std_name, data1, data2, data3) {
    $("#table9_1 > td:eq(1)").text(data1[0]);
    $("#table9_1 > td:eq(2)").text(data1[1]);
    $("#table9_1 > td:eq(3)").text(data1[2]);
    $("#table9_1 > td:eq(4)").text(data1[3]);
    getResult6_Comment(data1[0]);
    const ctx1 = document.getElementById("result6_2");
    const ctx2 = document.getElementById("result6_3");
    const ctx3 = document.getElementById("result6_4");
    const chart1 = new Chart(ctx1, {
        type: 'bar',
        data: {
            labels: [std_name + '님 점수', '전체평균', '남학생평균', '여학생평균'],
            datasets: [{
                data: data1,
                backgroundColor: [
                    'rgba(255, 99, 132, 0.7)',
                    'rgba(54, 162, 235, 0.7)',
                    'rgba(75, 192, 192, 0.7)',
                    'rgba(153, 102, 255, 0.7)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            plugins: {
                legend: {
                    display: false
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    max: 100
                }
            }
        }
    });
    const chart2 = new Chart(ctx2, {
        type: 'polarArea',
        options: {
            plugins: {
                legend: {
                    display: true
                },
                title: {
                    display: true,
                    text: '문학'
                },
                scale: {
                    beginAtZero: true,
                    max: 5,
                    min: 0,
                    stepSize: 1,
                },
            }
        },
        data: {
            labels: data2[0],
            datasets: [{
                label: "과거 독서 이력 (문학)",
                data: data2[1],
                borderWidth: 1
            }, {
                label: "현재 독서 이력 (문학)",
                data: data2[2],
                borderWidth: 1
            }]
        },
    });

    const chart3 = new Chart(ctx3, {
        type: 'polarArea',
        options: {
            plugins: {
                legend: {
                    display: true
                },
                title: {
                    display: true,
                    text: '비문학'
                },
                scale: {
                    beginAtZero: true,
                    max: 5,
                    min: 0,
                    stepSize: 1,
                },
            }
        },
        data: {
            labels: data3[0],
            datasets: [{
                label: "과거 독서 이력 (비문학)",
                data: data3[1],
                borderWidth: 1
            }, {
                label: "현재 독서 이력 (비문학)",
                data: data3[2],
                borderWidth: 1
            }]
        },
    });
}

function getResult3_Comment(a1, a2) {
    var comment1_1 = "";
    var comment1_2 = "";
    var comment2_1 = "";
    var comment2_2 = "";
    var comment3_1 = "";
    var comment3_2 = "";
    if (a1 >= 70.0) {
        comment1_1 = "자기 스스로 책을 골라 읽을 수 있는 능력이 어느 정도 갖춰져 있습니다. 꼭 읽어야 할 책 뿐만 아니라 다양한 장르와 주제의 책에 대해 읽어야 한다는 인식도 어느 정도 갖고 있습니다.";
        comment2_1 = "";
        comment3_1 = "자기 주도적인 독서능력이 어느 정도 갖추어져 있기 때문에 이제는 다양한 장르와 주제의 책을 읽으면서 배경지식을 쌓아 나가도록 지도해주시기 바랍니다. 그렇게 되면, 학교수업에 있어 보다 더 능동적인 상호작용이 이뤄질 것입니다. 즉흥적인 책의 선택이 아니라 학년이 바뀌면 1년동안 읽을 책의 목록을 정한 다음, 주단위로 책을 읽어나가면 좋겠습니다. 아울러 더 넓고 깊게 읽을 책을 접할 수 있는 환경을 제공해주시기 바랍니다.";
    } else if (a1 < 70.0 && a1 >= 50.0) {
        comment1_1 = "학생은 자기 스스로 책을 골라 읽을 수 있는 능력이 보통 수준입니다. 꼭 읽어야 할 책 뿐만 아니라 다양한 장르와 주제의 책에 대해 읽어야 한다는 인식수준도 보통입니다.";
        comment2_1 = "";
        comment3_1 = "자기 주도적인 독서능력이 조금 더 필요하기 때문에 즉흥적인 책의 선택이 아니라 학년이 바뀌면 1년동안 읽을 책의 목록을 정한 다음, 주 단위로 책을 읽어나가면 좋겠습니다. 아울러 더 넓고 깊게 읽을 책을 접할 수 있는 환경을 제공해주시기 바랍니다. 또한 다양한 장르와 주제의 책을 읽으면서 배경지식을 쌓아 나가도록 하시기 바랍니다. 그렇게 되면, 학교수업에 있어 보다 더 능동적인 상호작용이 이뤄질 것입니다.";
    } else {
        comment1_1 = "자기 스스로 책을 골라 읽을 수 있는 능력이 부족한 편입니다. 꼭 읽어야 할 책 뿐만 아니라 다양한 장르와 주제의 책에 대해 읽어야 한다는 인식수준도 부족한 편입니다.";
        comment2_1 = "";
        comment3_1 = "학생의 경우는 자기 주도적인 독서능력이 조금 더 필요하기 때문에 즉흥적인 책의 선택이 아니라 학년이 바뀌면 1년동안 읽을 책의 목록을 정한 다음, 주단위로 책을 읽어나가면 좋겠습니다. 아울러 더 넓고 깊게 읽을 책을 접할 수 있는 환경을 제공해주시기 바랍니다. 또한 다양한 장르와 주제의 책을 읽으면서 배경지식을 쌓아 나가도록 하시기 바랍니다. 그렇게 되면, 학교수업에 있어 보다 더 능동적인 상호작용이 이뤄질 것입니다.";
    }

    if (a2 >= 70.0) {
        comment1_2 = "독서이력에 대한 관리 능력을 잘 가지고 있는 편입니다. 또한 독서에 대한 목표 의식이 양호한 편입니다.";
        comment2_2 = "";
        comment3_2 = "독서이력에 대한 관리 능력을 어느 정도 가지고 있기 때문에 자신의 독서이력을 파악한 다음, 전략적인 책 읽기가 필요합니다. 앞으로 1년을 단위로 하여 읽어야 할 책의 목록을 그동안의 독서이력을 바탕으로 부족한 점을 메꿀 수 있는 방향에서 계획하여 좀 더 체계적인 독서를 한다면 최고의 학습능력을 발휘할 것으로 예상됩니다. 독서이력이 자신의 적성과 진로에도 영향을 미치기 때문에 좀 더 적극적인 이력관리를 할 필요도 있습니다.";
    } else if (a2 < 70.0 && a2 >= 50.0) {
        comment1_2 = "독서이력에 대한 관리 능력이 보통 수준입니다. 또한 독서에 대한 목표 의식도 중간수준이라고 할 수 있습니다.";
        comment2_2 = "";
        comment3_2 = "독서이력에 대한 관리 능력이 충분하지 않기 때문에 자신의 독서이력을 파악한 다음, 전략적인 책 읽기가 필요합니다. 앞으로 1년을 단위로 하여 읽어야 할 책의 목록을 그동안의 독서이력을 바탕으로 부족한 점을 메꿀 수 있는 방향에서 계획하여 좀 더 체계적인 독서를 한다면 최고의 학습능력을 발휘할 것으로 예상됩니다. 독서이력이 자신의 적성과 진로에도 영향을 미치기 때문에 좀 더 적극적인 이력관리를 할 필요도 있습니다. 무조건적인 책 읽기 보다 자신의 독서이력이 자신의 적성과 진로에도 커다란 영향을 미친다는 사실을 직시하고 보다 더 적극적인 독서이력관리가 요구됩니다.";
    } else {
        comment1_2 = "독서이력에 대한 관리 능력이 다소 부족한 편입니다. 또한 독서에 대한 목표 의식이 제대로 갖춰지지 않은 편입니다.";
        comment2_2 = "";
        comment3_2 = "독서이력에 대한 관리 능력과 인식이 다소 부족하기 때문에 자신의 독서이력을 파악한 다음, 전략적인 책 읽기가 필요합니다. 앞으로 1년을 단위로 하여 읽어야 할 책의 목록을 그동안의 독서이력을 바탕으로 부족한 점을 메꿀 수 있는 방향에서 계획하여 좀 더 체계적인 독서를 한다면 최고의 학습능력을 발휘할 것으로 예상됩니다. 독서이력이 자신의 적성과 진로에도 영향을 미치기 때문에 좀 더 적극적인 이력관리를 할 필요도 있습니다. 무조건적인 책 읽기 보다 자신의 독서이력이 자신의 적성과 진로에도 커다란 영향을 미친다는 사실을 직시하고 보다 더 적극적인 독서이력관리가 요구됩니다.";
    }
    $("#table4_1 > td:eq(0)").html(comment1_1);
    $("#table4_1 > td:eq(1)").html(comment1_2);
    $("#table4_2 > td:eq(0)").html(comment2_1);
    $("#table4_2 > td:eq(1)").html(comment2_2);
    $("#table4_3 > td:eq(0)").html(comment3_1);
    $("#table4_3 > td:eq(1)").html(comment3_2);
}

function getResult4_Comment(b1, b2, b3) {
    var comment1_1 = "";
    var comment1_2 = "";
    var comment1_3 = "";
    var comment2_1 = "";
    var comment2_2 = "";
    var comment2_3 = "";
    var comment3_1 = "";
    var comment3_2 = "";
    var comment3_3 = "";
    if (b1 >= 70.0) {
        comment1_1 = "독서 전 활동의 경우 흥미도, 배경지식 활성화 능력, 관찰력이 우수한 편입니다.";
        comment1_2 = "독서 전 활동은 자신의 배경지식을 활성화시키고, 책에 대한 흥미와 독서동기를 유발시키기 때문에 그 중요성이 있습니다. 책을 맨 처음 접했을 때 자신이 책과 어떤 소통을 하는가는 독서에 대한 흥미와 책을 받아들이는 인식 수준을 알 수 있습니다.";
        comment1_3 = "독서 전 활동이 활발하게 이뤄지고 있기 때문에 커다란 문제점은 없습니다. 다만, 책을 읽기 전에 제목이나 그림, 책의 서평, 지은이나 출판사 등을 살펴보면서 책의 내용이 무엇일까를 떠올려보는 자세가 습관이 되어야 합니다. 이와 같은 독서 전 습관을 갖게 되면 상상력을 키울 수 있고 배경지식을 활성화시킬 수 있는 장점이 있습니다. 글의 종류가 무엇인지 생각해보고 어떻게 읽을 것인지를 생각해보도록 합니다. 또한 내 경험을 떠올려보고 배경지식을 활성화시켜 보도록 합니다.특히 읽을 글감의 머리글이나 제목, 소제목, 그림을 보고 뒤의 내용도 예측해 보는 습관을 키워보는 것도 필요합니다.";
    } else if (b1 < 70.0 && b1 >= 50.0) {
        comment1_1 = "독서 전 활동의 경우 흥미도, 배경지식 활성화 능력, 관찰력이 보통 수준입니다.";
        comment1_2 = "독서 전 활동은 자신의 배경지식을 활성화시키고, 책에 대한 흥미와 독서동기를 유발시키기 때문에 그 중요성이 있습니다. 책을 맨 처음 접했을 때 자신이 책과 어떤 소통을 하는가는 독서에 대한 흥미와 책을 받아들이는 인식 수준을 알 수 있습니다.";
        comment1_3 = "독서 전 활동이 좀 더 활발하게 이뤄질 수 있도록 하는 것이 필요합니다. 따라서 책을 읽기 전에 제목이나 그림, 책의 서평, 지은이나 출판사 등을 살펴보면서 책의 내용이 무엇일까를 떠올려보는 자세가 습관이 되어야 합니다. 이와 같은 독서 전 습관을 갖게 되면 상상력을 키울 수 있고 배경지식을 활성화시킬 수 있는 장점이 있습니다. 글의 종류가 무엇인지 생각해보고 어떻게 읽을 것인지를 생각해보도록 합니다. 또한 내 경험을 떠올려보고 배경지식을 활성화시켜 보도록 합니다.특히 읽을 글감의 머리글이나 제목, 소제목, 그림을 보고 뒤의 내용도 에측해 보는 습관을 키워보는 것도 필요합니다.";
    } else {
        comment1_1 = "독서 전 활동의 경우 흥미도, 배경지식 활성화 능력, 관찰력이 다소 부족한 편입니다.";
        comment1_2 = "독서 전 활동은 자신의 배경지식을 활성화시키고, 책에 대한 흥미와 독서동기를 유발시키기기 때문에 그 중요성이 있습니다. 책을 맨 처음 접했을 때 자신이 책과 어떤 소통을 하는가는 독서에 대한 흥미와 책을 받아들이는 인식 수준을 알 수 있습니다.";
        comment1_3 = "독서 전 활동이 좀 더 활발하게 이뤄질 수 있도록 하는 것이 필요합니다. 따라서 책을 읽기 전에 제목이나 그림, 책의 서평, 지은이나 출판사 등을 살펴보면서 책의 내용이 무엇일까를 떠올려보는 자세가 습관이 되어야 합니다. 이와 같은 독서 전 습관을 갖게 되면 상상력을 키울 수 있고 배경지식을 활성화시킬 수 있는 장점이 있습니다. 글의 종류가 무엇인지 생각해보고 어떻게 읽을 것인지를 생각해보도록 합니다. 또한 내 경험을 떠올려보고 배경지식을 활성화시켜 보도록 합니다.특히 읽을 글감의 머리글이나 제목, 소제목, 그림을 보고 뒤의 내용도 에측해 보는 습관을 키워보는 것도 필요합니다.";
    }

    if (b2 >= 70.0) {
        comment2_1 = "독서 중 활동에서 독서방법의 인식이나 활용도가 우수한 편입니다.";
        comment2_2 = "독서 중에 요구되는 문식능력, 지구력, 이해력, 사고력, 상상력, 감상력, 적극성, 집중력 등이 우수합니다. 독서중 활동은 독서전 활동과 연관성을 갖습니다. 읽기 전의 예측과 어떤 차이가 있는지, 주인공이 왜 그러한 행동을 했는지 원인과 결과, 이유와 결과 등을 따져보는 습관이 필요합니다. 특히 글 사이에 생략되어 잇는 내용을 추론하여 중심내용을 완성시키는 사고활동이 활발하게 이뤄져야 합니다.";
        comment2_3 = "독서 중 활동이 잘 이뤄지는 편이기 때문에 이제는 좀 더 차원이 높은 책 읽기를 시도할 필요가 있습니다. 책을 다 읽을 때까지 끊임없이 ‘왜’를 따지는 습관을 키우시기 바랍니다. 장면이 바뀌거나, 글의 소주제 또는 문단이 바뀔 때 중심내용, 중심문단, 중심문장을 찾으면서 읽으면 언어능력이 보다 더 탄탄해질 것입니다. 특히 글의 내용, 구성을 한 눈에 알아볼 수 있게 내용 구성도를 그리는 훈련도 좋은 방법이 될 수 있습니다.";
    } else if (b2 < 70.0 && b2 >= 50.0) {
        comment2_1 = "독서 중 활동에서 독서방법의 인식이나 활용도가 보통 수준으로 좀 더 독서 중 집중력과 적극성을 발휘할 필요가 있습니다.";
        comment2_2 = "독서 중에 요구되는 문식능력, 지구력, 이해력, 사고력, 상상력, 감상력, 적극성, 집중력 등이 중간수준입니다. 독서중 활동은 독서전 활동과 연관성을 갖습니다. 읽기 전의 예측과 어떤 차이가 있는지, 주인공이 왜 그러한 행동을 했는지 원인과 결과, 이유와 결과 등을 따져보는 습관이 필요합니다. 특히 글 사이에 생략되어 있는 내용을 추론하여 중심내용을 완성시키는 사고활동이 활발하게 이뤄져야 합니다.";
        comment2_3 = "독서 중 활동이 보통 수준이기 때문에 먼저, 책을 읽을 때 가능하면 집중력을 발휘해 한 번에 책을 읽도록 습관을 들이기 바랍니다. 그렇게 한 후에 좀 더 차원이 높은 책 읽기를 시도할 필요가 있습니다. 책을 다 읽을 때까지 끊임없이 ‘왜’를 따지는 습관을 키우시기 바랍니다. 장면이 바뀌거나, 글의 소주제 또는 문단이 바뀔 때 중심내용, 중심문단, 중심문장을 찾으면서 읽으면 언어능력이 보다 더 탄탄해질 것입니다. 특히 글의 내용, 구성을 한 눈에 알아볼 수 있게 내용 구성도를 그리는 훈련도 좋은 방법이 될 수 있습니다.";
    } else {
        comment2_1 = "독서 중 활동에서 독서방법의 인식이나 활용도가 미흡한 수준입니다.";
        comment2_2 = "독서 중에 요구되는 문식능력, 지구력, 이해력, 사고력, 상상력, 감상력, 적극성, 집중력 등이 모두 상대적으로 낮은 수준에 머물러 있습니다. 독서중 활동은 독서전 활동과 연관성을 갖습니다. 읽기 전의 예측과 어떤 차이가 있는지, 주인공이 왜 그러한 행동을 했는지 원인과 결과, 이유와 결과 등을 따져보는 습관이 필요합니다. 특히 글 사이에 생략되어 잇는 내용을 추론하여 중심내용을 완성시키는 사고활동이 활발하게 이뤄져야 합니다.";
        comment2_3 = "독서 중 활동이 낮은 수준이기 때문에 먼저, 책을 읽을 때 가능하면 집중력을 발휘해 한 번에 책을 읽도록 습관을 들이기 바랍니다. 그렇게 한 후에 좀 더 차원이 높은 책 읽기를 시도할 필요가 있습니다. 책을 다 읽을 때까지 끊임없이 ‘왜’를 따지는 습관을 키우시기 바랍니다. 장면이 바뀌거나, 글의 소주제 또는 문단이 바뀔 때 중심내용, 중심문단, 중심문장을 찾으면서 읽으면 언어능력이 보다 더 탄탄해질 것입니다. 특히 글의 내용, 구성을 한 눈에 알아볼 수 있게 내용 구성도를 그리는 훈련도 좋은 방법이 될 수 있습니다.";
    }

    if (b3 >= 70.0) {
        comment3_1 = "독서 후 활동이 어느 정도 잘 이뤄지고 있는 편입니다. 독서 후에 요구되는 감상능력, 정리능력, 표현하기 등이 원활하게 이뤄지고 있는 편입니다.";
        comment3_2 = "책을 읽은 후에 하는 활동인 독서 후 활동은 가장 흔히 하는 독서 감상문을 쓰는 것부터 시작해 다양한 활동이 있을 수 있습니다. 그러나 이러한 독서후 활동의 주된 목적은 책을 읽은 후에 책의 내용을 정리하면서 자신의 생각을 덧붙여 사고의 확장을 꾀하는 것입니다. 특히 독서후 활동이 어휘,어법, 핵심 주제어, 문장쓰기, 문단쓰기, 토론하기 등으로 이어지고 책의 내용과 장르에 맞는 전략적 글쓰기가 이뤄진다면 최고의 독서 후 활동이라고 할 수 있습니다.";
        comment3_3 = "독서 후 활동이 어느 정도 잘 이뤄지고 있기 때문에 이제는 자신이 꾸준히 하고 있는 독후 활동의 질을 높이는 전략이 필요합니다. 예를 들어 책을 읽고 그냥 지나치지 말고, 읽은 책에 대한 기본 내용의 파악, 주제를 파악하고 생활에 적용할 수 있는 깊고 넓은 이해, 책의 내용에 대한 비판적 측면의 감상 ,자유로운 상상과 감상 등을 체크해보면 사고력, 창의력이 한 차원 더 업그레이드 될 것입니다. 또한 책을 많이 읽다 보면 작가 특유의 문체까지 짚어낼 수 있게 되는데, 그렇게 작가들을 모방해서 글을 쓰거나 책에서 배운 표현을 따라해 보는 것도 매우 유용한 활동이 될 수 있습니다.";
    } else if (b3 < 70.0 && b3 >= 50.0) {
        comment3_1 = "독서 후 활동이 중간수준입니다. 독서 후에 요구되는 감상능력, 정리능력, 표현하기 등에 대한 습관형성이 필요합니다. 좀 더 독서 후 활동을 강화하면 학습능력을 키우는데도 커다란 도움이 될 것입니다.";
        comment3_2 = "책을 읽은 후에 하는 활동인 독서 후 활동은 가장 흔히 하는 독서 감상문을 쓰는 것부터 시작해 다양한 활동이 있을 수 있습니다. 그러나 이러한 독서후 활동의 주된 목적은 책을 읽은 후에 책의 내용을 정리하면서 자신의 생각을 덧붙여 사고의 확장을 꾀하는 것입니다. 특히 독서후 활동이 어휘,어법, 핵심 주제어, 문장쓰기, 문단쓰기, 토론하기 등으로 이어지고 책의 내용과 장르에 맞는 전략적 글쓰기가 이뤄진다면 최고의 독서 후 활동이라고 할 수 있습니다.";
        comment3_3 = "독서 후 활동이 보통수준이기 때문에 독서 후에 그냥 지나치지 말고 다시한번 생각하는 시간, 정리하는 시간을 습관화하는 것이 필요합니다. 그런 후에 자신이 좀 더 독후 활동의 질을 높이는 전략이 필요합니다. 예를 들어 책을 읽고 그냥 지나치지 말고, 읽은 책에 대한 기본 내용의 파악, 주제를 파악하고 생활에 적용할 수 있는 깊고 넓은 이해, 책의 내용에 대한 비판적 측면의 감상 ,자유로운 상상과 감상 등을 체크해보면 사고력, 창의력이 한 차원 더 업그레이드 될 것입니다. 또한 책을 많이 읽다 보면 작가 특유의 문체까지 짚어낼 수 있게 되는데, 그렇게 작가들을 모방해서 글을 쓰거나 책에서 배운 표현을 따라해 보는 것도 매우 유용한 활동이 될 수 있습니다.";
    } else {
        comment3_1 = "독서 후 활동이 조금 미흡한 수준입니다.독서 후에 요구되는 감상능력, 정리능력, 표현하기 등에 대한 습관형성이 필요합니다. 좀 더 독서 후 활동을 강화하면 학습능력을 키우는데도 커다란 도움이 될 것입니다.";
        comment3_2 = "책을 읽은 후에 하는 활동인 독서 후 활동은 가장 흔히 하는 독서 감상문을 쓰는 것부터 시작해 다양한 활동이 있을 수 있습니다. 그러나 이러한 독서후 활동의 주된 목적은 책을 읽은 후에 책의 내용을 정리하면서 자신의 생각을 덧붙여 사고의 확장을 꾀하는 것입니다. 특히 독서후 활동이 어휘,어법, 핵심 주제어, 문장쓰기, 문단쓰기, 토론하기 등으로 이어지고 책의 내용과 장르에 맞는 전략적 글쓰기가 이뤄진다면 최고의 독서 후 활동이라고 할 수 있습니다.";
        comment3_3 = "독서 후 활동이 미흡하기 때문에 독서 후에 그냥 지나치지 말고 다시 한번 생각하는 시간, 정리하는 시간을 습관화하는 것이 필요합니다. 그런 후에 자신이 좀 더 독후 활동의 질을 높이는 전략이 필요합니다. 예를 들어 책을 읽고 그냥 지나치지 말고, 읽은 책에 대한 기본 내용의 파악, 주제를 파악하고 생활에 적용할 수 있는 깊고 넓은 이해, 책의 내용에 대한 비판적 측면의 감상 ,자유로운 상상과 감상 등을 체크해보면 사고력, 창의력이 한 차원 더 업그레이드 될 것입니다. 또한 책을 많이 읽다 보면 작가 특유의 문체까지 짚어낼 수 있게 되는데, 그렇게 작가들을 모방해서 글을 쓰거나 책에서 배운 표현을 따라해 보는 것도 매우 유용한 활동이 될 수 있습니다.";
    }
    $("#table6_1 > td:eq(0)").html(comment1_1);
    $("#table6_1 > td:eq(1)").html(comment1_2);
    $("#table6_1 > td:eq(2)").html(comment1_3);
    $("#table6_2 > td:eq(0)").html(comment2_1);
    $("#table6_2 > td:eq(1)").html(comment2_2);
    $("#table6_2 > td:eq(2)").html(comment2_3);
    $("#table6_3 > td:eq(0)").html(comment3_1);
    $("#table6_3 > td:eq(1)").html(comment3_2);
    $("#table6_3 > td:eq(2)").html(comment3_3);
}

function getResult5_Comment(c1) {
    var comment1_1 = "";
    var comment1_2 = "";
    var comment1_3 = "";

    if (c1 >= 70.0) {
        comment1_1 = "독서분야가 대체적으로 골고루 분포하고 있어 다양한 독서가 이뤄지고 있습니다.";
        comment1_2 = "";
        comment1_3 = "독서분야가 다양하게 이뤄지고 있기 때문에 다행이라고 할 수 있습니다. 다양한 주제의 책을 읽히면 읽힐수록 어휘력이 향상될 수 있도록 해주어야 하며, 다양한 주제의 책을 접할 수 있는 기회를 주어 책에 대한 흥미뿐만 아니라 책 읽기를 지속할 수 있도록 해야 합니다.";
    } else if (c1 < 70.0 && c1 >= 50.0) {
        comment1_1 = "다양한 장르와 주제의 독서가 보통수준입니다.";
        comment1_2 = "";
        comment1_3 = "다양한 장르와 주제에 대한 독서가 보통수준입니다. 다양한 주제별 도서 중에서도 좀 더 검증된 질 높은 도서, 보편적 가치와 시대를 반영하는 가치가 녹아 있는 책을 선정해서 읽도록 하는 것이 필요합니다. 고전문학, 역사이야기, 과학이야기, 시, 신문과 잡지, 위인전기 등을 읽을 수 있도록 지도해주면 좋습니다. 특히 역사, 지리, 법생활, 사회탐구 영역의 경우에도 적극적으로 읽도록 해주어야 합니다. 정독의 기능을 습관화 시키고 정보 획득을 위한 독서방법을 익힐 수 있도록 해야 합니다. 특히 다양한 분야의 독서가 이뤄질 수 있도록 책을 잘 선택하고 책을 읽기 전에 반드시 독서에 흥미를 부여할 수 있도록 유도하는 방법이 필요하며, 독서이력관리와 주제별 커리큘럼이 필요하다고 할 수 있습니다.";
    } else {
        comment1_1 = "다양한 장르와 주제의 독서가 미흡한 편입니다.";
        comment1_2 = "";
        comment1_3 = "다양한 장르와 주제에 대한 독서가 부족합니다. 고전문학, 역사이야기, 과학이야기, 시, 신문과 잡지, 위인전기 등을 읽을 수 있도록 지도해주면 좋습니다. 특히 역사, 지리, 법생활, 사회탐구 영역의 경우에도 적극적으로 읽도록 해주어야 합니다. 정독의 기능을 습관화 시키고 정보 획득을 위한 독서방법을 익힐 수 있도록 해야 합니다.특히 다양한 분야의 독서가 이뤄질 수 있도록 책을 잘 선택하고 책을 읽기 전에 반드시 독서에 흥미를 부여할 수 있도록 유도하는 방법이 필요하며, 독서이력관리와 주제별 커리큘럼이 필요하다고 할 수 있습니다.";
    }
    $("#table8_1 > td:eq(0)").html(comment1_1);
    $("#table8_2 > td:eq(0)").html(comment1_2);
    $("#table8_3 > td:eq(0)").html(comment1_3);
}

function getResult6_Comment(d1) {
    var comment1_1 = "";
    var comment1_2 = "";
    var comment1_3 = "";

    if (d1 >= 70.0) {
        comment1_1 = "학생은 다양한 장르와 주제의 책을 읽고 있는 편이며, 도서 장르 및 유형별 독서량도 아주 우수한 편입니다.";
        comment1_2 = "";
        comment1_3 = "다양한 분야의 책을 상대적으로 많이 있는 편이기 때문에 다행입니다. 국민독서실태조사 결과를 보면 학생의 종이책, 전자책, 오디오북을 포함한 연간 종합 독서량은 34.4 권으로 초등학생 66.6권, 중학생 23.5권 고등학생 12.5권으로 연령이 낮을수록 책을 많이 읽고, 고학년으로 올라갈수록 책을 적게 읽는 것으로 나타납니다. 평균 독서량과 비교해서도 높은 편이나, 전국 상위권인 17.3권과 서울대학교 학생들의 초등학교 시기 독서량인 월 24권과 비교하면 좀 더 책을 읽는 것이 바람직할 것으로 보입니다. 다만, 이제는 전략적인 책 읽기를 통해 취약한 부분을 보완하고 중,고등학교 때 시간조건상 읽지 못하는 책을 미리 읽으려는 선택이 필요합니다. 자기계발책도 읽게 하면 중학교, 고등학교 또는 대학교 진학시 정신력 강화에 커다란 도움이 될 것입니다.";
    } else if (d1 < 70.0 && d1 >= 50.0) {
        comment1_1 = "도서 장르 및 유형별 독서량도 보통 수준입니다.";
        comment1_2 = "";
        comment1_3 = "독서량이 보통수준입니다. 따라서 좀 더 적극적인 책 읽기가 필요하며, 이 시기가 아니면 책을 읽을 시간이 없다는 각오로 독서에 임해야 합니다. 국민독서실태조사 결과를 보면 학생의 종이책, 전자책, 오디오북을 포함한 연간 종합 독서량은 34.4 권으로 초등학생 66.6권, 중학생 23.5권 고등학생 12.5권으로 연령이 낮을수록 책을 많이 읽고, 고학년으로 올라갈수록 책을 적게 읽는 것으로 나타납니다. 평균 독서량과 비교해서도 높은 편이나, 전국 상위권인 17.3권과 서울대학교 학생들의 초등학교 시기 독서량인 월 24권과 비교하면 좀 더 책을 읽는 것이 바람직할 것으로 보입니다. 다만, 이제는 전략적인 책 읽기를 통해 취약한 부분을 보완하고 중,고등학교 때 시간조건상 읽지 못하는 책을 미리 읽으려는 선택이 필요합니다. 자기계발책도 읽게 하면 중학교, 고등학교 또는 대학교 진학시 정신력 강화에 커다란 도움이 될 것입니다.";
    } else {
        comment1_1 = "종합적으로 보면 도서 장르 및 유형별 독서량이 미흡한 수준입니다.";
        comment1_2 = "";
        comment1_3 = "독서량이 상대적으로 많이 부족한 편이기 때문에 좀 더 지속적인 책 읽기가 이뤄져야 합니다. 국민독서실태조사 결과를 보면 학생의 종이책, 전자책, 오디오북을 포함한 연간 종합 독서량은 34.4 권으로 초등학생 66.6권, 중학생 23.5권 고등학생 12.5권으로 연령이 낮을수록 책을 많이 읽고, 고학년으로 올라갈수록 책을 적게 읽는 것으로 나타납니다. 평균 독서량과 비교해서도 낮은 편이며, 전국 상위권인 17.3권과 서울대학교 학생들의 초등학교 시기 독서량인 월 24권과 비교하면 많은 분발이 필요합니다. 이제는 전략적인 책 읽기를 통해 취약한 부분을 보완하고 중,고등학교 때 시간 조건상 읽지 못하는 책을 미리 읽으려는 선택이 필요합니다. 자기계발책도 읽게 하면 중,고 진학시 정신력 강화에 커다란 도움이 될 것입니다.";
    }
    $("#table10_1 > td:eq(0)").html(comment1_1);
    $("#table10_2 > td:eq(0)").html(comment1_2);
    $("#table10_3 > td:eq(0)").html(comment1_3);
}