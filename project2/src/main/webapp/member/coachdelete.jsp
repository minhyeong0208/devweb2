<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pack.coach.CoachMgr"%>
<%@ page import="java.io.IOException"%>

<%
    request.setCharacterEncoding("UTF-8");
    String action = request.getParameter("action");
    String code = request.getParameter("code");
    boolean isConfirm = "confirm".equals(action) && code != null;

    if (isConfirm) {
        int coachCode = Integer.parseInt(code);
        CoachMgr coachMgr = new CoachMgr();
        coachMgr.coachDelete(coachCode);
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="../js/coach.js"></script>
<title><%= isConfirm ? "삭제 완료" : "코치 삭제" %></title>
<link href="../css/player_coach.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function confirmDelete() {
    var form = document.getElementById('deleteForm');
    form.submit();
}
</script>
</head>
<body class="delete-page">
<%
    if (isConfirm) {
%>
<div class="container-common">
    <div class="success-message">
   		<p>삭제가 완료되었습니다.</p>
    </div>
    <div class="button-container">
        <button class="button-common" onclick="closeWindow()">닫기</button>
    </div>
</div>
<%
    } else if (code != null) {
%>
<div class="container-common">
    <form id="deleteForm" action="coachdelete.jsp" method="post">
        <p>정말 삭제하시겠습니까?</p>
        <input type="hidden" name="action" value="confirm">
        <input type="hidden" name="code" value="<%= code %>">
        <div class="button-container">
            <button class="button-common delete" type="button" onclick="confirmDelete()">삭제</button>
            <button class="button-common" type="button" onclick="window.close()">취소</button>
        </div>
    </form>
</div>
<%
    }
%>
</body>
</html>
