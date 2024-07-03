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
    // 페이지가 로드된 후 실행될 함수를 정의함.
   document.querySelector("#btnSubmit").onclick = adminLogin;
    // "btnSubmit" 버튼을 클릭했을 때 adminLogin함수가 호출되도록 설정.
}

function adminLogin(){
    event.preventDefault();
    // 이벤트의 기본 동작을 중지함. 여기서는 폼의 기본 제출 동작을 막음.
    
    let admin_id = document.querySelector("#id").value;
    // id가 "id"인 입력 필드의 값을 가져와서 admin_id 변수에 저장.
    let admin_passwd = document.querySelector("#passwd").value;
    // id가 "passwd"인 입력 필드의 값을 가져와서 admin_passwd 변수에 저장.
    let admin_teamcode = document.querySelector("#teamcode").value;
    // id가 "teamcode"인 select 필드의 값을 가져와서 admin_teamcode 변수에 저장.

    if(admin_id === "" || admin_passwd === "" || admin_teamcode === "0"){
        // 만약 admin_id, admin_passwd가 비어있거나, admin_teamcode가 0 (기본 값)인 경우
        // alert("입력 미완료!")
    } else {
        // 모든 필드가 올바르게 입력된 경우
        // alert("로그인~");
        loginFrm.action = "loginproc_admin.jsp";
        // 폼의 action 속성을 "loginproc_admin.jsp"로 설정.
        loginFrm.submit();
        // 폼을 제출.
    }
}
</script>
</head>
<body style="background-color:#f5f5f5"></body>
<body>
<div class="container">
   <!-- 중앙에 배치된 로그인 폼을 담고 있는 컨테이너  -->
<form class="form" method="post" name="loginFrm">
   <!-- 로그인 폼을 정의합니다. post 메서드를 사용하여 데이터를 전송  -->
    <p class="heading">Admin Login</p>
    <input class="input" placeholder="ID" name="id" id="id" type="text">
    <!-- 관리자 ID를 입력받는 텍스트 필드. -->
    <input class="input" placeholder="Password" name="passwd" id="passwd" type="text">
    <!-- 관리자 비밀번호를 입력받는 텍스트 필드. -->
    <select name="teamcode" class="input" id="teamcode">
        <!-- 팀 코드를 선택하는 드롭다운 메뉴. -->
      <option value="0">팀코드</option>
        <!-- 기본값으로 설정된 옵션. 값을 0으로 설정하여 선택되지 않은 상태를 나타냄. -->
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
    <!-- Submit 버튼 클릭 시 adminLogin 함수가 호출됨. -->
   <br>
<div class="linkContainer">   
    <a href="#">Sign Up</a> &nbsp;&nbsp;&nbsp;
    <a href="#">Forget ID/Password</a>
    <!-- 회원가입 및 아이디/비밀번호 찾기 링크 빼기!!. -->
</div>
</form>
</div>
</body>
</html>