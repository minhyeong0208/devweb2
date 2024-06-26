<%@page import="pack.income.IncomeMgr"%>
<%@page import="pack.income.IncomeBean"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="sessioncheck_admin.jsp" %>
<%
    IncomeMgr incomeMgr = new IncomeMgr();
    request.setCharacterEncoding("UTF-8");

    String code = request.getParameter("income_code");
    IncomeBean income = incomeMgr.getIncomeById(Integer.parseInt(code), teamcode);

    boolean isUpdated = false;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        teamcode = request.getParameter("teamcode");
        String briefs = request.getParameter("briefs");
        String incomeType = request.getParameter("incomeType");
        String amountStr = request.getParameter("amount");
        int amount = Integer.parseInt(amountStr);

        income.setTeamcode(teamcode);
        income.setBriefs(briefs);

        switch (incomeType) {
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

        boolean updated = incomeMgr.updateIncome(income);
        isUpdated = updated;
        if (updated) {
            //out.println("<p>데이터가 성공적으로 수정되었습니다.</p>");
        } else {
            //out.println("<p>데이터 수정에 실패했습니다.</p>");
        }
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
            window.opener.location.reload();
            window.close();
        }

        function validateForm() {
            const teamcode = document.getElementById('teamcode').value.trim();
            const briefs = document.getElementById('briefs').value.trim();
            const incomeType = document.getElementById('incomeType').value.trim();
            const amount = document.getElementById('amount').value.trim();

            if (!teamcode) {
                alert('팀코드를 입력하지 않았습니다.');
                return false;
            }

            if (!briefs) {
                alert('적요를 입력하지 않았습니다.');
                return false;
            }

            if (!incomeType) {
                alert('수입 내역을 선택하지 않았습니다.');
                return false;
            }

            if (!amount || isNaN(amount)) {
                alert('금액을 올바르게 입력하지 않았습니다.');
                return false;
            }

            return true;
        }

        function submitForm() {
            if (validateForm()) {
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
        if (isUpdated) {
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
