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
    System.out.println(id);
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
<link href="../css/editProfile.css" rel="stylesheet" type="text/css">
<script src="../js/member.js"></script>
<title>회원 정보 수정</title>
</head>
<body>
<%@ include file="member_bar.jsp"%>
    <div class="container">
        <h1>회원 정보 수정</h1>
        <form action="edit.jsp" method="post" name="editFrm">
            <label>아이디</label>
            <input type="hidden" name="id" value="<%=memberDto.getId() %>">
            <p><%=memberDto.getId() %></p>
            <label>비밀번호</label>
            <input type="password" name="passwd" value="<%=memberDto.getPasswd() %>">
            <label>비밀번호 확인</label>
            <input type="password" name="passwd_re" value="<%=memberDto.getPasswd() %>">
            <label>이름</label>
            <input type="text" name="name" value="<%=memberDto.getName() %>">
            <label>이메일</label>
            <input type="text" name="email" value="<%=memberDto.getEmail() %>">
            <label>생년월일</label>
            <input type="date" name="birth" value="<%=memberDto.getBirth() %>">
            <label>소속팀</label>
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
            <br><br><br>
            <div class="button-container">
                <input type="hidden" name="edit">
                <button type="button" id="update">수정하기</button>
                <button type="button" id="delete">탈퇴하기</button>
            </div>
         </form>
    </div>
</body>
</html>