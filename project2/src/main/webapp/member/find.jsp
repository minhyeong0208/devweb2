<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="memberDto" class="pack.member.MemberDto"/>
<jsp:useBean id="memberMgr" class="pack.member.MemberMgr"/>



<%

request.setCharacterEncoding("utf-8");

String teamcode = request.getParameter("teamcode");
String name = request.getParameter("name");
String email = request.getParameter("email");
String id = request.getParameter("id");
String find = request.getParameter("find");



if(find.equals("id")){
    System.out.println(name + " " + teamcode + " " + email + " " + find);
    memberDto = memberMgr.FindMemberId(teamcode, name, email);
    //System.out.println(memberDto.getId());

    if(memberDto.getId() == null || memberDto.getId().equals("") || memberDto.getId().isEmpty()){
    %>
    	<script type="text/javascript">
    		alert("가입된 정보가 없습니다");
    		history.back();
    	</script>
    <%
    } else {
    %>

    	<script type="text/javascript">
            alert("<%=name %>" + "님의 아이디는 " + "<%=memberDto.getId() %>" + " 입니다");
    		location.href="loginPage.jsp";
    	</script>
    <%
    }
} else if(find.equals("passwd")){
    System.out.println(name + " " + teamcode + " " + email + " " + id + " " + find);
    memberDto = memberMgr.FindMemberPw(teamcode, name, email, id);
    System.out.println(memberDto.getPasswd());

    if(memberDto.getPasswd() == null || memberDto.getPasswd().equals("") || memberDto.getPasswd().isEmpty()){
        %>
        	<script type="text/javascript">
        		alert("가입된 정보가 없습니다");
        		history.back();
        	</script>
        <%
        } else {
        %>

        	<script type="text/javascript">
                alert("<%=name %>" + "님의 비밀번호는 " + "<%=memberDto.getPasswd() %>" + " 입니다");
        		location.href="loginPage.jsp";
        	</script>

        <%}
} else {

}






%>
