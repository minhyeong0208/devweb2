<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pack.staff.StaffMgr"%>
<%@ page import="pack.staff.StaffBean"%>
<%@ include file="sessioncheck.jsp"%>

<jsp:useBean id="staffMgr" class="pack.staff.StaffMgr" />
<jsp:useBean id="bean" class="pack.staff.StaffBean"/>

<%
    request.setCharacterEncoding("utf-8");
    String code = request.getParameter("code");
    StaffBean sBean = staffMgr.getStaff(code, teamcode);

    String action = request.getParameter("action");
    boolean isUpdate = "update".equals(action);
    boolean isSuccess = false;
    String errorMessage = "";

    if (isUpdate) {
        try {
            if (sBean == null) {
                sBean = new StaffBean();
                sBean.setCode(Integer.parseInt(code));
            }

            String staffName = request.getParameter("staffName");
            String staffTeamcode = request.getParameter("staffTeamcode");
            String staffNation = request.getParameter("staffNation");
            String staffRole = request.getParameter("staffRole");
            String staffIbdan = request.getParameter("staffIbdan");

            sBean.setName(staffName);
            sBean.setTeamcode(staffTeamcode);
            sBean.setNation(staffNation);
            sBean.setRole(staffRole);
            sBean.setIbdan(staffIbdan);

            isSuccess = staffMgr.staffUpdate(sBean);

            if (!isSuccess) {
                errorMessage = "스태프 수정에 실패했습니다.";
            }
        } catch (Exception e) {
            errorMessage = e.getMessage();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스태프 정보 수정</title>
<link href="../css/staffInfo.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/staff.js"></script>
<script>
function closeWindow() {
    window.opener.location.reload();
    window.close();
}
function submitUpdateForm() {
    document.querySelector("form[name='updateForm']").submit();
}
</script>
</head>
<body class="staff-add-page">
<%
    if (isUpdate && isSuccess) {
%>
    <div class="staff-container">
        <div class="success-message">
            <p>스태프 수정이 완료되었습니다.</p>
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
        <form name="updateForm" action="addstaffupdate.jsp" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="code" id="staffCode" value="<%= sBean != null ? sBean.getCode() : "" %>">
            <h1>스태프 수정</h1>
            <label for="staffName">스태프 이름</label>
            <input type="text" name="staffName" id="staffName" value="<%= sBean != null ? sBean.getName() : "" %>"><br>
            <label for="staffTeamcode">스태프 팀 코드</label>
            <select name="staffTeamcode" id="staffTeamcode">
                <option value="">팀코드 선택</option>
                <option value="ULS" <%= "ULS".equals(sBean != null ? sBean.getTeamcode() : "") ? "selected" : "" %>>울산현대</option>
                <option value="GWO" <%= "GWO".equals(sBean != null ? sBean.getTeamcode() : "") ? "selected" : "" %>>강원FC</option>
                <option value="POH" <%= "POH".equals(sBean != null ? sBean.getTeamcode() : "") ? "selected" : "" %>>포항 스틸러스</option>
                <option value="KIM" <%= "KIM".equals(sBean != null ? sBean.getTeamcode() : "") ? "selected" : "" %>>김천상무 FC</option>
                <option value="SUS" <%= "SUS".equals(sBean != null ? sBean.getTeamcode() : "") ? "selected" : "" %>>수원FC</option>
                <option value="GWA" <%= "GWA".equals(sBean != null ? sBean.getTeamcode() : "") ? "selected" : "" %>>광주FC</option>
                <option value="INC" <%= "INC".equals(sBean != null ? sBean.getTeamcode() : "") ? "selected" : "" %>>인천 유나이티드</option>
                <option value="JEO" <%= "JEO".equals(sBean != null ? sBean.getTeamcode() : "") ? "selected" : "" %>>제주 유나이티드</option>
                <option value="FCS" <%= "FCS".equals(sBean != null ? sBean.getTeamcode() : "") ? "selected" : "" %>>FC서울</option>
                <option value="DAE" <%= "DAE".equals(sBean != null ? sBean.getTeamcode() : "") ? "selected" : "" %>>대구FC</option>
                <option value="JNB" <%= "JNB".equals(sBean != null ? sBean.getTeamcode() : "") ? "selected" : "" %>>전북 현대 모터스</option>
                <option value="DJC" <%= "DJC".equals(sBean != null ? sBean.getTeamcode() : "") ? "selected" : "" %>>대전 하나 시티즌</option>
            </select><br>
            <label for="staffNation">스태프 국적</label>
            <input type="text" name="staffNation" id="staffNation" value="<%= sBean != null ? sBean.getNation() : "" %>"><br>
            <label for="staffRole">스태프 역할</label>
            <select name="staffRole" id="staffRole">
                <option value="">역할 선택</option>
                <option value="스포츠 사이언티스트" <%= "스포츠 사이언티스트".equals(sBean != null ? sBean.getRole() : "") ? "selected" : "" %>>스포츠 사이언티스</option>
                <option value="트레이너" <%= "트레이너".equals(sBean != null ? sBean.getRole() : "") ? "selected" : "" %>>트레이너</option>
                <option value="주치의" <%= "주치의".equals(sBean != null ? sBean.getRole() : "") ? "selected" : "" %>>주치의</option>
                <option value="장비관리사" <%= "장비관리사".equals(sBean != null ? sBean.getRole() : "") ? "selected" : "" %>>장비관리사</option>
                <option value="통역관" <%= "통역관".equals(sBean != null ? sBean.getRole() : "") ? "selected" : "" %>>통역관</option>
                <option value="전력분석관" <%= "전력분석관".equals(sBean != null ? sBean.getRole() : "") ? "selected" : "" %>>전력분석관</option>
            </select><br>
            <label for="staffIbdan">스태프 입단일</label>
            <input type="date" name="staffIbdan" id="staffIbdan" value="<%= sBean != null ? sBean.getIbdan() : "" %>"><br>
            <div class="button-container">
                <input type="button" class="staff-add-btn" value="수정완료" id="btnUpdateOk" onclick="submitUpdateForm()">
                <input type="reset" class="staff-add-btn delete" value="수정취소" onclick="window.close()">
            </div>
        </form>
        <%
            if (!errorMessage.isEmpty()) {
        %>
        <p style="color:red;"><%= errorMessage %></p>
        <%
            }
        %>
    </div>
</div>
<%
    }
%>
</body>
</html>
