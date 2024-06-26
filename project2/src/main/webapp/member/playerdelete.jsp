<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pack.player.PlayerMgr"%>
<%@ page import="java.io.IOException"%>

<%
    request.setCharacterEncoding("UTF-8");
    String action = request.getParameter("action");
    String bn = request.getParameter("bn");
    boolean isConfirm = "confirm".equals(action) && bn != null;

    if (isConfirm) {
        int playerBn = Integer.parseInt(bn);
        PlayerMgr playerMgr = new PlayerMgr();
        playerMgr.deletePlayer(playerBn);    
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= isConfirm ? "삭제 완료" : "선수 삭제" %></title>
<link href="../css/playerDelete.css" rel="stylesheet" type="text/css">
<link href="../css/coachInfo.css" rel="stylesheet" type="text/css">
<script>
function closeWindow() {
    window.opener.location.reload();
    window.close();
}
function confirmDelete() {
    var form = document.getElementById('deleteForm');
    form.submit();
}
</script>
</head>
<body class="player-delete-page">
<%
    if (isConfirm) {
%>
<div class="player-delete-container">
    <p>삭제가 완료되었습니다.</p>
    <div class="button-container">
        <button class="player-delete-btn" onclick="closeWindow()">닫기</button>
    </div>
</div>
<%
    } else if (bn != null) {
%>
<div class="player-delete-container">
    <form id="deleteForm" action="playerdelete.jsp" method="post">
        <p>정말 삭제하시겠습니까?</p>
        <input type="hidden" name="action" value="confirm">
        <input type="hidden" name="bn" value="<%= bn %>">
        <div class="button-container">
            <button class="player-delete-btn delete" type="button" onclick="confirmDelete()">삭제</button>
            <button class="player-delete-btn" type="button" onclick="window.close()">취소</button>
        </div>
    </form>
</div>
<%
    }
%>
</body>
</html>
