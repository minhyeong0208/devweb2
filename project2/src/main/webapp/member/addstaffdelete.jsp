<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <!-- 페이지 설정 -->
<%@ page import="pack.staff.StaffMgr"%> <!-- StaffMgr 임포트 -->
<%@ page import="pack.staff.StaffBean"%> <!-- StaffBean 임포트 -->
<%@ page import="java.io.IOException"%> <!-- IOException 임포트 -->

<%
    request.setCharacterEncoding("UTF-8"); // 요청 인코딩을 UTF-8로 설정
    String action = request.getParameter("action"); // action 파라미터를 가져옴
    String code = request.getParameter("code"); // code 파라미터를 가져옴
    boolean isConfirm = "confirm".equals(action) && code != null; // 삭제 확인 여부를 체크

    boolean isDeleted = false; // 삭제 여부를 나타내는 변수 초기화

    if (isConfirm) {
        int staffCode = Integer.parseInt(code); // code를 정수로 변환
        StaffMgr staffMgr = new StaffMgr(); // StaffMgr 객체 생성
        isDeleted = staffMgr.staffDelete(staffCode); // 스태프 삭제 수행
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> <!-- 문서 인코딩을 UTF-8로 설정 -->
<script src="../js/staff.js"></script> <!-- JavaScript 파일 포함 -->
<title><%= isConfirm ? "삭제 완료" : "스태프 삭제" %></title> <!-- 페이지 제목 설정 -->
<link href="../css/staff_injury.css" rel="stylesheet" type="text/css"> <!-- CSS 파일 포함 -->
<script>
function closeWindow() {
    window.opener.location.reload(); // 부모 창을 새로고침
    window.close(); // 현재 창 닫기
}
function confirmDelete() {
    document.getElementById('deleteForm').submit(); // 폼 제출
}
</script>
</head>
<body class="staff-add-page">
<%
    if (isConfirm && isDeleted) { // 삭제가 확인되고 완료된 경우
%>
<div class="staff-container">
    <p>삭제가 완료되었습니다.</p>
    <div class="button-container">
        <button class="staff-add-btn" onclick="closeWindow()">닫기</button> <!-- 닫기 버튼 -->
    </div>
</div>
<%
    } else if (code != null) { // 삭제를 확인하는 경우
%>
<div class="staff-container">
	<div class="staff-add-container">
	    <form id="deleteForm" action="addstaffdelete.jsp" method="post"> <!-- 삭제 확인 폼 -->
	        <p>정말 삭제하시겠습니까?</p>
	        <input type="hidden" name="action" value="confirm"> <!-- action 히든 필드 -->
	        <input type="hidden" name="code" value="<%= code %>"> <!-- code 히든 필드 -->
	        <div class="button-container">
	            <button class="staff-add-btn delete" type="button" onclick="confirmDelete()">삭제</button> <!-- 삭제 버튼 -->
	            <button class="staff-add-btn" type="button" onclick="window.close()">취소</button> <!-- 취소 버튼 -->
	        </div>
	    </form>
	</div>
</div>
<%
    } else { // 잘못된 접근인 경우
%>
<div class="staff-add-container">
    <p>잘못된 접근입니다.</p>
    <div class="button-container">
        <button class="staff-delete-btn" onclick="closeWindow()">닫기</button> <!-- 닫기 버튼 -->
    </div>
</div>
<%
    }
%>
</body>
</html>
