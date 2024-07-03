<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pack.injury.InjuryMgr"%>
<%@ page import="pack.injury.InjuryBean"%>
<%@ page import="pack.player.PlayerMgr"%>
<%@ page import="pack.player.PlayerBean"%>
<%@ page import="java.util.ArrayList"%>
<%@ include file="sessioncheck.jsp"%>
<%
    InjuryMgr injuryMgr = new InjuryMgr();
    ArrayList<InjuryBean> injuryList = injuryMgr.getAllInjuries(teamcode);
    PlayerMgr playerMgr = new PlayerMgr();
    ArrayList<PlayerBean> playerList = playerMgr.getAllPlayers(teamcode);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부상 정보</title>
<link href="../css/staff_injury.css" rel="stylesheet" type="text/css">
<script src="../js/injury.js"></script>
</head>
<body>
<%@ include file="member_bar.jsp"%>
<div class="container">
    <div class="top-section">
        <input type="button" class="injuryadd" value="부상 선수 추가" onclick="openAddInjuryForm()">
    </div>
    <div class="bottom-section">
        <h3>부상 선수 목록</h3>
        <div class="profile-grid">
            <% for (InjuryBean injury : injuryList) { %>
            <div class="profile-card">
                <div class="profile-image"></div>
                <div class="profile-info">
                    <p>
                        <%
                            for (PlayerBean player : playerList) {
                                if (player.getBn() == injury.getBn()) {
                                    out.print(player.getName());
                                    break;
                                }
                            }
                        %>
                    </p>
                    <p>부상 부위 : <%= injury.getPart() %></p>
                    <p>부상 상태 : <%= injury.getState() %></p>
                    <p>주치의 : <%= injury.getDoctor() %></p>
                    <div class="button-container">
	                    <input type="button" class="injurybtn" value="수정" onclick="editInjury('<%= injury.getBn() %>')">
	                    <input type="button" class="injurybtn" value="삭제" onclick="deleteInjury('<%= injury.getBn() %>')">
	                </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>
</div>
</body>
</html>
