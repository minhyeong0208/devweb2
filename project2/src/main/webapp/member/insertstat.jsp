<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>통계 데이터 삽입</title>
<link href="../css/memstat_InsertUpdate.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/stat.js"></script>
<script type="text/javascript">
window.onload = () => {
	document.querySelector("#addData").onclick = addStatData;
	document.querySelector("#backStat").onclick = backStat;
}
</script>
</head>
<body>
    <div class="container">
        <h3>통계 데이터 추가</h3>
        <form name="insertStatFrm" method="post" action="statproc.jsp">
            <input type="hidden" name="flag">
            <label for="bn">등번호</label>
            <input type="text" name="bn" id="bn">
            <label for="season">시즌</label>
            <input type="date" name="season" id="season">
            <label for="match">출전경기 수</label>
            <input type="text" name="match" id="match">
            <label for="goal">득점 수</label>
            <input type="text" name="goal" id="goal">
            <label for="as">도움 수</label>
            <input type="text" name="as" id="as">
            <label for="yellow">경고 수</label>
            <input type="text" name="yellow" id="yellow">
            <label for="red">퇴장 수</label>
            <input type="text" name="red" id="red">
            <div class="button-container">
                <button type="button" id="addData">데이터 추가</button>
                <button type="button" id="backStat">뒤로가기</button>
            </div>
        </form>
    </div>
</body>
</html>