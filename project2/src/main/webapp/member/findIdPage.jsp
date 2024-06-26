<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../css/member.css" rel="stylesheet" type="text/css">
<title>아이디 찾기</title>
<script type="text/javascript">
window.onload = () => {
	document.querySelector("#findId").onclick = findId;
	document.querySelector("#findPw").onclick = findPw;
}

function findId(){
	//alert("FindId");
	document.querySelector("#id").type = "hidden";
	document.querySelector("#btnFindId").onclick = function(){
	    let teamcode = document.querySelector("#teamcode").value;
     	let email = document.querySelector("#email").value;
     	let name = document.querySelector("#name").value;
     	if(email === "" || name === "" || teamcode === "0"){
     		alert("입력 미완료!")
     	} else {
     		findFrm.find.value = "id";
     		findFrm.action = "find.jsp";
     		findFrm.submit();
     	}
	}

	
	
}

function findPw(){
	//alert("FindId");
    document.querySelector("#id").type = "text";
    document.querySelector("#btnFindId").onclick = function(){
        let teamcode = document.querySelector("#teamcode").value;
    	let email = document.querySelector("#email").value;
    	let name = document.querySelector("#name").value;
    	let id = document.querySelector("#id").value;
    	if(email === "" || name === "" || teamcode === "0" || id === ""){
    		alert("입력 미완료!")
    	} else {
    		findFrm.find.value = "passwd";
    		findFrm.action = "find.jsp";
    	}
    }




}

</script>
</head>
<body style="background-color:#f5f5f5"></body>
<body>
<div class="container">
<form class="form" name="findFrm" method="post">
    <p class="heading">Find ID</p>
    <div>
    <input type="radio" name="radio_find" id="findId" value="아이디" checked>아이디
    <input type="radio" name="radio_find" id="findPw" value="비밀번호">비밀번호
    </div>
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
	<input class="input" name="name" id="name" placeholder="이름" type="text">
    <input class="input" name="email" id="email" placeholder="가입 시 이메일" type="text">
    <input class="input" name="id" id="id" placeholder="아이디" type="hidden">

    <input type="hidden" name="find">
    <button class="btn" id="btnFindId">아이디/비밀번호찾기</button>

	<br>
</form>
</div>
</body>
</html>