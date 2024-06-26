$(document).ready(function() {
	function drawTable() {
		$.ajax({
			type: "get", 
			url: 'dashstat.jsp',
			dataType: "json", // 반환 데이터 타입 -> json 타입을 받는다.
			success: function(datas) {
				let str = "";
				str += "<table>";
				str += "<tr><th>일련번호</th><th>등번호</th><th>선수명</th><th>시즌</th><th>출전경기</th><th>골</th><th>도움</th><th>경고</th><th>퇴장</th></tr>";
				$.each(datas.stat, function(idx, data) {// datas로부터 idx와 data를 하나씩 받아온다
					str += "<tr>";
					str += "<td>" + data["code"] + "</td>";
					str += "<td>" + data["bn"] + "</td>";
					str += "<td>" + data["name"] + "</td>";
					str += "<td>" + data["season"] + "</td>";
					str += "<td>" + data["match"] + "</td>";
					str += "<td>" + data["goal"] + "</td>";
					str += "<td>" + data["as"] + "</td>";
					str += "<td>" + data["yellow"] + "</td>";
					str += "<td>" + data["red"] + "</td>";
					str += "</tr>";
				});
				str += "</table>";
				$("#table").html(str); // 변경 사항이 있는 경우, 5초마다 교체
			}, error: function() {
				$('#table').text('데이터 생성 오류');
			}

		});
	}
	
	// 최초 데이터
	drawTable();
	
	//5초마다 갱신
	setInterval(drawTable, 5000);
});