<%@page import="pack.player.PlayerBean"%>
<%@page import="pack.player.PlayerMgr"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="sessioncheck.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../css/coachInfo.css" rel="stylesheet" type="text/css">
<script src="../js/player.js"></script>
<title>선수정보</title>
</head>
<body>
<%@ include file="member_bar.jsp"%>
<div class="container">
	<div class="top-section">
        <input type="button" class="playeradd" value="선수 추가" onclick="addPlayer()">
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
                    <div class="button-container">
	                    <input type="button" class="playerbtn" value="수정" onclick="editPlayer('<%= player.getBn() %>', '<%= player.getName() %>', '<%= player.getBirth() %>', '<%= player.getNation() %>')">
	                    <input type="button" class="playerbtn" value="삭제" onclick="deletePlayer('<%= player.getBn() %>')">
	                </div>
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
                    <div class="button-container">
	                    <input type="button" class="playerbtn" value="수정" onclick="editPlayer('<%= player.getBn() %>', '<%= player.getName() %>', '<%= player.getBirth() %>', '<%= player.getNation() %>')">
	                    <input type="button" class="playerbtn" value="삭제" onclick="deletePlayer('<%= player.getBn() %>')">
                    </div>
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
                    <div class="button-container">
	                    <input type="button" class="playerbtn" value="수정" onclick="editPlayer('<%= player.getBn() %>', '<%= player.getName() %>', '<%= player.getBirth() %>', '<%= player.getNation() %>')">
	                    <input type="button" class="playerbtn" value="삭제" onclick="deletePlayer('<%= player.getBn() %>')">
                    </div>
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
                    <div class="button-container">
	                    <input type="button" class="playerbtn" value="수정" onclick="editPlayer('<%= player.getBn() %>', '<%= player.getName() %>', '<%= player.getBirth() %>', '<%= player.getNation() %>')">
	                    <input type="button" class="playerbtn" value="삭제" onclick="deletePlayer('<%= player.getBn() %>')">
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>    
</div>
</body>
</html>