<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="memberDto" class="pack.member.MemberDto" scope="page" />
<jsp:setProperty property="*" name="memberDto" />
<jsp:useBean id="memberMgr" class="pack.member.MemberMgr" />

<%
String id = (String)session.getAttribute("idKey");
boolean b = memberMgr.memberDelete(id); 


if(b){
%>
	<script>
	alert("탈퇴 성공");
	location.href="../member/loginPage.jsp";
	</script>
<%}else{%>
	<script>
	//alert(b);
	alert("탈퇴 실패\n관리자에게 문의 바람");
	history.back();
	</script>
<%	
}
%>

