<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <!-- 페이지 설정 -->
<%@ page import="pack.staff.StaffMgr"%> <!-- StaffMgr 클래스 임포트 -->
<%@ page import="pack.staff.StaffBean"%> <!-- StaffBean 클래스 임포트 -->
<%@ include file="sessioncheck.jsp"%> <!-- 세션 체크 JSP 파일 포함 -->

<jsp:useBean id="staffMgr" class="pack.staff.StaffMgr" /> <!-- StaffMgr 빈 사용 -->
<jsp:useBean id="bean" class="pack.staff.StaffBean"/> <!-- StaffBean 빈 사용 -->

<%
    request.setCharacterEncoding("utf-8"); // 요청 인코딩을 UTF-8로 설정
    String code = request.getParameter("code"); // code 파라미터를 가져옴
    StaffBean sBean = staffMgr.getStaff(code, teamcode); // teamcode와 code로 스태프 정보를 가져옴

    String action = request.getParameter("action"); // action 파라미터를 가져옴
    boolean isUpdate = "update".equals(action); // action이 "update"인 경우를 체크
    boolean isSuccess = false; // 작업 성공 여부를 나타내는 변수 초기화
    String errorMessage = ""; // 에러 메시지를 저장할 변수 초기화

    if (isUpdate) { // 업데이트 작업인 경우
        try {
            if (sBean == null) {
                sBean = new StaffBean(); // sBean이 null인 경우 새 객체 생성
                sBean.setCode(Integer.parseInt(code)); // code 설정
            }

            // 폼 데이터에서 각 파라미터를 가져옴
            String staffName = request.getParameter("staffName");
            String staffTeamcode = request.getParameter("staffTeamcode");
            String staffNation = request.getParameter("staffNation");
            String staffRole = request.getParameter("staffRole");
            String staffIbdan = request.getParameter("staffIbdan");

            // sBean 객체에 데이터 설정
            sBean.setName(staffName);
            sBean.setTeamcode(staffTeamcode);
            sBean.setNation(staffNation);
            sBean.setRole(staffRole);
            sBean.setIbdan(staffIbdan);

            // staffUpdate 메서드 호출로 업데이트 수행
            isSuccess = staffMgr.staffUpdate(sBean);

            if (!isSuccess) {
                errorMessage = "스태프 수정에 실패했습니다."; // 실패 시 에러 메시지 설정
            }
        } catch (Exception e) { // 예외 발생 시
            errorMessage = e.getMessage(); // 에러 메시지 설정
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> <!-- 문서 인코딩을 UTF-8로 설정 -->
<title>스태프 정보 수정</title> <!-- 페이지 제목 설정 -->
<link href="../css/staffInfo.css" rel="stylesheet" type="text/css"> <!-- CSS 파일 포함 -->
<script type="text/javascript" src="../js/staff.js"></script> <!-- JavaScript 파일 포함 -->
<script>
function closeWindow() {
    window.opener.location.reload(); // 부모 창 새로고침
    window.close(); // 현재 창 닫기
}
function submitUpdateForm() {
    document.querySelector("form[name='updateForm']").submit(); // 업데이트 폼 제출
}
</script>
</head>
<body class="staff-add-page">
<%
    if (isUpdate && isSuccess) { // 업데이트 작업이 성공한 경우
%>
    <div class="staff-container">
        <div class="success-message">
            <p>스태프 수정이 완료되었습니다.</p> <!-- 성공 메시지 출력 -->
        </div>
        <div class="button-container">
            <button class="staff-add-btn" onclick="closeWindow()">닫기</button> <!-- 닫기 버튼 -->
        </div>
    </div>
<%
    } else { // 처음 폼을 로드하거나 업데이트 작업이 실패한 경우
%>
<div class="staff-container">
    <div class="staff-add-container">
        <form name="updateForm" action="addstaffupdate.jsp" method="post"> <!-- 업데이트 폼 -->
            <input type="hidden" name="action" value="update"> <!-- action 히든 필드 -->
            <input type="hidden" name="code" id="staffCode" value="<%= sBean != null ? sBean.getCode() : "" %>"> <!-- 스태프 코드 히든 필드 -->
            <h1>스태프 수정</h1>
            <label for="staffName">스태프 이름</label>
            <input type="text" name="staffName" id="staffName" value="<%= sBean != null ? sBean.getName() : "" %>"><br> <!-- 이름 입력 필드 -->
            <label for="staffTeamcode">스태프 팀 코드</label>
            <select name="staffTeamcode" id="staffTeamcode"> <!-- 팀 코드 선택 -->
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
            <input type="text" name="staffNation" id="staffNation" value="<%= sBean != null ? sBean.getNation() : "" %>"><br> <!-- 국적 입력 필드 -->
            <label for="staffRole">스태프 역할</label>
            <select name="staffRole" id="staffRole"> <!-- 역할 선택 -->
                <option value="">역할 선택</option>
                <option value="스포츠 사이언티스트" <%= "스포츠 사이언티스트".equals(sBean != null ? sBean.getRole() : "") ? "selected" : "" %>>스포츠 사이언티스트</option>
                <option value="트레이너" <%= "트레이너".equals(sBean != null ? sBean.getRole() : "") ? "selected" : "" %>>트레이너</option>
                <option value="주치의" <%= "주치의".equals(sBean != null ? sBean.getRole() : "") ? "selected" : "" %>>주치의</option>
                <option value="장비관리사" <%= "장비관리사".equals(sBean != null ? sBean.getRole() : "") ? "selected" : "" %>>장비관리사</option>
                <option value="통역관" <%= "통역관".equals(sBean != null ? sBean.getRole() : "") ? "selected" : "" %>>통역관</option>
                <option value="전력분석관" <%= "전력분석관".equals(sBean != null ? sBean.getRole() : "") ? "selected" : "" %>>전력분석관</option>
            </select><br>
            <label for="staffIbdan">스태프 입단일</label>
            <input type="date" name="staffIbdan" id="staffIbdan" value="<%= sBean != null ? sBean.getIbdan() : "" %>"><br> <!-- 입단일 선택 -->
            <div class="button-container">
                <input type="button" class="staff-add-btn" value="수정완료" id="btnUpdateOk" onclick="submitUpdateForm()"> <!-- 수정 완료 버튼 -->
                <input type="reset" class="staff-add-btn delete" value="수정취소" onclick="window.close()"> <!-- 수정 취소 버튼 -->
            </div>
        </form>
        <%
            if (!errorMessage.isEmpty()) { // 에러 메시지가 있는 경우
        %>
        <p style="color:red;"><%= errorMessage %></p> <!-- 에러 메시지 출력 -->
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
