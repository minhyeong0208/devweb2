$(document).ready(function() {
    // 해당 아이디 태그에 2d 차트 그리기
    var ctx = document.getElementById('myChart2').getContext('2d');
    var myChart;

    function fetchDataAndUpdateChart() {
        $.ajax({
            url: '../game2/teamAvgByYear.jsp',
            method: 'GET',
            dataType: 'json',
            success: function(data) {
                // 데이터 가져온 후 차트 업데이트
                // debugger;
                updateChart(data);
            },
            error: function(error) {
                console.log("Error:", error);
            }
        });
    }

    function updateChart(data) {
        // 전년도 자료
        var labels_last = Object.keys(data[0]);
        var values_last = Object.values(data[0]);
        // 올해 자료
        var labels_this = Object.keys(data[1]);
        var values_this = Object.values(data[1]);

        //debugger;

        if (myChart) {
            myChart.data.labels = labels_this;
            myChart.data.datasets[0].data = values_this;
            myChart.update();
        } else {
            myChart = new Chart(ctx, {
                type: 'radar', // 레이더 차트
                data: {
                    labels: labels_last, // JSON에서 key값 가져오기 (막대 그래프 기준 x축 라벨)
                    datasets: [{
                        label: 'This Year',
                        data: values_this, // JSON에서 value값 가져오기
                        backgroundColor: [
                            'rgba(140,200,255,0.2)'
                        ],
                        borderColor: [
                            'rgba(140,200,255,1)'
                        ],
                        borderWidth: 1
                    },
                    {
                        label: 'Last Year',
                        data: values_last, // JSON에서 value값 가져오기
                        backgroundColor: [
                            'rgba(255,99,132,0.2)'
                        ],
                        borderColor: [
                            'rgba(255,99,132,1)'
                        ],
                        borderWidth: 1
                    }

                    ]
                },
                options: {
                      // 도넛 차트일 경우에는 x축, y축 설정 필요 X
                      scale: {
                          ticks: {
                              beginAtZero: true,
                              max: 100,
                              min: 0,
                              stepSize: 20
                          }
                      },
                      maintainAspectRatio: 'true',
                      responsive: 'true' // 반응형

                }
            });
        }
    }

    // 최초 데이터 로드
    fetchDataAndUpdateChart();

    // 5초마다 데이터 업데이트
    setInterval(fetchDataAndUpdateChart, 5000); // 5000 밀리초 = 5초
});

$(document).ready(function() {
    var ctx = document.getElementById('myChart3').getContext('2d');
    var myChart;

    function fetchDataAndUpdateChart() {
        $.ajax({
            url: '../game2/teamAvgByYear.jsp',
            method: 'GET',
            dataType: 'json',
            success: function(data) {
                // 데이터를 성공적으로 가져온 후 차트를 업데이트합니다.
                //debugger;
                updateChart(data);
            },
            error: function(error) {
                console.log("Error:", error);
            }
        });
    }

    function updateChart(data) {
        var labels_home = Object.keys(data[0]);
        var values_home = Object.values(data[0]);

        var labels_away = Object.keys(data[1]);
        var values_away = Object.values(data[1]);

        //debugger;

        if (myChart) {
            myChart.data.labels = labels_home;
            myChart.data.datasets[0].data = values_away;
            myChart.data.datasets[1].data = values_home;
            myChart.update();
        } else {
            myChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels_home, // JSON 데이터에서 라벨을 가져옵니다.
                    datasets: [{
                        label: '원정경기',
                        data: values_away, // JSON 데이터에서 실제 수치를 가져옵니다.
                        backgroundColor: [
                            'rgba(255,99,132,0.2)'
                        ],
                        borderColor: [
                            'rgba(255,99,132,1)'
                        ],
                        borderWidth: 1
                    },
                    {
                        label: '홈경기',
                        data : values_home,
                        backgroundColor: [
                            'rgba(100,99,255,0.2)'
                        ],
                        borderColor: [
                            'rgba(100,99,255,1)'
                        ],
                        borderWidth: 1
                    }

                    ]
                },
                options: {
					plugins: {
					      legend: {
					        position: 'top',
					      }
					      },	
                  maintainAspectRatio: 'false',
                  //responsive: 'true' // 반응형
                }
            });
        }
    }

    // 최초 데이터 로드
    fetchDataAndUpdateChart();

    // 5초마다 데이터 업데이트
    setInterval(fetchDataAndUpdateChart, 5000); // 5000 밀리초 = 5초
});


$(document).ready(function() {
    var ctx = document.getElementById('myChart4').getContext('2d');
    var myChart;

    function fetchDataAndUpdateChart() {
        $.ajax({
            url: '../game2/teamResultRatio.jsp',
            method: 'GET',
            dataType: 'json',
            success: function(data) {
                // 데이터를 성공적으로 가져온 후 차트를 업데이트합니다.
                //debugger;
                updateChart(data);
            },
            error: function(error) {
                console.log("Error:", error);
            }
        });
    }

    function updateChart(data) {
        var labels = Object.keys(data);
        var values = Object.values(data);

        //debugger;

        if (myChart) {
            myChart.data.labels = labels;
            myChart.data.datasets[0].data = values;
            myChart.update();
        } else {
            myChart = new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels : labels,
                    datasets: [{
                        label: 'game_result',
                        data: values, // JSON 데이터에서 실제 수치 가져오기
                        backgroundColor: [
                            'rgba(100,150,255,0.2)',
                            'rgba(100,255,100,0.2)',
                            'rgba(255,100,50,0.2)'
                        ],
                        borderColor: [
                            'rgba(100,150,255,1)',
                            'rgba(100,255,100,1)',
                            'rgba(255,100,50,1)'
                        ],
                        borderWidth: 1
                    }
                    ]
                },
                options: {
                  //maintainAspectRatio: 'true',
                  //responsive: 'true' // 반응형
                }
            });
        }
    }

    // 최초 데이터 로드
    fetchDataAndUpdateChart();

    // 5초마다 데이터 업데이트
    setInterval(fetchDataAndUpdateChart, 5000); // 5000 밀리초 = 5초
});
