<%@page import="pack.staff.*"%> <!-- pack.staff 패키지 임포트 -->
<%@page import="java.util.ArrayList"%> <!-- java.util.ArrayList 임포트 -->
<%@page import="pack.staff.StaffMgr"%> <!-- pack.staff.StaffMgr 임포트 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <!-- 페이지 설정 -->
<%@ include file="sessioncheck.jsp" %> <!-- 세션 체크 JSP 포함 -->

<%
request.setCharacterEncoding("UTF-8"); // 요청 인코딩을 UTF-8로 설정
StaffMgr staffMgr = new StaffMgr(); // StaffMgr 객체 생성
// 각 카테고리에 해당하는 스태프 리스트를 가져옴
ArrayList<StaffBean> sportsScientistList = staffMgr.getStaffByCategory("스포츠 사이언티스트", teamcode); 
ArrayList<StaffBean> trainerList = staffMgr.getStaffByCategory("트레이너", teamcode);
ArrayList<StaffBean> doctorList = staffMgr.getStaffByCategory("주치의", teamcode);
ArrayList<StaffBean> equipmentManagerList = staffMgr.getStaffByCategory("장비관리사", teamcode);
ArrayList<StaffBean> Interpreterlist = staffMgr.getStaffByCategory("통역관", teamcode);
ArrayList<StaffBean> PaoList = staffMgr.getStaffByCategory("전력분석관", teamcode);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> <!-- 문서 인코딩을 UTF-8로 설정 -->
<link href="../css/staffInfo.css" rel="stylesheet" type="text/css"> <!-- CSS 파일 포함 -->
<script type="text/javascript" src="../js/staff.js"></script> <!-- JavaScript 파일 포함 -->
<title>스태프정보</title> <!-- 페이지 제목 설정 -->
</head>

