<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="memberDto" class="pack.member.MemberDto" />
<jsp:useBean id="memberMgr" class="pack.member.MemberMgr" />

<%
String id = (String) session.getAttribute("idKey");


if (id == null) {
    // 세션에 idKey가 없는 경우 처리
%>
	<script type="text/javascript">
        alert("로그인 후 이용 가능합니다.");
        location.replace("loginPage.jsp");
    </script>
<%
    return;
}

memberDto = memberMgr.getMember(id);

if (memberDto == null) {
    // memberDto가 null인 경우 처리
%>
	<script type="text/javascript">
        alert("로그인 후 이용 가능합니다.");
        location.replace("loginPage.jsp");
    </script>
<%
    return;
}

String teamcode = memberDto.getTeamcode();
if (teamcode == null){
	//teamcode가 null인 경우 처리
%>
	<script type="text/javascript">
		alert("로그인 후 이용 가능합니다.");
		location.replace("loginPage.jsp");
	</script>
<%

}
%>
