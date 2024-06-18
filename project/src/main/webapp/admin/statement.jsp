<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="incomeMgr" class="pack.income.IncomeMgr" />
<jsp:useBean id="expendMgr" class="pack.expend.ExpendMgr" />

<%
// 시작일자, 종료일자 
String start_date = request.getParameter("start_date");  // 인수는 name 속성으로부터 가져옴
String end_date = request.getParameter("end_date");
String id = (String)session.getAttribute("adminID");

// 수입
// 리스트 형태로 수입 칼럼명 획득
//System.out.println(incomeMgr.getColumn());

ArrayList<String> incomeColName = incomeMgr.getColumn();
String[] col = {"티켓요금", "상품", "팬클럽", "중계료", "스폰서", "광고료", "대여료", "임대료", "선수판매"};

// 리스트 형태로 수입 값 획득
//System.out.println(incomeMgr.getIncome(colName));
ArrayList<Integer> colIncome = incomeMgr.getIncome(incomeColName, start_date, end_date);


// 지출
// 리스트 형태로 지출 칼럼명 획득
//System.out.println(expendMgr.getColumn());

ArrayList<String> expendColName = expendMgr.getColumn();
String[] col2 = {"선수구매", "교통비", "식비", "유지보수", "급여(코치)", "급여(감독)", "급여(스태프)", "훈련비", "마케팅비"};

//System.out.println(expendColName.size());
ArrayList<Integer> colExpend = expendMgr.getExpend(expendColName, start_date, end_date);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수입 지출 내역서</title>
<script src="../js/script.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.14.3/xlsx.full.min.js"></script> <!-- EXCEL 파일 다운로드 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script> <!-- 날짜 라이브러리 -->
<script type="text/javascript">
window.onload = () => {
	document.querySelector("#download").onclick=downloadStatement;
	document.querySelector("#search").onclick=settingDate;
}
</script>
</head>
<body>
<%@ include file="admin_bar.jsp"%>
<div class="container">
	<h2>수입 지출 내역서</h2>
	<form name="dateForm">
		<table>
			<tr>
				<td>시작 일자</td>
				<td><input type="date" name="start_date"></td>
				<td>종료 일자</td>
				<td><input type="date" name="end_date"></td>
				<td><input type="button" value="검색" id="search"></td>
			</tr>
		</table>
	</form>

	<form action="IE_statement.jsp" name="downloadStatement" method="get">
		<table border="1" id="stateTable">
			<tr>
				<th>수입목록</th><th>금액</th><th>지출목록</th><th>금액</th>
			</tr>
			<%
				int incomeSum = 0, expendSum = 0;
				for(int i = 3; i < incomeColName.size() - 1; i++) {
					incomeSum += colIncome.get(i);
					expendSum += colExpend.get(i);
			%>
				<tr>
					<!-- <td><%=incomeColName.get(i) %></td><td><%=colIncome.get(i) %></td><td>테스트</td><td>10</td> -->
					<td><%=col[i - 3] %></td><td><%=colIncome.get(i) %></td><td><%=col2[i - 3] %></td><td><%=colExpend.get(i) %></td> 
				</tr>
			<%
				}
			%>
			<tr>
				<td></td>
				<td><%=incomeSum %></td>
				<td></td>
				<td><%=expendSum %></td>
			</tr>
		</table>
		<input type="button" value="명세서 다운로드" id="download">
	</form>
</div>

</body>
</html>