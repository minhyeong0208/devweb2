<%@page import="pack.income.IncomeMgr"%>
<%@page import="pack.income.IncomeBean"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="sessioncheck_admin.jsp" %>
<%
    IncomeMgr incomeMgr = new IncomeMgr(); // IncomeMgr 객체 생성 
    request.setCharacterEncoding("UTF-8"); // 요청 인코딩 설정

    String code = request.getParameter("income_code"); // 파라미터로부터 수입 코드 가져오기
    IncomeBean income = incomeMgr.getIncomeById(Integer.parseInt(code), teamcode); // 수입 코드로 IncomeBean 객체 가져오기

    boolean isUpdated = false; // 업데이트 여부를 저장할 변수 초기화

    if ("POST".equalsIgnoreCase(request.getMethod())) { // 요청 메서드가 POST인지 확인 
        teamcode = request.getParameter("teamcode"); // 폼 데이터에서 팀 코드 가져오기
        String briefs = request.getParameter("briefs"); // 폼 데이터에서 적요 가져오기
        String incomeType = request.getParameter("incomeType"); // 폼 데이터에서 수입 유형 가져오기
        String amountStr = request.getParameter("amount"); // 폼 데이터에서 금액 가져오기
        int amount = Integer.parseInt(amountStr); // 금액을 정수로 변환

        income.setTeamcode(teamcode); // IncomeBean 객체에 팀 코드 설정
        income.setBriefs(briefs); // IncomeBean 객체에 적요 설정

        switch (incomeType) { // 수입 유형에 따라 적절한 값 설정
            case "티켓":
                income.setTicket(amount);
                break;
            case "굿즈":
                income.setGoods(amount);
                break;
            case "팬":
                income.setFan(amount);
                break;
            case "방송권":
                income.setBroad(amount);
                break;
            case "스폰서":
                income.setSpon(amount);
                break;
            case "광고":
                income.setAd(amount);
                break;
            case "대여료":
                income.setRent(amount);
                break;
            case "임대":
                income.setLoan(amount);
                break;
            case "선수판매":
                income.setPysell(amount);
                break;
        }

        boolean updated = incomeMgr.updateIncome(income); // 수입 업데이트 시도
        isUpdated = updated; // 업데이트 결과 저장
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>수입내역 수정</title>
    <link href="../css/income_expend.css" rel="stylesheet" type="text/css">
    <script type="text/javascript">
        function closeWindow() { 
            window.opener.location.reload(); // 부모 창 새로고침
            window.close(); // 현재 창 닫기
        }

        function validateForm() {
            const teamcode = document.getElementById('teamcode').value.trim(); // 팀 코드 가져오기
            const briefs = document.getElementById('briefs').value.trim(); // 적요 가져오기
            const incomeType = document.getElementById('incomeType').value.trim(); // 수입 유형 가져오기
            const amount = document.getElementById('amount').value.trim(); // 금액 가져오기

            if (!teamcode) { // 팀 코드가 비어 있는지 확인
                alert('팀코드를 입력하지 않았습니다.');
                return false;
            }

            if (!briefs) { // 적요가 비어 있는지 확인
                alert('적요를 입력하지 않았습니다.');
                return false;
            }

            if (!incomeType) { // 수입 유형이 선택되지 않았는지 확인
                alert('수입 내역을 선택하지 않았습니다.');
                return false;
            }

            if (!amount || isNaN(amount)) { // 금액이 비어 있거나 유효하지 않은지 확인
                alert('금액을 올바르게 입력하지 않았습니다.');
                return false;
            }

            return true; // 유효성 검사 통과
        }

        function submitForm() {
            if (validateForm()) { // 유효성 검사를 통과한 경우에만 폼 제출
                document.getElementById('editForm').submit();
            }
        }
    </script>
</head>
<body class="income-update-page">
    <div class="income-container">
        <h1>수입내역 수정</h1>
        <form id="editForm" method="post" action="incomeupdate.jsp?income_code=<%= code %>" style="<%= isUpdated ? "display:none;" : "" %>">
            <label for="teamcode">팀 코드:</label> 
            <input type="text" id="teamcode" name="teamcode" value="<%= income.getTeamcode() %>"><br>
            
            <label for="briefs">적요:</label>
            <input type="text" id="briefs" name="briefs" value="<%= income.getBriefs() %>"><br>
            
            <label for="incomeType">수입 내역:</label>
            <select id="incomeType" name="incomeType">
                <option value="">-- 선택 --</option>
                <option value="티켓">티켓</option>
                <option value="굿즈">굿즈</option>
                <option value="팬">팬</option>
                <option value="방송권">방송권</option>
                <option value="스폰서">스폰서</option>
                <option value="광고">광고</option>
                <option value="대여료">대여료</option>
                <option value="임대">임대</option>
                <option value="선수판매">선수판매</option>
            </select><br><br>
            
            <label for="amount">금액:</label>
            <input type="text" id="amount" name="amount" value=""><br>
            
            <div class="button-container">
                <input type="button" class="btnincomeadd" id="incomeUpdate" value="수정" onclick="submitForm()">
            </div>
        </form>
        <%
        if (isUpdated) { // 업데이트가 성공적으로 완료된 경우
        %>
        <div class="button-container">
            <input type="button" class="btnincomeadd" value="닫기" onclick="closeWindow()">
        </div>
        <%
        }
        %>
    </div>
</body>
</html>
