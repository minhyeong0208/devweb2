<%@page import="pack.player.PlayerBean"%>
<%@page import="pack.player.PlayerMgr"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="sessioncheck_admin.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../css/coachInfo.css" rel="stylesheet" type="text/css">
<script src="../js/player.js"></script>
<title>선수정보</title>
</head>
<body>
<%@ include file="admin_bar.jsp"%>
<div class="container">
	<div class="top-section">
        <%-- <button onclick="addPlayer()">선수 추가</button> --%>
    </div>
    <div class="bottom-section">
        <%
            PlayerMgr playerMgr = new PlayerMgr();
            ArrayList<PlayerBean> gkList = playerMgr.getPlayersByPosition("GK", teamcode);
            ArrayList<PlayerBean> dfList = playerMgr.getPlayersByPosition("DF", teamcode);
            ArrayList<PlayerBean> mfList = playerMgr.getPlayersByPosition("MF", teamcode);
            ArrayList<PlayerBean> fwList = playerMgr.getPlayersByPosition("FW", teamcode);
        %>

        <h3>골키퍼(GK)</h3>
        <div class="profile-grid">
            <% for (PlayerBean player : gkList) { %>
            <div class="profile-card">
                <div class="profile-image"></div>
                <div class="profile-info">
                    <p>등번호 : <%= player.getBn() %></p>
                    <p>이름 : <%= player.getName() %></p>
                    <p>생년월일 : <%= player.getBirth() %></p>
                    <p>국가 : <%= player.getNation() %></p>
                    <%-- 재정 관리자(admin)의 경우, 선수 추가/ 삭제 기능 제한
                    <button onclick="editPlayer('<%= player.getBn() %>', '<%= player.getName() %>', '<%= player.getBirth() %>', '<%= player.getNation() %>')">수정</button>
                    <button onclick="deletePlayer('<%= player.getBn() %>')">삭제</button>
                	--%>
                </div>
            </div>
            <% } %>
        </div>
        <br><br><br>
        
        <h3>수비수(DF)</h3>
        <div class="profile-grid">
            <% for (PlayerBean player : dfList) { %>
            <div class="profile-card">
                <div class="profile-image"></div>
                <div class="profile-info">
                    <p>등번호 : <%= player.getBn() %></p>
                    <p>이름 : <%= player.getName() %></p>
                    <p>생년월일 : <%= player.getBirth() %></p>
                    <p>국가 : <%= player.getNation() %></p>
                    <%-- 재정 관리자(admin)의 경우, 선수 추가/ 삭제 기능 제한
                    <button onclick="editPlayer('<%= player.getBn() %>', '<%= player.getName() %>', '<%= player.getBirth() %>', '<%= player.getNation() %>')">수정</button>
                    <button onclick="deletePlayer('<%= player.getBn() %>')">삭제</button>
                	--%>
                </div>
            </div>
            <% } %>
        </div>
        <br><br><br>
        
        <h3>미드필더(MF)</h3>
        <div class="profile-grid">
            <% for (PlayerBean player : mfList) { %>
            <div class="profile-card">
                <div class="profile-image"></div>
                <div class="profile-info">
                    <p>등번호 : <%= player.getBn() %></p>
                    <p>이름 : <%= player.getName() %></p>
                    <p>생년월일 : <%= player.getBirth() %></p>
                    <p>국가 : <%= player.getNation() %></p>
                    <%-- 재정 관리자(admin)의 경우, 선수 추가/ 삭제 기능 제한
                    <button onclick="editPlayer('<%= player.getBn() %>', '<%= player.getName() %>', '<%= player.getBirth() %>', '<%= player.getNation() %>')">수정</button>
                    <button onclick="deletePlayer('<%= player.getBn() %>')">삭제</button>
               		--%>
                </div>
            </div>
            <% } %>
        </div>
        <br><br><br>
        
        <h3>공격수(FW)</h3>
        <div class="profile-grid">
            <% for (PlayerBean player : fwList) { %>
            <div class="profile-card">
                <div class="profile-image"></div>
                <div class="profile-info">
                    <p>등번호 : <%= player.getBn() %></p>
                    <p>이름 : <%= player.getName() %></p>
                    <p>생년월일 : <%= player.getBirth() %></p>
                    <p>국가 : <%= player.getNation() %></p>
                    <%-- 재정 관리자(admin)의 경우, 선수 추가/ 삭제 기능 제한
                    <button onclick="editPlayer('<%= player.getBn() %>', '<%= player.getName() %>', '<%= player.getBirth() %>', '<%= player.getNation() %>')">수정</button>
                    <button onclick="deletePlayer('<%= player.getBn() %>')">삭제</button>
                	--%>
                </div>
            </div>
            <% } %>
        </div>
    </div>    
</div>
</body>
</html>
