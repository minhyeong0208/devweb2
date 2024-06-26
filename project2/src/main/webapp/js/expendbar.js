$(document).ready(function() {
    var expend = document.getElementById('expendChart').getContext('2d');
    var expendChart;

    function drawExpendChart() {
        $.ajax({
            url: 'expendChart.jsp',
            method: 'GET',
            dataType: 'json',
            success: function(data) {
                var labels = ['훈련비','연봉(감독)','유지보수','선수구매','교통비','연봉(스태프)','마케팅비','식비','연봉(코치)','광고료'];
                var values = Object.values(data);
                
                if (expendChart) {
                    expendChart.data.labels = labels;
                    expendChart.data.datasets[0].data = values;
                    expendChart.update();
                } else {
                    expendChart = new Chart(expend, {
                        type: 'bar',
                        data: {
                            labels: labels,
                            datasets: [{
                                label: '지출 데이터',
                                data: values,
                                backgroundColor: [
                                    'rgba(255,99,132,0.2)',
                                    'rgba(54,162,235,0.2)',
                                    'rgba(255,206,86,0.2)',
                                    'rgba(75,192,192,0.2)',
                                    'rgba(153,102,255,0.2)',
                                    'rgba(255,159,64,0.2)',
                                    'rgba(255,132,172,0.2)',
                                    'rgba(24,56,23,0.2)',
                                    'rgba(53,99,255,0.2)'
                                ],
                                borderColor: [
                                    'rgba(255,99,132,1)',
                                    'rgba(54,162,235,1)',
                                    'rgba(255,206,86,1)',
                                    'rgba(75,192,192,1)',
                                    'rgba(153,102,255,1)',
                                    'rgba(255,159,64,1)',
                                    'rgba(255,132,172,1)',
                                    'rgba(24,56,23,1)',
                                    'rgba(53,99,255,1)'
                                ],
                                borderWidth: 1
                            }]
                        },
                        options: {
                            scales: {
                                y: {
                                    beginAtZero: true
                                }
                            }
                        }
                    });
                }
            },
            error: function(error) {
                console.log("Error:", error);
            }
        });
    }

    // 최초 데이터 로드
    drawExpendChart();

    // 5초마다 데이터 업데이트
    setInterval(drawExpendChart, 5000); // 5000 밀리초 = 5초
});
