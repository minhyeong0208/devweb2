<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
window.onload = () => {
	document.querySelector("#login").onclick = adminLogin;
}

function adminLogin() {
	alert("a");
}
</script>
<body>
<form action="adminloginproc.jsp" method="post">
<table>
	<tr>
		<td>ID</td>
		<td><input type="text" name="adminID"></td>
	</tr>
	<tr>
		<td>PW</td>
		<td><input type="password" name="adminPW"></td>
	</tr>
	<tr>
		<td><input type="button" value="로그인" id="login"></td>
		<td><input type="button" value="회원가입" id=""></td>
	</tr>
</table>
</form>
</body>
</html>