<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../css/member.css" rel="stylesheet" type="text/css">
<title>회원가입 페이지</title>

<script src="../js/member.js"></script>
<script type="text/javascript">
window.onload = () => {
	document.querySelector("#idCheck").onclick = idCheck;
	document.querySelector("#registerValid").onclick = validCheck;
}

</script>
</head>
<body style="background-color:#f5f5f5"></body>
<body>
<div class="container">
<form class="form" action="register.jsp" method="post" name="registerFrm">
    <p class="heading">Sign up</p>
    <div>
        <input class="input" placeholder="ID" type="text" name="id" id="id">
        <input type="button" class="btn" id="idCheck" value="체크">
    </div>   
    <input class="input" placeholder="Password Check" type="text" name="passwd" id="passwd">
    <input class="input" placeholder="Password Check" type="text" name="passwdCheck" id="passwdCheck">
    <input class="input" placeholder="NAME" type="text" name="name" id="name">
    <input class="input" placeholder="BIRTHDATE" type="date" name="birth" id="birth">
    <input class="input" placeholder="EMAIL" type="text" name="email" id="email">
    <select name="teamcode" class="input" id="teamcode">
		<option value="0">소속 구단</option>
		<option value="ULS">울산 현대</option>
		<option value="GWO">강원 FC</option>
		<option value="POH">포항 스틸러스</option>
		<option value="KIM">김천 상무</option>
		<option value="SUS">수원 FC</option>
		<option value="GWA">광주 FC</option>
		<option value="INC">인천 유나이티드</option>
		<option value="JEO">제주 유나이티드</option>
		<option value="FCS">FC 서울</option>
		<option value="DAE">대구 FC</option>
		<option value="JNB">전북 현대 모터스</option>
		<option value="DJC">대전 하나 시티즌</option>		
	</select>
    <button class="btn" id="registerValid">Sign up</button>
	<br>
</form>
</div>
</body>
</html>