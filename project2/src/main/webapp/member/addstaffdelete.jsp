<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pack.staff.StaffMgr"%>
<%@ page import="pack.staff.StaffBean"%>
<%@ page import="java.io.IOException"%>

<%
    request.setCharacterEncoding("UTF-8");
    String action = request.getParameter("action");
    String code = request.getParameter("code");
    boolean isConfirm = "confirm".equals(action) && code != null;

    boolean isDeleted = false;

    if (isConfirm) {
        int staffCode = Integer.parseInt(code);
        StaffMgr staffMgr = new StaffMgr();
        isDeleted = staffMgr.staffDelete(staffCode);
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="../js/staff.js"></script>
<title><%= isConfirm ? "삭제 완료" : "스태프 삭제" %></title>
<link href="../css/staffInfo.css" rel="stylesheet" type="text/css">
<script>
function closeWindow() {
    window.opener.location.reload();
    window.close();
}
function confirmDelete() {
    document.getElementById('deleteForm').submit();
}
</script>
</head>
<body class="staff-add-page">
<%
    if (isConfirm && isDeleted) {
%>
<div class="staff-container">
    <p>삭제가 완료되었습니다.</p>
    <div class="button-container">
        <button class="staff-add-btn" onclick="closeWindow()">닫기</button>
    </div>
</div>
<%
    } else if (code != null) {
%>
<div class="staff-container">
	<div class="staff-add-container">
	    <form id="deleteForm" action="addstaffdelete.jsp" method="post">
	        <p>정말 삭제하시겠습니까?</p>
	        <input type="hidden" name="action" value="confirm">
	        <input type="hidden" name="code" value="<%= code %>">
	        <div class="button-container">
	            <button class="staff-add-btn delete" type="button" onclick="confirmDelete()">삭제</button>
	            <button class="staff-add-btn" type="button" onclick="window.close()">취소</button>
	        </div>
	    </form>
	</div>
</div>
<%
    } else {
%>
<div class="staff-add-container">
    <p>잘못된 접근입니다.</p>
    <div class="button-container">
        <button class="staff-delete-btn" onclick="closeWindow()">닫기</button>
    </div>
</div>
<%
    }
%>
</body>
</html>
