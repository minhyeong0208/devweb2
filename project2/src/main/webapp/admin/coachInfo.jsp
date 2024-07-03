<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="pack.coach.CoachBean"%>
<%@page import="pack.coach.CoachMgr"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../css/coachInfo.css" rel="stylesheet" type="text/css">
<script src="../js/coach.js"></script>
<title>코치정보</title>
</head>
<body>
<%@ include file="sessioncheck_admin.jsp" %>
<%@ include file="admin_bar.jsp"%>
<div class="container">
    <%
        CoachMgr coachMgr = new CoachMgr();
        ArrayList<CoachBean> headCoachList = coachMgr.getCoachesByCategory("감독", teamcode); 
        ArrayList<CoachBean> coachList = coachMgr.getAllCoaches(teamcode);
        ArrayList<CoachBean> trainerList = coachMgr.getCoachesByCategory("트레이너", teamcode);
        ArrayList<CoachBean> doctorList = coachMgr.getCoachesByCategory("주치의", teamcode);
        ArrayList<CoachBean> equipmentManagerList = coachMgr.getCoachesByCategory("장비관리사", teamcode);
        ArrayList<CoachBean> sportsScientistList = coachMgr.getCoachesByCategory("스포츠사이언티스트", teamcode);
    %>

    <div class="top-section">
        <%--<button type="button" onclick="addCoach()">코치 추가</button><br><br> --%>
        <h3>감독(HEAD COACH)</h3>
        <div class="profile-grid">
            <% for (CoachBean coach : headCoachList) { %>
            <div class="profile-card">
                <div class="profile-image"></div>
                <div class="profile-info">
                    <p><%= coach.getName() %></p>
                    <p>입단일 : <%= coach.getIbdan() %></p>
                    <p><%= coach.getPos() %></p>
                    <%--
                    <button type="button" onclick="editCoach(<%= coach.getCode() %>)">수정</button>
                    <button type="button" onclick="deleteCoach(<%= coach.getCode() %>)">삭제</button>
                	 --%>
                </div>
            </div>
            <% } %>
        </div>
    </div>
    <br><br><br>

    <div class="bottom-section">
        <h3>코치(COACH)</h3>
        <div class="profile-grid">
            <% for (CoachBean coach : coachList) { %>
            <div class="profile-card">
                <div class="profile-image"></div>
                <div class="profile-info">
                    <p><%= coach.getName() %></p>
                    <p>입단일 : <%= coach.getIbdan() %></p>
                    <p><%= coach.getPos() %></p>
                    <%--
                    <button type="button" onclick="editCoach(<%= coach.getCode() %>)">수정</button>
                    <button type="button" onclick="deleteCoach(<%= coach.getCode() %>)">삭제</button>
                	--%>
                </div>
            </div>
            <% } %>
        </div>
    </div>
    <br><br><br>

    <div class="bottom-section">
        <h3>트레이너(TRAINER)</h3>
        <div class="profile-grid">
            <% for (CoachBean coach : trainerList) { %>
            <div class="profile-card">
                <div class="profile-image"></div>
                <div class="profile-info">
                    <p><%= coach.getName() %></p>
                    <p>입단일 : <%= coach.getIbdan() %></p>
                    <p><%= coach.getPos() %></p>
                    <%--
                    <button type="button" onclick="editCoach(<%= coach.getCode() %>)">수정</button>
                    <button type="button" onclick="deleteCoach(<%= coach.getCode() %>)">삭제</button>
                	--%>
                </div>
            </div>
            <% } %>
        </div>
    </div>
    <br><br><br>

    <div class="bottom-section">
        <h3>주치의(DOCTOR)</h3>
        <div class="profile-grid">
            <% for (CoachBean coach : doctorList) { %>
            <div class="profile-card">
                <div class="profile-image"></div>
                <div class="profile-info">
                    <p><%= coach.getName() %></p>
                    <p>입단일 : <%= coach.getIbdan() %></p>
                    <p><%= coach.getPos() %></p>
                    <%--
                    <button type="button" onclick="editCoach(<%= coach.getCode() %>)">수정</button>
                    <button type="button" onclick="deleteCoach(<%= coach.getCode() %>)">삭제</button>
                	--%>
                </div>
            </div>
            <% } %>
        </div>
    </div>
    <br><br><br>

    <div class="bottom-section">
        <h3>장비관리사(EQUIPMENT MANAGER)</h3>
        <div class="profile-grid">
            <% for (CoachBean coach : equipmentManagerList) { %>
            <div class="profile-card">
                <div class="profile-image"></div>
                <div class="profile-info">
                    <p><%= coach.getName() %></p>
                    <p>입단일 : <%= coach.getIbdan() %></p>
                    <p><%= coach.getPos() %></p>
                    <%--
                    <button type="button" onclick="editCoach(<%= coach.getCode() %>)">수정</button>
                    <button type="button" onclick="deleteCoach(<%= coach.getCode() %>)">삭제</button>
                	 --%>
                </div>
            </div>
            <% } %>
        </div>
    </div>
    <br><br><br>

    <div class="bottom-section">
        <h3>스포츠 사이언티스트(SPORTS SCIENTIST)</h3>
        <div class="profile-grid">
            <% for (CoachBean coach : sportsScientistList) { %>
            <div class="profile-card">
                <div class="profile-image"></div>
                <div class="profile-info">
                    <p><%= coach.getName() %></p>
                    <p>입단일 : <%= coach.getIbdan() %></p>
                    <p><%= coach.getPos() %></p>
                    <%-- 
                    <button type="button" onclick="editCoach(<%= coach.getCode() %>)">수정</button>
                    <button type="button" onclick="deleteCoach(<%= coach.getCode() %>)">삭제</button>
                	--%>
                </div>
            </div>
            <% } %>
        </div>
    </div>
</div>
</body>
</html>
