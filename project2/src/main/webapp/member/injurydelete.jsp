<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pack.injury.InjuryMgr"%>
<%@ include file="sessioncheck.jsp"%>
<%
    request.setCharacterEncoding("UTF-8");
    String action = request.getParameter("action");
    boolean isDelete = "delete".equals(action);
    boolean isSuccess = false;
    String errorMessage = "";

    if (isDelete) {
        try {
            int injuryBn = Integer.parseInt(request.getParameter("injury_bn"));
            InjuryMgr injuryMgr = new InjuryMgr();
            isSuccess = injuryMgr.deleteInjury(injuryBn); 
        } catch (Exception e) {
            errorMessage = e.getMessage();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부상 선수 삭제</title>
<link href="../css/staff_injury.css" rel="stylesheet" type="text/css">
<script src="../js/injury.js"></script>
</head>
<body class="injury-add-page">
<%
    if (isDelete && isSuccess) {
%>
<div class="injury-container">
    <p>부상 선수 삭제가 완료되었습니다.</p>
    <div class="button-container">
        <input type="button" class="injury-add-btn" value="닫기" onclick="closeWindow()">
    </div>
</div>
<%
    } else {
        int injuryBn = Integer.parseInt(request.getParameter("injury_bn"));
%>
<div class="staff-container">
	<div class="staff-add-container">
	    <p>정말 삭제하시겠습니까?</p>
	    <form id="deleteForm">
	        <input type="hidden" name="action" value="delete">
	        <input type="hidden" name="injury_bn" value="<%= injuryBn %>">
	        <div class="button-container">
	            <input type="button" class="injury-add-btn delete" value="삭제" onclick="submitDeleteForm()">
	            <input type="button" class="injury-add-btn" value="취소" onclick="window.close()">
	        </div>
	    </form>
	</div>
</div>
<%
    }
%>
<%
    if (!errorMessage.isEmpty()) {
%>
<script>
    alert("<%= errorMessage %>");
</script>
<%
    }
%>
</body>
</html>
