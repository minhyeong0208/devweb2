<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pack.player.PlayerMgr"%>
<%@ page import="pack.player.PlayerBean"%>
<%@ include file="sessioncheck.jsp"%>
<%
    request.setCharacterEncoding("UTF-8");
    String action = request.getParameter("action");
    boolean isAdd = "add".equals(action);
    boolean isSuccess = false;
    String errorMessage = "";

    if (isAdd) {
        try {
            String position = request.getParameter("position");
            int bn = Integer.parseInt(request.getParameter("bn"));
            String name = request.getParameter("name");
            String birth = request.getParameter("birth");
            String nation = request.getParameter("nation");
            teamcode = request.getParameter("teamcode");
            String pot = request.getParameter("pot");
            String cts = request.getParameter("cts");
            String cte = request.getParameter("cte");
            String deb = request.getParameter("deb");

            PlayerMgr playerMgr = new PlayerMgr();
            if (bn < 1 || bn > 99) {
                errorMessage = "등번호는 1에서 99 사이여야 합니다.";
            } else if (playerMgr.isBnDuplicate(bn, teamcode)) {
                errorMessage = "등번호가 중복되었습니다.";
            } else if (playerMgr.isNameDuplicate(name, teamcode)) {
                errorMessage = "이름이 중복되었습니다.";
            } else {
                PlayerBean player = new PlayerBean();
                player.setPos(position);
                player.setBn(bn);
                player.setName(name);
                player.setBirth(birth);
                player.setNation(nation);
                player.setTeamcode(teamcode);
                player.setPot(pot);
                player.setCts(cts);
                player.setCte(cte);
                player.setDeb(deb);

                isSuccess = playerMgr.addPlayer(player); 
            }
        } catch (Exception e) {
            errorMessage = e.getMessage();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>선수 추가</title>
<link href="../css/coachInfo.css" rel="stylesheet" type="text/css">
<script src="../js/player.js"></script>
<script>
function closeWindow() {
    window.opener.location.reload();
    window.close();
}
</script>
</head>
<body class="player-add-page">
<%
    if (isAdd && isSuccess) {
%>
	<div class="player-container">
	<div class="success-message">
    	<p>선수 추가가 완료되었습니다.</p>
    </div>
    <div class="button-container">
   		<button class="player-add-btn" onclick="closeWindow()">닫기</button>
	</div>
<%
    } else {
%>
<div class="player-add-container">
    <form id="addForm" action="playeradd.jsp" method="post" onsubmit="return submitAddForm()">
    <h1>선수 추가</h1>
        <input type="hidden" name="action" value="add">
        
        <label for="position">포지션:</label>
        <select name="position" id="position">
            <option value="">선택하세요</option>
            <option value="GK">골키퍼(GK)</option>
            <option value="DF">수비수(DF)</option>
            <option value="MF">미드필더(MF)</option>
            <option value="FW">공격수(FW)</option>
        </select>
        
        <label for="bn">등번호:</label>
        <input type="number" name="bn" id="bn">
        
        <label for="name">이름:</label>
        <input type="text" name="name" id="name" value="<%= request.getParameter("name") == null ? "" : request.getParameter("name") %>">
        
        <label for="birth">생년월일:</label>
        <input type="date" name="birth" id="birth" value="<%= request.getParameter("birth") == null ? "" : request.getParameter("birth") %>">
        
        <label for="nation">국가:</label>
        <input type="text" name="nation" id="nation" value="<%= request.getParameter("nation") == null ? "" : request.getParameter("nation") %>">
        
        <label for="teamcode">팀 코드:</label>
        <input type="text" name="teamcode" id="teamcode" value="<%= request.getParameter("teamcode") == null ? "" : request.getParameter("teamcode") %>">
        
        <label for="pot">잠재력:</label>
        <input type="text" name="pot" id="pot" value="<%= request.getParameter("pot") == null ? "" : request.getParameter("pot") %>">
        
        <label for="cts">계약 시작일:</label>
        <input type="date" name="cts" id="cts" value="<%= request.getParameter("cts") == null ? "" : request.getParameter("cts") %>">
        
        <label for="cte">계약 종료일:</label>
        <input type="date" name="cte" id="cte" value="<%= request.getParameter("cte") == null ? "" : request.getParameter("cte") %>">
        
        <label for="deb">데뷔일:</label>
        <input type="date" name="deb" id="deb" value="<%= request.getParameter("deb") == null ? "" : request.getParameter("deb") %>">
        
        <div class="button-container">
            <button class="player-add-btn" type="submit">추가</button>
            <button class="player-add-btn delete" type="button" onclick="window.close()">취소</button>
        </div>
    </form>
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
</div>
</body>
</html>