<body>
<%@ include file="member_bar.jsp"%> <!-- 상단 메뉴 포함 -->
<div class="container">
    <div class="top-section">
        <input type="button" class="staffadd" value="스태프 추가" onclick="window.open('addstaffinsert.jsp', '_blank', 'width=600,height=800');"> <!-- 스태프 추가 버튼 -->
        <h3>스포츠 사이언티스트</h3>
        <div class="profile-grid">
            <% for (StaffBean staff : sportsScientistList) { %> <!-- 스포츠 사이언티스트 리스트 출력 -->
                <div class="profile-card">
                    <div class="profile-image"></div> <!-- 프로필 이미지 공간 -->
                    <div class="profile-info">
                        <pre>스태프 코드: <%= staff.getCode() %></pre> <!-- 스태프 코드 출력 -->
                        <p>이름: <%= staff.getName() %></p> <!-- 스태프 이름 출력 -->
                        <p>국적: <%= staff.getNation() %></p> <!-- 스태프 국적 출력 -->
                        <p>입단일: <%= staff.getIbdan() %></p> <!-- 스태프 입단일 출력 -->
                        <div class="button-container">
                            <input type="button" class="staffbtn" value="수정" onclick="window.open('addstaffupdate.jsp?code=<%=staff.getCode() %>', '', 'width=600, height=800')"> <!-- 수정 버튼 -->
                            <input type="button" class="staffbtn" value="삭제" onclick="window.open('addstaffdelete.jsp?code=<%=staff.getCode()%>', '', 'width=700, height=500')"> <!-- 삭제 버튼 -->
                            <input type="hidden" name="code" value="<%=staff.getCode()%>"> <!-- 스태프 코드 히든 필드 -->
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    </div>
    
    <br><br><br>
    
    <div class="bottom-section">
        <h3>트레이너</h3>
        <div class="profile-grid">
            <% for (StaffBean staff : trainerList) { %> <!-- 트레이너 리스트 출력 -->
                <div class="profile-card">
                    <div class="profile-image"></div> <!-- 프로필 이미지 공간 -->
                    <div class="profile-info">
                        <pre>스태프 코드: <%= staff.getCode() %></pre> <!-- 스태프 코드 출력 -->
                        <p>이름: <%= staff.getName() %></p> <!-- 스태프 이름 출력 -->
                        <p>국적: <%= staff.getNation() %></p> <!-- 스태프 국적 출력 -->
                        <p>입단일: <%= staff.getIbdan() %></p> <!-- 스태프 입단일 출력 -->
                        <div class="button-container">
                            <input type="button" class="staffbtn" value="수정" onclick="window.open('addstaffupdate.jsp?code=<%=staff.getCode() %>', '', 'width=600, height=800')"> <!-- 수정 버튼 -->
                            <input type="button" class="staffbtn" value="삭제" onclick="javascript:staffDeleteData('<%=staff.getCode()%>')"> <!-- 삭제 버튼 -->
                            <input type="hidden" name="code" value="<%=staff.getCode()%>"> <!-- 스태프 코드 히든 필드 -->
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    </div>
    
    <br><br><br>
    
    <div class="bottom-section">
        <h3>주치의</h3>
        <div class="profile-grid">
            <% for (StaffBean staff : doctorList) { %> <!-- 주치의 리스트 출력 -->
                <div class="profile-card">
                    <div class="profile-image"></div> <!-- 프로필 이미지 공간 -->
                    <div class="profile-info">
                        <pre>스태프 코드: <%= staff.getCode() %></pre> <!-- 스태프 코드 출력 -->
                        <p>이름: <%= staff.getName() %></p> <!-- 스태프 이름 출력 -->
                        <p>국적: <%= staff.getNation() %></p> <!-- 스태프 국적 출력 -->
                        <p>입단일: <%= staff.getIbdan() %></p> <!-- 스태프 입단일 출력 -->
                        <div class="button-container">
                            <input type="button" class="staffbtn" value="수정" onclick="window.open('addstaffupdate.jsp?code=<%=staff.getCode() %>', '', 'width=600, height=800')"> <!-- 수정 버튼 -->
                            <input type="button" class="staffbtn" value="삭제" onclick="javascript:staffDeleteData('<%=staff.getCode()%>')"> <!-- 삭제 버튼 -->
                            <input type="hidden" name="code" value="<%=staff.getCode()%>"> <!-- 스태프 코드 히든 필드 -->
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    </div>
    
    <br><br><br>
    
    <div class="bottom-section">
        <h3>장비관리사</h3>
        <div class="profile-grid">
            <% for (StaffBean staff : equipmentManagerList) { %> <!-- 장비관리사 리스트 출력 -->
                <div class="profile-card">
                    <div class="profile-image"></div> <!-- 프로필 이미지 공간 -->
                    <div class="profile-info">
                        <pre>스태프 코드: <%= staff.getCode() %></pre> <!-- 스태프 코드 출력 -->
                        <p>이름: <%= staff.getName() %></p> <!-- 스태프 이름 출력 -->
                        <p>국적: <%= staff.getNation() %></p> <!-- 스태프 국적 출력 -->
                        <p>입단일: <%= staff.getIbdan() %></p> <!-- 스태프 입단일 출력 -->
                        <div class="button-container">
                            <input type="button" class="staffbtn" value="수정" onclick="window.open('addstaffupdate.jsp?code=<%=staff.getCode() %>', '', 'width=600, height=800')"> <!-- 수정 버튼 -->
                            <input type="button" class="staffbtn" value="삭제" onclick="javascript:staffDeleteData('<%=staff.getCode()%>')"> <!-- 삭제 버튼 -->
                            <input type="hidden" name="code" value="<%=staff.getCode()%>"> <!-- 스태프 코드 히든 필드 -->
                        </div>
                    </div>
                </div>
            <% } %> 
        </div>
    </div>
    
    <br><br><br>
    
    <div class="bottom-section">
        <h3>통역관</h3>
        <div class="profile-grid">
            <% for (StaffBean staff : Interpreterlist) { %> <!-- 통역관 리스트 출력 -->
                <div class="profile-card">
                    <div class="profile-image"></div> <!-- 프로필 이미지 공간 -->
                    <div class="profile-info">
                        <pre>스태프 코드: <%= staff.getCode() %></pre> <!-- 스태프 코드 출력 -->
                        <p>이름: <%= staff.getName() %></p> <!-- 스태프 이름 출력 -->
                        <p>국적: <%= staff.getNation() %></p> <!-- 스태프 국적 출력 -->
                        <p>입단일: <%= staff.getIbdan() %></p> <!-- 스태프 입단일 출력 -->
                        <div class="button-container">
                            <input type="button" class="staffbtn" value="수정" onclick="window.open('addstaffupdate.jsp?code=<%=staff.getCode() %>', '', 'width=600, height=800')"> <!-- 수정 버튼 -->
                            <input type="button" class="staffbtn" value="삭제" onclick="javascript:staffDeleteData('<%=staff.getCode()%>')"> <!-- 삭제 버튼 -->
                            <input type="hidden" name="code" value="<%=staff.getCode()%>"> <!-- 스태프 코드 히든 필드 -->
                        </div>
                    </div>
                </div>
            <% } %> 
        </div>
    </div>
    
    <br><br><br>
    
    <div class="bottom-section">
        <h3>전력분석관</h3>
        <div class="profile-grid">
            <% for (StaffBean staff : PaoList) { %> <!-- 전력분석관 리스트 출력 -->
                <div class="profile-card">
                    <div class="profile-image"></div> <!-- 프로필 이미지 공간 -->
                    <div class="profile-info">
                        <pre>스태프 코드: <%= staff.getCode() %></pre> <!-- 스태프 코드 출력 -->
                        <p>이름: <%= staff.getName() %></p> <!-- 스태프 이름 출력 -->
                        <p>국적: <%= staff.getNation() %></p> <!-- 스태프 국적 출력 -->
                        <p>입단일: <%= staff.getIbdan() %></p> <!-- 스태프 입단일 출력 -->
                        <div class="button-container">
                            <input type="button" class="staffbtn" value="수정" onclick="window.open('addstaffupdate.jsp?code=<%=staff.getCode() %>', '', 'width=600, height=800')"> <!-- 수정 버튼 -->
                            <input type="button" class="staffbtn" value="삭제" onclick="javascript:staffDeleteData('<%=staff.getCode()%>')"> <!-- 삭제 버튼 -->
                            <input type="hidden" name="code" value="<%=staff.getCode()%>"> <!-- 스태프 코드 히든 필드 -->
                        </div>
                    </div>
                </div>
            <% } %> 
        </div>
    </div>
    
    <br><br><br>
    
    <form action="addstaffproc.jsp" name="deleteForm" method="post"> <!-- 삭제 폼 -->
        <input type="hidden" name="code"> <!-- 스태프 코드 히든 필드 -->
        <input type="hidden" name="flag"> <!-- 플래그 히든 필드 -->
    </form>
</div>
</body>
</html>
