<%@page import="pack.staff.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="pack.staff.StaffMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="sessioncheck_admin.jsp" %>
<%
request.setCharacterEncoding("UTF-8");
StaffMgr staffMgr = new StaffMgr();
ArrayList<StaffBean> sportsScientistList = staffMgr.getStaffByCategory("스포츠 사이언티스트", teamcode);
ArrayList<StaffBean> trainerList = staffMgr.getStaffByCategory("트레이너", teamcode);
ArrayList<StaffBean> doctorList = staffMgr.getStaffByCategory("주치의", teamcode);
ArrayList<StaffBean> equipmentManagerList = staffMgr.getStaffByCategory("장비관리사", teamcode);
ArrayList<StaffBean> Interpreterlist = staffMgr.getStaffByCategory("통역", teamcode);
ArrayList<StaffBean> PaoList = staffMgr.getStaffByCategory("전력분석관", teamcode);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../css/coachInfo.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/staff.js"></script>
<title>스태프정보</title>
</head>
<body>
<%@ include file="admin_bar.jsp"%>
<div class="container">
    <div class="top-section">
        <h3>스포츠 사이언티스트</h3>      
        <div class="profile-grid">
        <% for (StaffBean staff : sportsScientistList) { %>
            <div class="profile-card">
                <div class="profile-image"></div>
                <div class="profile-info">
                    <p>스태프 코드: <%= staff.getCode() %></p>
                    <p>이름: <%= staff.getName() %></p>
                    <p>국적: <%= staff.getNation() %></p>
                    <p>입단일: <%= staff.getIbdan() %></p>
  					<input type="hidden" name="code" value="<%=staff.getCode()%>">
                </div>
            </div>
        <% } %>
        </div>
    </div>
<br><br><br>

    <div class="bottom-section">
        <h3>트레이너</h3>
        <div class="profile-grid">
        <% for (StaffBean staff : trainerList) { %>
            <div class="profile-card">
                <div class="profile-image"></div>
                <div class="profile-info">
                    <p>스태프 코드: <%= staff.getCode() %></p>
                    <p>이름: <%= staff.getName() %></p>
                    <p>국적: <%= staff.getNation() %></p>
                    <p>입단일: <%= staff.getIbdan() %></p>
  					<input type="hidden" name="code" value="<%=staff.getCode()%>">
                </div>
            </div>
        <% } %>
        </div>
    </div>
<br><br><br>

    <div class="bottom-section">
        <h3>주치의</h3>       
        <div class="profile-grid">
        <% for (StaffBean staff : doctorList) { %>
            <div class="profile-card">
                <div class="profile-image"></div>
                <div class="profile-info">
                    <p>스태프 코드: <%= staff.getCode() %></p>
                    <p>이름: <%= staff.getName() %></p>
                    <p>국적: <%= staff.getNation() %></p>
                    <p>입단일: <%= staff.getIbdan() %></p>
  					<input type="hidden" name="code" value="<%=staff.getCode()%>">
                </div>
            </div>
        <% } %>
        </div>
    </div>
<br><br><br>

   <div class="bottom-section">
        <h3>장비관리사</h3>
        <div class="profile-grid">
        <% for (StaffBean staff : equipmentManagerList) { %>
            <div class="profile-card">
                <div class="profile-image"></div>
                <div class="profile-info">
                    <p>스태프 코드: <%= staff.getCode() %></p>
                    <p>이름: <%= staff.getName() %></p>
                    <p>국적: <%= staff.getNation() %></p>
                    <p>입단일: <%= staff.getIbdan() %></p>
  					<input type="hidden" name="code" value="<%=staff.getCode()%>">
                </div>
            </div>
        <% } %> 
        </div>
    </div>
<br><br><br>

    <div class="bottom-section">
        <h3>통역</h3>       
        <div class="profile-grid">
        <% for (StaffBean staff : Interpreterlist) { %>
            <div class="profile-card">
                <div class="profile-image"></div>
                <div class="profile-info">
                    <p>스태프 코드: <%= staff.getCode() %></p>
                    <p>이름: <%= staff.getName() %></p>
                    <p>국적: <%= staff.getNation() %></p>
                    <p>입단일: <%= staff.getIbdan() %></p>
  					<input type="hidden" name="code" value="<%=staff.getCode()%>">
                </div>
            </div>
        <% } %>
        </div>
    </div>
<br><br><br>
    <div class="bottom-section">
        <h3>전력분석관</h3>       
        <div class="profile-grid">
        <% for (StaffBean staff : PaoList) { %>
            <div class="profile-card">
                <div class="profile-image"></div>
                <div class="profile-info">
                    <p>스태프 코드: <%= staff.getCode() %></p>
                    <p>이름: <%= staff.getName() %></p>
                    <p>국적: <%= staff.getNation() %></p>
                    <p>입단일: <%= staff.getIbdan() %></p>
  					<input type="hidden" name="code" value="<%=staff.getCode()%>">
                </div>
            </div>
        <% } %>
        </div>
    </div>
<br><br><br>
</div>
</body>
</html>
 