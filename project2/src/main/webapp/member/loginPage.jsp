<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../css/member.css" rel="stylesheet" type="text/css">
<title>로그인</title>
<script type="text/javascript">
window.onload = () => {
	document.querySelector("#btnLogin").onclick = loginFunc;
}

function loginFunc(){
	let teamcode = document.querySelector("#teamcode").value;
	let id = document.querySelector("#id").value;
	let passwd = document.querySelector("#passwd").value;
	//
	if(id === "" || passwd === "" || teamcode === "0"){
		alert("입력 미완료!");
		
	} else {
		//loginFrm.action = "login2.jsp";
		loginFrm.action = "login.jsp";
		loginFrm.submit();
	}
	
	
}

</script>
</head>
<body style="background-color:#f5f5f5"></body>
<body>
<div class="container">
<form class="form" name="loginFrm" method="post">
    <p class="heading">Login</p>
    <select name="teamcode" class="input" id="teamcode">
		<option value="0">팀코드</option>
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
    <input class="input" name="id" id="id" placeholder="ID" type="text">
    <input class="input" name="passwd" id="passwd" placeholder="Password" type="text">
    
    <button class="btn" id="btnLogin">로그인</button>
    
	<br>
<div class="linkContainer">   
    <a href="registerPage.jsp">회원가입하기</a> &nbsp;&nbsp;&nbsp;
    <a href="findIdPage.jsp">Forget ID/Password</a>
</div>
</form>
</div>

</body>
</html>
