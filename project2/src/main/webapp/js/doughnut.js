$(document).ready(function() {
    var total = document.getElementById('totalChart').getContext('2d');
    var totalChart;

    function drawChart(url, chart, ctx, label) {
        $.ajax({
            url: url,
            method: 'GET',
            dataType: 'json',
            success: function(data) {
                // 차트 업데이트를 위한 메소드 호출
                updateChart(data, chart, ctx, label);
            },
            error: function(error) {
                console.log("Error:", error);
            }
        });
    }

    function updateChart(data, chart, ctx, label) {
        var labels = ['총 수입', '총 지출'];
        var values = Object.values(data);

        if (chart) {
            chart.data.labels = labels;
            chart.data.datasets[0].data = values;
            chart.update();
        } else {
            chart = new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: labels, // JSON 데이터에서 라벨을 가져옴
                    datasets: [{
                        label: label,
                        data: values, // JSON 데이터에서 값 가져옴
                        backgroundColor: [
                            'rgba(255,99,132,0.2)',
                            'rgba(54,162,235,0.2)'
                        ],
                        borderColor: [
                            'rgba(255,99,132,1)',
                            'rgba(54,162,235,1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {}
            });

            // chart 변수를 전역 변수에 할당
            totalChart = chart;
        }
    }

    // 최초 데이터 로드
    drawChart('totalChart.jsp', totalChart, total, '총 수입/지출 데이터');

    // 5초마다 데이터 업데이트
    setInterval(function() {
        drawChart('totalChart.jsp', totalChart, total, '총 수입/지출 데이터');
    }, 5000);
});
