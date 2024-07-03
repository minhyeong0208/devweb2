<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pack.injury.InjuryMgr"%>
<%@ page import="pack.injury.InjuryBean"%>
<%@ page import="pack.player.PlayerMgr"%>
<%@ page import="pack.player.PlayerBean"%>
<%@ page import="java.util.ArrayList"%>
<%@ include file="sessioncheck.jsp"%>
<%
    request.setCharacterEncoding("UTF-8");
    String action = request.getParameter("action");
    boolean isAdd = "add".equals(action);
    boolean isSuccess = false;
    String errorMessage = "";

    if (isAdd) {
        try {
            int injuryBn = Integer.parseInt(request.getParameter("injury_bn"));
            String injuryPart = request.getParameter("injury_part");
            String injuryState = request.getParameter("injury_state");
            String injuryDate = request.getParameter("injury_date");
            String injuryDoctor = request.getParameter("injury_doctor");

            if (injuryPart == null || injuryPart.trim().isEmpty()) {
                errorMessage = "부상 부위를 입력해주세요.";
            } else if (injuryState == null || injuryState.trim().isEmpty()) {
                errorMessage = "부상 상태를 입력해주세요.";
            } else if (injuryDate == null || injuryDate.trim().isEmpty()) {
                errorMessage = "부상 날짜를 입력해주세요.";
            } else if (injuryDoctor == null || injuryDoctor.trim().isEmpty()) {
                errorMessage = "주치의를 입력해주세요.";
            } else {
                InjuryMgr injuryMgr = new InjuryMgr();
                if (injuryMgr.isInjuryExist(injuryBn, teamcode)) {
                    errorMessage = "이미 추가되어있는 선수입니다.";
                } else {
                    InjuryBean injury = new InjuryBean();
                    injury.setBn(injuryBn);
                    injury.setPart(injuryPart);
                    injury.setState(injuryState);
                    injury.setDate(injuryDate);
                    injury.setDoctor(injuryDoctor);

                    isSuccess = injuryMgr.addInjury(injury);
                }
            }
        } catch (Exception e) {
            errorMessage = e.getMessage();
        }
    }

    PlayerMgr playerMgr = new PlayerMgr();
    ArrayList<PlayerBean> playerList = playerMgr.getAllPlayers(teamcode);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부상 선수 추가</title>
<link href="../css/staff_injury.css" rel="stylesheet" type="text/css">
<script src="../js/injury.js"></script>
</head>
<body class="injury-add-page">
<%
    if (isAdd && isSuccess) {
%>
    <div class="injury-container">
        <div class="success-message">
        	<p>부상 선수 추가가 완료되었습니다.</p>
        </div>
        <div class="button-container">
            <button class="injury-add-btn" onclick="closeWindow()">닫기</button>
        </div>
    </div>
<%
    } else {
%>
<div class="injury-container">
	<div class="injury-add-container">
	    <form id="addForm">
	        <input type="hidden" name="action" value="add">
	        <h1>부상 선수 추가</h1>
	        <label for="injury_bn">선수 번호:</label>
	        <select name="injury_bn" id="injury_bn">
	            <% for (PlayerBean player : playerList) { %>
	                <option value="<%= player.getBn() %>"><%= player.getBn() %> - <%= player.getName() %></option>
	            <% } %>
	        </select><br>
	        <label for="injury_part">부상 부위:</label>
	        <input type="text" name="injury_part" id="injury_part" value="<%= request.getParameter("injury_part") == null ? "" : request.getParameter("injury_part") %>"><br>
	        <label for="injury_state">부상 상태:</label>
	        <input type="text" name="injury_state" id="injury_state" value="<%= request.getParameter("injury_state") == null ? "" : request.getParameter("injury_state") %>"><br>
	        <label for="injury_date">부상 날짜:</label>
	        <input type="date" name="injury_date" id="injury_date" value="<%= request.getParameter("injury_date") == null ? "" : request.getParameter("injury_date") %>"><br>
	        <label for="injury_doctor">주치의:</label>
	        <input type="text" name="injury_doctor" id="injury_doctor" value="<%= request.getParameter("injury_doctor") == null ? "" : request.getParameter("injury_doctor") %>"><br>
			<div class="button-container">
	            <input type="button" class="injury-add-btn" value="추가" onclick="addInjury()">
	            <input type="reset" class="injury-add-btn" value="취소" onclick="window.close()"> 
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
