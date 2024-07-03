<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="memberMgr" class="pack.member.MemberMgr"/>

<%
String id = request.getParameter("id");
boolean b = memberMgr.idCheck(id);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../js/script.js"></script>
</head>
<body>
<b><%=id%></b>
<%
if (b) {
%>
는 이미 사용 중인 ID 입니다!<p/>
<a href="#" onclick="opener.document.registerFrm.id.focus();window.close()">닫기</a>
<%
} else {
%>
는 사용 가능한 ID 입니다<p/>
<a href="#" onclick="opener.document.registerFrm.passwd.focus();window.close()">닫기</a>
<%
}
%>
</body>
</html>