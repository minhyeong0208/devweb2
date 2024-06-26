<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../css/adminlogin.css" rel="stylesheet" type="text/css">
<title>관리자 로그인</title>
<script type="text/javascript">
window.onload = () => {
	document.querySelector("#btnSubmit").onclick = adminLogin;
	
}

function adminLogin(){
	event.preventDefault();
	let admin_id = document.querySelector("#id").value;
	let admin_passwd = document.querySelector("#passwd").value;
	let admin_teamcode = document.querySelector("#teamcode").value;
	
	if(admin_id === "" || admin_passwd === "" || admin_teamcode === "0"){
		//alert("입력 미완료!")
	} else {
		//alert("로그인~");
		loginFrm.action = "loginproc_admin.jsp";
		loginFrm.submit();
	}
}
</script>
</head>
<body style="background-color:#f5f5f5"></body>
<body>
<div class="container">
<form class="form" method="post" name="loginFrm">
    <p class="heading">Admin Login</p>
    <input class="input" placeholder="ID" name="id" id="id" type="text">
    <input class="input" placeholder="Password" name="passwd" id="passwd" type="text">
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
    <button class="btn" id="btnSubmit">Submit</button>
	<br>
<div class="linkContainer">   
    <a href="sign_up.jsp">Sign Up</a> &nbsp;&nbsp;&nbsp;
    <a href="ForgetID_Password.jsp">Forget ID/Password</a>
</div>
</form>
</div>
</body>
</html>