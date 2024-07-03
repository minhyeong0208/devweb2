<%@page import="pack.admin.AdminDto"%>
<%@page import="pack.stat.StatBean"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="sessioncheck_admin.jsp" %>

<jsp:useBean id="incomeMgr" class="pack.income.IncomeMgr" />
<jsp:useBean id="statMgr" class="pack.stat.StatMgr" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../css/style.css" rel="stylesheet" type="text/css">
<link href="../css/dashboard.css" rel="stylesheet" type="text/css">
<title>대시보드</title>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script src="../js/incomebar.js"></script>
<script src="../js/expendbar.js"></script>
<script src="../js/doughnut.js"></script>
<script src="../js/dashtable.js"></script>
</head>
<body>
	<%@ include file="admin_bar.jsp"%>
	<div class="container">
		<%-- <div class="top-section">
        <div class="box">
            <h3>수입 정보</h3>
            수입 정보 내용 삽입
        </div>
        <div class="box">
            <h3>지출 정보</h3>
            지출 정보 내용 삽입
        </div>
        <div class="box">
            <h3>팀 실적</h3>
            팀 실적 내용 삽입
        </div>
        <div class="box">
            <h3>경기 날짜 및 시간</h3>
            경기 날짜 및 시간 내용 삽입
        </div>
    </div>
     --%>

		<div class="middle-section">
			<div class="box">
				<h3>수입 정보</h3>
				<%-- 수입 정보 내용 삽입 --%>
				<canvas id="incomeChart" style="width: 660px; height: 400px;"></canvas>
			</div>
			<div class="box">
				<h3>지출 정보</h3>
				<%-- 지출 정보 내용 삽입 --%>
				<canvas id="expendChart" style="width: 660px; height: 400px;"></canvas>
			</div>
			<div class="box">
				<h3>총 수입/지출 정보</h3>
				<%--총 수입/지출 정보 내용 삽입 --%>
				<canvas id="totalChart"
					style="width: 80%; max-width: 400px; margin: 0 auto;"></canvas>
			</div>
		</div>
		<div class="bottom-section">
			<div class="box">
				<h3>최근 시즌 선수 기록</h3>
				<%-- <%@include file="dashstat.jsp"%>--%>
				<div id="table"></div>
			</div>
		</div>
	</div>
</body>
</html>