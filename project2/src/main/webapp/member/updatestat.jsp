<%@page import="pack.stat.StatDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="statMgr" class="pack.stat.StatMgr" />

<%
String code = request.getParameter("code");

StatDto dto = statMgr.getStat(code);
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>통계 데이터 수정</title>
<link href="../css/memstat_InsertUpdate.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/stat.js"></script>
<script type="text/javascript">
window.onload = () => {
	document.querySelector("#updateData").onclick = updateStatData;
	document.querySelector("#backStat").onclick = backStat;
}
</script>
</head>
<body>
    <div class="container">
        <h3>통계 데이터 수정</h3>
        <form name="updateStatFrm">
            <input type="hidden" name="flag">
            <label for="bn">등번호</label>
            <input type="text" name="bn" id="bn" value="<%=dto.getBn()%>">
            <label for="season">시즌</label>
            <input type="date" name="season" id="season" value="<%=dto.getSeason()%>">
            <label for="match">출전경기 수</label>
            <input type="text" name="match" id="match" value="<%=dto.getMatch()%>">
            <label for="goal">득점 수</label>
            <input type="text" name="goal" id="goal" value="<%=dto.getGoal()%>">
            <label for="as">도움 수</label>
            <input type="text" name="as" id="as" value="<%=dto.getAs()%>">
            <label for="yellow">경고 수</label>
            <input type="text" name="yellow" id="yellow" value="<%=dto.getYellow()%>">
            <label for="red">퇴장 수</label>
            <input type="text" name="red" id="red" value="<%=dto.getRed()%>">
            <input type="hidden" name="code" value="<%=dto.getCode()%>">
            <div class="button-container">
                <button type="button" id="updateData">데이터 수정</button>
                <button type="button" id="backStat">뒤로가기</button>
            </div>
        </form>
    </div>
</body>
</html>