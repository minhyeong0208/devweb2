<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pack.coach.CoachMgr"%>
<%@ page import="pack.coach.CoachBean"%>
<%@ include file="sessioncheck.jsp"%>
<%
    request.setCharacterEncoding("UTF-8");
    String action = request.getParameter("action");
    boolean isAdd = "add".equals(action);
    boolean isSuccess = false;
    String errorMessage = "";

    if (isAdd) {
        try {
            String coachTeamcode = request.getParameter("coachTeamcode");
            String coachName = request.getParameter("coachName");
            String coachPos = request.getParameter("coachPos");
            String coachLic = request.getParameter("coachLic");
            String coachIbdan = request.getParameter("coachIbdan");

            CoachMgr coachMgr = new CoachMgr();
            if (coachMgr.isCoachNameDuplicate(coachName, teamcode)) {
                errorMessage = "이름이 중복되었습니다.";
            } else {
                CoachBean coach = new CoachBean();
                coach.setTeamcode(coachTeamcode);
                coach.setName(coachName);
                coach.setPos(coachPos);
                coach.setLic(coachLic);
                coach.setIbdan(coachIbdan);

                isSuccess = coachMgr.addCoach(coach);
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
<title>코치 추가</title>
<link href="../css/coachInfo.css" rel="stylesheet" type="text/css">
<script src="../js/coach.js"></script>
<script>
<script>
function closeWindow() {
    window.opener.location.reload();
    window.close();
}
</script>
</head>
<body class="coach-add-page">
<%
    if (isAdd && isSuccess) {
%>
	<div class="coach-container">
	<div class="success-message">
    	<p>선수 추가가 완료되었습니다.</p>
    </div>
    <div class="button-container">
    	<button class="coach-add-btn" onclick="closeWindow()">닫기</button>
	</div>
<%
    } else {
%>
<div class="coach-add-container">
    <form id="addForm" action="coachadd.jsp" method="post" onsubmit="return submitAddForm()">
    <h1>코치 추가</h1>
        <input type="hidden" name="action" value="add">
        <label for="coachTeamcode">팀 코드:</label>
        <input type="text" name="coachTeamcode" id="coachTeamcode"><br>
        <label for="coachName">이름:</label>
        <input type="text" name="coachName" id="coachName" value="<%= request.getParameter("coachName") == null ? "" : request.getParameter("coachName") %>"><br>
        <label for="coachPos">포지션:</label>
       
        <select name="coachPos" id="coachPos">
            <option value="">선택하세요</option>
            <option value="감독">감독</option>
            <option value="코치">코치</option>
            <option value="트레이너">트레이너</option>
            <option value="주치의">주치의</option>
            <option value="장비관리사">장비관리사</option>
            <option value="스포츠사이언티스트">스포츠사이언티스트</option>
        </select><br>
        
        <label for="coachLic">라이선스:</label>
        <input type="text" name="coachLic" id="coachLic" value="<%= request.getParameter("coachLic") == null ? "" : request.getParameter("coachLic") %>"><br>
        <label for="coachIbdan">입단 날짜:</label>
        <input type="date" name="coachIbdan" id="coachIbdan" value="<%= request.getParameter("coachIbdan") == null ? "" : request.getParameter("coachIbdan") %>"><br>
        
        <div class="button-container">
            <button class="coach-add-btn" type="submit">추가</button>
            <button class="coach-add-btn delete" type="button" onclick="window.close()">취소</button>
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
