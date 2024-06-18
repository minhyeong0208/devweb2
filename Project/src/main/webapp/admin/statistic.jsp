<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="incomeMgr" class="pack.income.IncomeMgr" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>통계</title>
</head>
<body>
<%@ include file="admin_bar.jsp"%>
<div class="container">
	<h2>통계</h2>
	<form action="">
		<table>
			<tr>
				<td><a href="addPlayer.jsp">선수 추가</a></td>
			</tr>
		</table>
	</form>
	
	<form action="">
		<table border="1">
			<tr>
				<th>등번호</th><th>선수이름</th><th>생일</th><th>포지션</th><th>국적</th><th>잠재력</th><th>계약 시작일</th><th>계약 종료일</th><th>프로데뷔</th>
			</tr>
			
		</table>
	</form>
</div>
</body>
</html>