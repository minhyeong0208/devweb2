<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pack.staff.StaffMgr"%>
<%@ page import="pack.staff.StaffBean"%>

<%
    request.setCharacterEncoding("UTF-8");
    String action = request.getParameter("action");
    boolean isAdd = "add".equals(action);
    boolean isSuccess = false;
    String errorMessage = "";

    if (isAdd) {
        try {
            String staffName = request.getParameter("staffName");
            String staffTeamcode = request.getParameter("staffTeamcode");
            String staffNation = request.getParameter("staffNation");
            String staffRole = request.getParameter("staffRole");
            String staffIbdan = request.getParameter("staffIbdan");

            StaffBean staff = new StaffBean();
            staff.setName(staffName);
            staff.setTeamcode(staffTeamcode);
            staff.setNation(staffNation);
            staff.setRole(staffRole);
            staff.setIbdan(staffIbdan);

            StaffMgr staffMgr = new StaffMgr();
            isSuccess = staffMgr.staffInsert(staff);
        } catch (Exception e) {
            errorMessage = e.getMessage();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스태프 추가 페이지</title>
<link href="../css/staffInfo.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/staff.js"></script>
<script>
function closeWindow() {
    window.opener.location.reload();
    window.close();
}
window.onload = () => {
    document.querySelector("#btnInsert").onclick = () => {
        document.querySelector("form[name='insertForm']").submit();
    };
}
</script>
</head>
<body class="staff-add-page">
<%
    if (isAdd && isSuccess) {
%>
    <div class="staff-container">
        <div class="success-message">
            <p>스태프 추가가 완료되었습니다.</p>
        </div>
        <div class="button-container">
            <button class="staff-add-btn" onclick="closeWindow()">닫기</button>
        </div>
    </div>
<%
    } else {
%>
<div class="staff-container">
	<div class="staff-add-container">
	    <form name="insertForm" action="addstaffinsert.jsp" method="post">
	        <input type="hidden" name="action" value="add">
	        <h1>스태프 추가</h1>
	        <label for="staffName">스태프 이름:</label>
	        <input type="text" name="staffName" id="staffName" value="<%= request.getParameter("staffName") == null ? "" : request.getParameter("staffName") %>"><br>
	        <label for="staffTeamcode">스태프 팀 코드:</label>
	        <select name="staffTeamcode" id="staffTeamcode">
	            <option value="">팀코드 선택</option>
	            <option value="ULS">울산현대</option>
	            <option value="GWO">강원FC</option>
	            <option value="POH">포항 스틸러스</option>
	            <option value="KIM">김천상무 FC</option>
	            <option value="SUS">수원FC</option>
	            <option value="GWA">광주FC</option>
	            <option value="INC">인천 유나이티드</option>
	            <option value="JEO">제주 유나이티드</option>
	            <option value="FCS">FC서울</option>
	            <option value="DAE">대구FC</option>
	            <option value="JNB">전북 현대 모터스</option>
	            <option value="DJC">대전 하나 시티즌</option>
	        </select><br>
	        <label for="staffNation">스태프 국적:</label>
	        <input type="text" name="staffNation" id="staffNation" value="<%= request.getParameter("staffNation") == null ? "" : request.getParameter("staffNation") %>"><br>
	        <label for="staffRole">스태프 역할:</label>
	        <select name="staffRole" id="staffRole">
                <option value="">역할 선택</option>
                <option value="스포츠 사이언티스트">스포츠 사이언티스트</option>
                <option value="트레이너">트레이너</option>
                <option value="주치의">주치의</option>
                <option value="장비관리사">장비관리사</option>
                <option value="통역관">통역관</option>
                <option value="전력분석관">전력분석관</option>
            </select><br>
	        <label for="staffIbdan">스태프 입단일:</label>
	        <input type="date" name="staffIbdan" id="staffIbdan" value="<%= request.getParameter("staffIbdan") == null ? "" : request.getParameter("staffIbdan") %>"><br>
	        <div class="button-container">
	            <input type="button" class="staff-add-btn" value="추가" id="btnInsert">
	            <input type="reset" class="staff-add-btn delete" value="새로 입력">
	        </div>
	        <%
	            if (!errorMessage.isEmpty()) {
	        %>
	        <p style="color:red;"><%= errorMessage %></p>
	        <%
	            }
	        %>
	    </form>
	</div>
</div>
<%
    }
%>
</body>
</html>
