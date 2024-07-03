<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <!-- 페이지 설정 -->
<%@ page import="pack.staff.StaffMgr"%> <!-- StaffMgr 임포트 -->
<%@ page import="pack.staff.StaffBean"%> <!-- StaffBean 임포트 -->

<%
    request.setCharacterEncoding("UTF-8"); // 요청 인코딩을 UTF-8로 설정
    String action = request.getParameter("action"); // action 파라미터를 가져옴
    boolean isAdd = "add".equals(action); // action이 "add"인 경우를 체크
    boolean isSuccess = false; // 성공 여부를 나타내는 변수 초기화
    String errorMessage = ""; // 에러 메시지를 저장할 변수 초기화

    if (isAdd) { // 추가 작업인 경우
        try {
            // 폼 데이터에서 각 파라미터를 가져옴
            String staffName = request.getParameter("staffName");
            String staffTeamcode = request.getParameter("staffTeamcode");
            String staffNation = request.getParameter("staffNation");
            String staffRole = request.getParameter("staffRole");
            String staffIbdan = request.getParameter("staffIbdan");

            // StaffBean 객체 생성 및 데이터 설정
            StaffBean staff = new StaffBean();
            staff.setName(staffName);
            staff.setTeamcode(staffTeamcode);
            staff.setNation(staffNation);
            staff.setRole(staffRole);
            staff.setIbdan(staffIbdan);

            // StaffMgr 객체를 통해 데이터베이스에 스태프 추가
            StaffMgr staffMgr = new StaffMgr();
            isSuccess = staffMgr.staffInsert(staff);
        } catch (Exception e) { // 예외 발생 시 에러 메시지 저장
            errorMessage = e.getMessage();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> <!-- 문서 인코딩을 UTF-8로 설정 -->
<title>스태프 추가 페이지</title> <!-- 페이지 제목 설정 -->
<link href="../css/staffInfo.css" rel="stylesheet" type="text/css"> <!-- CSS 파일 포함 -->
<script type="text/javascript" src="../js/staff.js"></script> <!-- JavaScript 파일 포함 -->
<script>
// 창 닫기 함수
function closeWindow() {
    window.opener.location.reload(); // 부모 창 새로고침
    window.close(); // 현재 창 닫기
}
// 페이지 로드 시 추가 버튼에 이벤트 리스너 추가
window.onload = () => {
    document.querySelector("#btnInsert").onclick = () => {
        document.querySelector("form[name='insertForm']").submit(); // 폼 제출
    };
}
</script>
</head>
<body class="staff-add-page">
<%
    if (isAdd && isSuccess) { // 추가 작업이 성공한 경우
%>
    <div class="staff-container">
        <div class="success-message">
            <p>스태프 추가가 완료되었습니다.</p>
        </div>
        <div class="button-container">
            <button class="staff-add-btn" onclick="closeWindow()">닫기</button> <!-- 닫기 버튼 -->
        </div>
    </div>
<%
    } else { // 추가 작업이 실패하거나 폼을 처음 로드한 경우
%>
<div class="staff-container">
	<div class="staff-add-container">
	    <form name="insertForm" action="addstaffinsert.jsp" method="post"> <!-- 추가 폼 -->
	        <input type="hidden" name="action" value="add"> <!-- action 히든 필드 -->
	        <h1>스태프 추가</h1>
	        <label for="staffName">스태프 이름:</label>
	        <input type="text" name="staffName" id="staffName" value="<%= request.getParameter("staffName") == null ? "" : request.getParameter("staffName") %>"><br> <!-- 이름 입력 필드 -->
	        <label for="staffTeamcode">스태프 팀 코드:</label>
	        <select name="staffTeamcode" id="staffTeamcode"> <!-- 팀 코드 선택 -->
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
	        <input type="text" name="staffNation" id="staffNation" value="<%= request.getParameter("staffNation") == null ? "" : request.getParameter("staffNation") %>"><br> <!-- 국적 입력 필드 -->
	        <label for="staffRole">스태프 역할:</label>
	        <select name="staffRole" id="staffRole"> <!-- 역할 선택 -->
                <option value="">역할 선택</option>
                <option value="스포츠 사이언티스트">스포츠 사이언티스트</option>
                <option value="트레이너">트레이너</option>
                <option value="주치의">주치의</option>
                <option value="장비관리사">장비관리사</option>
                <option value="통역관">통역관</option>
                <option value="전력분석관">전력분석관</option>
            </select><br>
	        <label for="staffIbdan">스태프 입단일:</label>
	        <input type="date" name="staffIbdan" id="staffIbdan" value="<%= request.getParameter("staffIbdan") == null ? "" : request.getParameter("staffIbdan") %>"><br> <!-- 입단일 선택 -->
	        <div class="button-container">
	            <input type="button" class="staff-add-btn" value="추가" id="btnInsert"> <!-- 추가 버튼 -->
	            <input type="reset" class="staff-add-btn delete" value="새로 입력"> <!-- 새로 입력 버튼 -->
	        </div>
	        <%
	            if (!errorMessage.isEmpty()) { // 에러 메시지가 있는 경우
	        %>
	        <p style="color:red;"><%= errorMessage %></p> <!-- 에러 메시지 출력 -->
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
