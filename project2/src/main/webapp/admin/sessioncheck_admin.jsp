<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="adminDto" class="pack.admin.AdminDto" />
<jsp:useBean id="adminMgr" class="pack.admin.AdminMgr" />

<%
String id = (String) session.getAttribute("adminKey");


if (id == null) {
    // 세션에 idKey가 없는 경우 처리
%>
	<script type="text/javascript">
        alert("로그인 후 이용 가능합니다.");
        location.replace("admin_login.jsp");
    </script>
<%
    return;
}

adminDto = adminMgr.getAdmin(id);

if (adminDto == null) {
    // memberDto가 null인 경우 처리
%>
	<script type="text/javascript">
        alert("로그인 후 이용 가능합니다.");
        location.replace("admin_login.jsp");
    </script>
<%
    return;
}

String teamcode = adminDto.getTeamcode();
if (teamcode == null){
	//teamcode가 null인 경우 처리
%>
	<script type="text/javascript">
		alert("로그인 후 이용 가능합니다.");
		location.replace("admin_login.jsp");
	</script>
<%

}
%>
