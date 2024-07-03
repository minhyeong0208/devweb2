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
    boolean isEdit = "edit".equals(action);
    boolean isSuccess = false;
    String errorMessage = "";

    InjuryMgr injuryMgr = new InjuryMgr();
    InjuryBean injury = null;

    if (isEdit) {
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
                injury = new InjuryBean();
                injury.setBn(injuryBn);
                injury.setPart(injuryPart);
                injury.setState(injuryState);
                injury.setDate(injuryDate);
                injury.setDoctor(injuryDoctor);

                isSuccess = injuryMgr.updateInjury(injury);
            }
        } catch (Exception e) {
            errorMessage = e.getMessage();
        }
    } else {
        try {
            int injuryBn = Integer.parseInt(request.getParameter("injury_bn"));
            injury = injuryMgr.getInjuryByBn(injuryBn, teamcode);
            if (injury == null) {
                errorMessage = "해당 선수의 부상 정보를 찾을 수 없습니다.";
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
<title>부상 선수 수정</title>
<link href="../css/staff_injury.css" rel="stylesheet" type="text/css">
<script src="../js/injury.js"></script>
</head>
<body class="injury-add-page">
<%
    if (isEdit && isSuccess) {
%>
    <div class="staff-container">
        <div class="success-message">
   			<p>부상 선수 정보 수정이 완료되었습니다.</p>
        </div>
        <div class="button-container">
            <button class="injury-add-btn" onclick="closeWindow()">닫기</button>
        </div>
    </div>
<%
    } else if (injury != null) {
%>
<div class="injury-container">
    <div class="injury-add-container">
	    <form id="editForm">
	        <input type="hidden" name="action" value="edit">
	        <input type="hidden" name="injury_bn" value="<%= injury.getBn() %>">
	        <label for="injury_part">부상 부위:</label>
	        <input type="text" name="injury_part" id="injury_part" value="<%= injury.getPart() %>"><br>
	        <label for="injury_state">부상 상태:</label>
	        <input type="text" name="injury_state" id="injury_state" value="<%= injury.getState() %>"><br>
	        <label for="injury_date">부상 날짜:</label>
	        <input type="date" name="injury_date" id="injury_date" value="<%= injury.getDate() %>"><br>
	        <label for="injury_doctor">주치의:</label>
	        <input type="text" name="injury_doctor" id="injury_doctor" value="<%= injury.getDoctor() %>"><br>
			<div class="button-container">
                <input type="button" class="injury-add-btn" value="수정완료" onclick="submitEditForm()">
                <input type="reset" class="injury-add-btn" value="수정취소" onclick="window.close()">
            </div>	       

	    </form>
	</div>
</div>
<%
    } else {
%>
<div>
    <p><%= errorMessage %></p>
    <button onclick="window.close()">닫기</button>
</div>
<%
    }
%>
<%
    if (!errorMessage.isEmpty()) {
%>
<script>
    alert("<%= errorMessage %>");
    history.back();  // 입력 폼으로 돌아가기
</script>
<%
    }
%>
</body>
</html>
