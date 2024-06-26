<%@page import="pack.member.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="memberMgr" class="pack.member.MemberMgr"/>

<%
request.setCharacterEncoding("utf-8");
String id = (String)session.getAttribute("idKey");

//수정할 자료 읽어오기
MemberDto memberDto = memberMgr.getMember(id);


if(memberDto == null || id == null){
%>
    <script type="text/javascript">
    alert("로그인 하세요!");
    </script>
<%
	response.sendRedirect("loginPage.jsp");
	return;
}

%>



<script type="text/javascript">
window.onload = () => {
	document.querySelector("#update").onclick = memberUpdate;
	document.querySelector("#delete").onclick = memberDelete;
}
</script>
<link href="../css/editmember.css" rel="stylesheet" type="text/css">
<script src="../js/member.js"></script>
</head>
<body>
<%@ include file="member_bar.jsp"%>
    <div class="container">
        <form action="edit.jsp" method="post" name="editFrm">
            <table>
                <tr>
                    <td>
                    아이디
                    <input type="hidden" name="id" value="<%=memberDto.getId() %>">
                    </td>

                    <td><%=memberDto.getId() %></td>
                </tr>
                <tr>
                    <td>비밀번호</td>
                    <td><input type="password" name="passwd" value="<%=memberDto.getPasswd() %>"></td>
                </tr>
                 <tr>
                    <td>비밀번호 확인</td>
                    <td><input type="password" name="passwd_re" value=""></td>
                </tr>
                <tr>
                    <td>이  름</td>
                    <td><input type="text" name="name" value="<%=memberDto.getName() %>"></td>
                </tr>
                <tr>
                    <td>이메일</td>
                    <td><input type="text" name="email" value="<%=memberDto.getEmail() %>"></td>
                </tr>
                <tr>
                    <td>생년월일</td>
                    <td><input type="date" name="birth" value="<%=memberDto.getBirth() %>"></td>
                </tr>
                <tr>
                    <td>소속팀</td>
                    <td>
                    	<select name="teamcode">
							<option value="<%=memberDto.getTeamcode() %>"><%=memberDto.getTeamname() %></option>
							<option value="ULS">울산 현대</option>
							<option value="GWO">강원 FC</option>
							<option value="POH">포항 스틸러스</option>
							<option value="KIM">김천 상무</option>
							<option value="SUS">수원 FC</option>
							<option value="GWA">광주 FC</option>
							<option value="INC">인천 유나이티드</option>
							<option value="JEO">제주 유나이티드</option>
							<option value="FCS">FC 서울</option>
							<option value="DAE">대구 FC</option>
							<option value="JNB">전북 현대 모터스</option>
							<option value="DJC">대전 하나 시티즌</option>		
						</select>
                    </td>
                </tr>
                <tr>
                   <td colspan="2">
                        <input type="hidden" name="edit">
                   		<input type="button" id="update" value="수정하기">
                   		<input type="button" id="delete" value="탈퇴하기">
                   </td>
                </tr>
            </table>
         </form>
    </div>
</body>
</html>