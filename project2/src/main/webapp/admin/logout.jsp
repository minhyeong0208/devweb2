<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
session.removeAttribute("adminKey");

%>
<script type="text/javascript">
	alert("로그아웃 완료");
	location.replace("admin_login.jsp");
</script>

</body>
</html>