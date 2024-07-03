<%@page import="pack.member.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="memberDto" class="pack.member.MemberDto" scope="page" />
<jsp:setProperty property="*" name="memberDto" />
<jsp:useBean id="memberMgr" class="pack.member.MemberMgr" />

<%
String edit = request.getParameter("edit");
String id = (String)session.getAttribute("idKey");


if(edit.equals("update")){
    boolean b = memberMgr.memberUpdate(memberDto, id);

    if(b){
    %>
    	<script>
    	alert("수정되었습니다");
    	location.href="../member/editProfile.jsp";
    	</script>
    <%}else{%>
    	<script>
    	//alert(b);
    	alert("수정 실패\n관리자에게 문의 바람");
    	history.back();
    	</script>
    <%
    }
} else if(edit.equals("delete")){
    boolean b = memberMgr.memberDelete(id);

    if(b){
        %>
        	<script>
        	alert("탈퇴되었습니다");
        	location.href="loginPage.jsp";
        	</script>
        <%
        session.removeAttribute("idKey");
        //response.sendRedirect("../member/loginPage.jsp");

        System.out.println("(idKey) id : " + session.getAttribute("idKey"));

        } else {
        %>
        	<script>
        	//alert(b);
        	alert("탈퇴 실패\n관리자에게 문의 바람");
        	history.back();
        	</script>
        <%
        }
} else {

}



%>