<%@page import="pack.member.MemberDto"%>
<%@page import="pack.member.MailSender"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="memberDto" class="pack.member.MemberDto"/>
<jsp:useBean id="memberMgr" class="pack.member.MemberMgr"/>
<jsp:useBean id="mailSender" class="pack.member.MailSender"/>

<%
request.setCharacterEncoding("utf-8");

String team_code = request.getParameter("teamcode");
String id = request.getParameter("id");
String passwd = request.getParameter("passwd");

// 로그인 최대 시도 횟수
int maxAttempts = 3;

boolean b = memberMgr.loginCheck(team_code, id, passwd);

if(b){
	// 사용자 로그인 - 세션 생성(idKey)
	// 관리자는 adminKey
	session.setAttribute("idKey", id);
	// 로그인 성공하면 세션 초기화
	session.setAttribute("loginAttempts", null);
	response.sendRedirect("dashboard.jsp");
} else {
	
	Integer attempts = (Integer) session.getAttribute("loginAttempts");
	
	// 실패 횟수 갱신
	if (attempts == null) {
        attempts = 1;
    } else {
        attempts++;
    }
	
	 // 실패 횟수를 세션 저장
    session.setAttribute("loginAttempts", attempts);
	 
    // 실패 횟수가 최대 제한 횟수 이상이면 임시 비밀번호 생성
    if (attempts >= maxAttempts) {
    	//session.setAttribute("loginAttempts", null);
%>
        <script type="text/javascript">
			alert("로그인 <%=attempts %>회 실패! 관리자에게 문의");
			location.href="logfail.html";
		</script>
<%

    } else {
%>
  <script type="text/javascript">
      alert("로그인 <%=attempts %>회 실패! 3회 이상 실패시 관리자 문의");
      history.back();
  </script>
<%
    }
	
}

%>