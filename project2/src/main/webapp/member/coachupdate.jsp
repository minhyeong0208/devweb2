<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pack.coach.CoachMgr"%>
<%@ page import="pack.coach.CoachBean"%>
<%@ page import="java.util.ArrayList"%>
<%@ include file="sessioncheck.jsp"%>
<%
    CoachMgr coachMgr = new CoachMgr();
    request.setCharacterEncoding("UTF-8");

    String action = request.getParameter("action");
    boolean isEdit = "edit".equals(action);
    CoachBean coach = null;
    String errorMsg = "";
    boolean isUpdated = false;

    if (!isEdit) {
        int code = Integer.parseInt(request.getParameter("code"));
        coach = coachMgr.getByCoachCode(code, teamcode);
    } else {
        int originalCode = Integer.parseInt(request.getParameter("originalCode"));
        String name = request.getParameter("name");
        teamcode = request.getParameter("teamcode");
        String pos = request.getParameter("pos");
        String lic = request.getParameter("lic");
        String ibdan = request.getParameter("ibdan");

        coach = new CoachBean();
        coach.setCode(originalCode);
        coach.setName(name);
        coach.setTeamcode(teamcode);
        coach.setPos(pos);
        coach.setLic(lic);
        coach.setIbdan(ibdan);

        if (name.isEmpty()) {
            errorMsg = "이름을 입력해주세요.";
        } else if (teamcode.isEmpty()) {
            errorMsg = "팀 코드를 입력해주세요.";
        } else if (pos.isEmpty()) {
            errorMsg = "포지션을 선택해주세요.";
        } else if (lic.isEmpty()) {
            errorMsg = "라이센스를 입력해주세요.";
        } else if (ibdan.isEmpty()) {
            errorMsg = "입단일을 입력해주세요.";
        } else {
            CoachBean existingCoach = coachMgr.getByCoachCode(originalCode, teamcode);
            if (!name.equals(existingCoach.getName()) && coachMgr.isNameDuplicate(name, teamcode)) {
                errorMsg = "중복된 이름입니다.";
            } else {
                boolean updated = coachMgr.coachUpdate(coach);

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
<title><%= isUpdated ? "수정 완료" : "코치 수정" %></title>
<link href="../css/player_coach.css" rel="stylesheet" type="text/css">
<script src="../js/coach.js"></script>
<script>
function closeWindow() {
    window.opener.location.reload();
    window.close();
}
function submitEditForm() {
    var form = document.getElementById('editForm');
    var errorMsg = "";

    var name = form.name.value.trim();
    var teamcode = form.teamcode.value.trim();
    var pos = form.pos.value.trim();
    var lic = form.lic.value.trim();
    var ibdan = form.ibdan.value.trim();

    if (!name) {
        errorMsg = "이름을 입력해주세요.";
    } else if (!teamcode) {
        errorMsg = "팀 코드를 입력해주세요.";
    } else if (!pos) {
        errorMsg = "포지션을 선택해주세요.";
    } else if (!lic) {
        errorMsg = "라이센스를 입력해주세요.";
    } else if (!ibdan) {
        errorMsg = "입단일을 입력해주세요.";
    }

    if (errorMsg) {
        alert(errorMsg);
    } else {
        form.submit();
    }
}
</script>
</head>
<body class="update-page">
<%
    if (isUpdated) {
%>
		<div class="container-common">
        <div class="success-message">
            <p>데이터가 성공적으로 수정되었습니다.</p>
        </div>
       <div class="button-container">
            <input type="button" class="button-common" value="닫기" onclick="closeWindow()">
        </div>
<%
    } else {
%>
<div class="container-common">
    <form id="editForm" action="coachupdate.jsp" method="post">
    <h1>코치 수정</h1>
        <input type="hidden" name="action" value="edit">
        <input type="hidden" name="originalCode" value="<%= coach != null ? coach.getCode() : "" %>">
        <label for="name">이름</label>
        <input type="text" name="name" id="name" value="<%= coach != null ? coach.getName() : "" %>"><br>
        <label for="teamcode">팀 코드</label>
        <input type="text" name="teamcode" id="teamcode" value="<%= coach != null ? coach.getTeamcode() : "" %>"><br>
        <label for="pos">포지션</label>
        <select name="pos" id="pos">
            <option value="">-- 선택 --</option>
            <option value="감독" <%= coach != null && "감독".equals(coach.getPos()) ? "selected" : "" %>>감독</option>
            <option value="코치" <%= coach != null && ("코치".equals(coach.getPos()) || "수석코치".equals(coach.getPos()) || "GK코치".equals(coach.getPos()) || "피지컬코치".equals(coach.getPos()) || "비디오코치".equals(coach.getPos())) ? "selected" : "" %>>코치</option>
            <option value="트레이너" <%= coach != null && "트레이너".equals(coach.getPos()) ? "selected" : "" %>>트레이너</option>
            <option value="주치의" <%= coach != null && "주치의".equals(coach.getPos()) ? "selected" : "" %>>주치의</option>
            <option value="장비관리사" <%= coach != null && "장비관리사".equals(coach.getPos()) ? "selected" : "" %>>장비관리사</option>
            <option value="스포츠사이언티스트" <%= coach != null && "스포츠사이언티스트".equals(coach.getPos()) ? "selected" : "" %>>스포츠사이언티스트</option>
        </select><br>
        <label for="lic">라이센스</label>
        <input type="text" name="lic" id="lic" value="<%= coach != null ? coach.getLic() : "" %>"><br>
        <label for="ibdan">입단일</label>
        <input type="date" name="ibdan" id="ibdan" value="<%= coach != null ? coach.getIbdan() : "" %>"><br>
        <div class="button-container">
            <button class="button-common" type="submit">저장</button>
            <button class="button-common delete" type="button" onclick="window.close()">취소</button>
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