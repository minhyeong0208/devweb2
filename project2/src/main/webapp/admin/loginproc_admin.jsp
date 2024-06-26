<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="adminMgr" class="pack.admin.AdminMgr"></jsp:useBean>

<%
request.setCharacterEncoding("utf-8");

String teamcode = request.getParameter("teamcode");
String id = request.getParameter("id");
String passwd = request.getParameter("passwd");

boolean b = adminMgr.adminCheck(id, passwd, teamcode);

if (b){
	// 로그인에 성공하면 대시보드로
	session.setAttribute("adminKey", id);
	response.sendRedirect("dashboard.jsp");
} else {
%>
	<script type="text/javascript">
		alert("로그인 정보를 확인해 주세요");
		history.back();
	</script>
<%
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>