<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pack.player.PlayerMgr"%>
<%@ page import="pack.player.PlayerBean"%>
<%@ page import="java.util.ArrayList"%>
<%@ include file="sessioncheck.jsp"%>
<%
    PlayerMgr playerMgr = new PlayerMgr();
    request.setCharacterEncoding("UTF-8");

    String action = request.getParameter("action");
    boolean isEdit = "edit".equals(action);
    PlayerBean player = null;
    String errorMsg = "";
    boolean isUpdated = false;

    if (!isEdit) {
        int bn = Integer.parseInt(request.getParameter("bn"));
        ArrayList<PlayerBean> players = playerMgr.getAllPlayers(teamcode);  
        for (PlayerBean p : players) {
            if (p.getBn() == bn) {
                player = p;
                break;
            }
        }
    } else {
        int originalBn = Integer.parseInt(request.getParameter("originalBn"));
        int bn = Integer.parseInt(request.getParameter("bn"));
        String name = request.getParameter("name");
        String birth = request.getParameter("birth");
	    String nation = request.getParameter("nation");
	    teamcode = request.getParameter("teamcode");
        String pos = request.getParameter("pos");
        String pot = request.getParameter("pot");
        String cts = request.getParameter("cts");
        String cte = request.getParameter("cte");
        String deb = request.getParameter("deb");

        player = new PlayerBean();
        player.setBn(bn);
        player.setName(name);
        player.setBirth(birth);
        player.setNation(nation);
        player.setTeamcode(teamcode);
        player.setPos(pos);
        player.setPot(pot);
        player.setCts(cts);
        player.setCte(cte);
        player.setDeb(deb);

        if (name.isEmpty()) {
            errorMsg = "이름을 입력해주세요.";
        } else if (birth.isEmpty()) {
            errorMsg = "생년월일을 입력해주세요.";
        } else if (nation.isEmpty()) {
            errorMsg = "국가를 입력해주세요.";
        } else if (teamcode.isEmpty()) {
            errorMsg = "팀 코드를 입력해주세요.";
        } else if (pos.isEmpty()) {
            errorMsg = "포지션을 선택해주세요.";
        } else if (cts.isEmpty()) {
            errorMsg = "계약 시작일을 입력해주세요.";
        } else if (cte.isEmpty()) {
            errorMsg = "계약 종료일을 입력해주세요.";
        } else if (deb.isEmpty()) {
            errorMsg = "데뷔일을 입력해주세요.";
        } else if (playerMgr.isBnDuplicate(bn, teamcode) && originalBn != bn) {
            errorMsg = "중복된 등번호입니다.";
        } else {
            PlayerBean existingPlayer = playerMgr.getPlayerByBn(originalBn, teamcode);
            if (!name.equals(existingPlayer.getName()) && playerMgr.isNameDuplicate(name, teamcode)) {
                errorMsg = "중복된 이름입니다.";
            } else {
                boolean updated = playerMgr.updatePlayer(player);

                if (updated) {
                    isUpdated = true;
                } else {
                    errorMsg = "데이터 수정에 실패했습니다.";
                }
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= isUpdated ? "수정 완료" : "선수 수정" %></title>
<link href="../css/coachInfo.css" rel="stylesheet" type="text/css">
<link href="../css/playerUpdate.css" rel="stylesheet" type="text/css">
<script src="../js/player.js"></script>
</head>
<body class="player-update-page">
<%
    if (isUpdated) {
%>
	<div class="coach-container">
	<div class="success-message">
    	<p>데이터가 성공적으로 수정되었습니다.</p>
   	</div>
   	<div class="button-container">
   		<button class="player-update-btn" onclick="closeWindow()">닫기</button>
	</div>
<%
    } else {
%>
<div class="player-update-container">
    <form id="editForm" action="playerupdate.jsp" method="post">
    <h1>선수 수정</h1>
        <input type="hidden" name="action" value="edit">
        <input type="hidden" name="originalBn" value="<%= player != null ? player.getBn() : "" %>">
        <label for="bn">등번호</label>
        <input type="number" name="bn" id="bn" value="<%= player != null ? player.getBn() : "" %>"><br>
        <label for="name">이름</label>
        <input type="text" name="name" id="name" value="<%= player != null ? player.getName() : "" %>"><br>
        <label for="birth">생년월일</label>
        <input type="date" name="birth" id="birth" value="<%= player != null ? player.getBirth() : "" %>"><br>
        <label for="nation">국가</label>
        <input type="text" name="nation" id="nation" value="<%= player != null ? player.getNation() : "" %>"><br>
        <label for="teamcode">팀 코드</label>
        <input type="text" name="teamcode" id="teamcode" value="<%= player != null ? player.getTeamcode() : "" %>"><br>
        <label for="pos">포지션</label>
        <select name="pos" id="pos">
            <option value="">-- 선택 --</option>
            <option value="GK" <%= player != null && "GK".equals(player.getPos()) ? "selected" : "" %>>GK</option>
            <option value="DF" <%= player != null && "DF".equals(player.getPos()) ? "selected" : "" %>>DF</option>
            <option value="MF" <%= player != null && "MF".equals(player.getPos()) ? "selected" : "" %>>MF</option>
            <option value="FW" <%= player != null && "FW".equals(player.getPos()) ? "selected" : "" %>>FW</option>
        </select><br>
        <label for="pot">잠재력</label>
        <input type="text" name="pot" id="pot" value="<%= player != null ? player.getPot() : "" %>"><br>
        <label for="cts">계약 시작일</label>
        <input type="date" name="cts" id="cts" value="<%= player != null ? player.getCts() : "" %>"><br>
        <label for="cte">계약 종료일</label>
        <input type="date" name="cte" id="cte" value="<%= player != null ? player.getCte() : "" %>"><br>
        <label for="deb">데뷔일</label>
        <input type="date" name="deb" id="deb" value="<%= player != null ? player.getDeb() : "" %>"><br>
        <div class="button-container">
            <button class="player-update-btn" type="submit">저장</button>
            <button class="player-update-btn delete" type="button" onclick="window.close()">취소</button>
        </div>
    </form>
    <% if (!errorMsg.isEmpty()) { %>
    <p style="color:red;"><%= errorMsg %></p>
    <% } %>
</div>
<%
    }
%>
</div>
</body>
</html>
