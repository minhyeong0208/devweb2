$(document).ready(function() {
    var expend = document.getElementById('expendChart').getContext('2d');
    var expendChart; // 차트 객체를 저장하기 위한 변수, 초기 값 undefined

    function drawExpendChart() {
        $.ajax({
            url: 'expendChart.jsp', // 데이터를 가져올 파일 경로
            method: 'GET',
            dataType: 'json',  
            success: function(data) {
                var labels = ['훈련비','연봉(감독)','유지보수','선수구매','교통비','연봉(스태프)','마케팅비','식비','연봉(코치)','광고료'];
                var values = Object.values(data); // JSON 객체의 값을 배열로 변환
                
                if (expendChart) { // 이미 차트가 존재하는 경우 데이터를 업데이트하고 차트를 다시 그리는 조건문 
                    expendChart.data.labels = labels;  // 레이블 업데이트
                    expendChart.data.datasets.data = values; // 데이터 업데이트
                    expendChart.update(); // 차트 업데이트
                } else {
                    expendChart = new Chart(expend, {
                        type: 'bar', // 차트 타입: 막대 차트
                        data: {
                            labels: labels, // 차트의 레이블
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
                                    beginAtZero: true  // y축의 시작점을 0으로 설정
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
