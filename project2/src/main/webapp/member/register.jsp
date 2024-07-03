<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="memberDto" class="pack.member.MemberDto"/>
<jsp:setProperty property="*" name="memberDto"/>
<jsp:useBean id="memberMgr" class="pack.member.MemberMgr"/>

<%
boolean b = memberMgr.memberInsert(memberDto);
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/member.css" rel="stylesheet" type="text/css">
</head>
<body style="background-color:#f5f5f5"></body>
<body>
<%
if(b){
%>
	<div class="container">
		<form class="form" name="loginFrm" method="post">
			<p class="heading">회원가입 성공</p>
			<div>회원가입되셨습니다~</div>
			<br>
			<div class="linkContainer">
				<a href="loginPage.jsp">로그인 창으로 가기</a>
			</div>
		</form>
	</div>
	<%
} else {	
%>
	<div class="container">
		<form class="form" name="loginFrm" method="post">
			<p class="heading">회원가입 실패</p>
			<div>
				회원가입에 실패하셨습니다 <br> 관리자에게 문의하세요~
			</div>
			<br>
			<div class="linkContainer">
				<a href="registerPage.jsp">가입 재시도</a>
			</div>
		</form>
	</div>
	<%	
}
%>
</body>
</html>