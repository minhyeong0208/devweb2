<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ include file="sessioncheck.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../css/dashboard_member.css" rel="stylesheet" type="text/css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="../js/gameChart2.js"></script>
<title>대시보드</title>
</head>
<body>
<%@ include file="member_bar.jsp"%>
<div class="container">
<!-- <div class="top-section">
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
     -->

    <div class="middle-section">
        <div class="box">
            <h3>전년도 대비</h3>
            <!-- 경기 정보 내용 삽입 -->
            <canvas id="myChart2" style="width:80%;max-width:400px; margin: 0 auto;"></canvas>
        </div>
        <div class="box">
            <h3>홈/원정 비교</h3>
            <!-- 수입 정보 내용 삽입 -->
            <canvas id="myChart3" style="width:80%;max-width:700px; margin: 0 auto;"></canvas>
            
        </div>
        <div class="box">
            <h3>승무패 비교</h3>
            <!-- 지출 정보 내용 삽입 -->
            <canvas id="myChart4" style="width:80%;max-width:400px; margin: 0 auto;"></canvas>
        </div>
    </div>
    <div class="bottom-section">
        <div class="box">
        <h3>현재 리그 순위</h3>
	 	   <%@ include file="gameranktable.jsp"%>            
        </div>
    </div>
</div>
</body>
</html>