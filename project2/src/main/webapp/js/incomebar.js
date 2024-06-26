$(document).ready(function() {
    var income = document.getElementById('incomeChart').getContext('2d');
    var incomeChart;

    function drawIncomeChart() {
        $.ajax({
            url: 'incomeChart.jsp',
            method: 'GET',
            dataType: 'json',
            success: function(data) {
                var labels = ['선수판매','스폰서','상품판매','임대료','팬비용','대여료','티켓비','방송료','광고료'];
                var values = Object.values(data);
                
                if (incomeChart) {
                    incomeChart.data.labels = labels;
                    incomeChart.data.datasets[0].data = values;
                    incomeChart.update();
                } else {
                    incomeChart = new Chart(income, {
                        type: 'bar',
                        data: {
                            labels: labels,
                            datasets: [{
                                label: '수입 데이터',
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
    drawIncomeChart();

    // 5초마다 데이터 업데이트
    setInterval(drawIncomeChart, 5000); // 5000 밀리초 = 5초
});
