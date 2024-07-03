<%@page import="pack.income.IncomeMgr"%>
<%@page import="pack.income.IncomeBean"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    IncomeMgr incomeMgr = new IncomeMgr();
    request.setCharacterEncoding("UTF-8");
    boolean dataAdded = false;
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String teamcode = request.getParameter("teamcode");
        String briefs = request.getParameter("briefs");
        String incomeType = request.getParameter("incomeType");
        String amountStr = request.getParameter("amount");
        int amount = Integer.parseInt(amountStr);

        // 새로운 IncomeBean 객체 생성
        IncomeBean ibean = new IncomeBean();
        ibean.setTeamcode(teamcode); // 팀 코드 설정
        ibean.setBriefs(briefs);

        // 수입 유형에 따라 적절한 필드를 설정
        switch (incomeType) {
            case "티켓":
                ibean.setTicket(amount);
                break;
            case "굿즈":
                ibean.setGoods(amount);
                break;
            case "팬":
                ibean.setFan(amount);
                break;
            case "방송권":
                ibean.setBroad(amount);
                break;
            case "스폰서":
                ibean.setSpon(amount);
                break;
            case "광고":
                ibean.setAd(amount);
                break;
            case "대여료":
                ibean.setRent(amount);
                break;
            case "임대":
                ibean.setLoan(amount);
                break;
            case "선수판매":
                ibean.setPysell(amount);
                break;
        }

        // 데이터베이스에 데이터 삽입
        boolean b = incomeMgr.incomeInsert(ibean);

        if (b) {
            dataAdded = true;
        } else {
            out.println("<p>데이터 추가에 실패했습니다.</p>");
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수입내역 추가</title>
<link href="../css/income_expend.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function closeWindow() {
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
        document.getElementById('addForm').submit();
    }
}
</script>
</head>
<body class="income-add-page">
    <div class="income-container">
        <% if (dataAdded) { %>
        <div class="success-message">
            데이터가 성공적으로 추가되었습니다.
        </div>
       <div class="button-container">
            <input type="button" class="incomebtn" value="닫기" onclick="closeWindow()">
        </div>
        <% } else { %>
        <h1>수입내역 추가</h1>
        <form id="addForm" method="post" action="incomeadd.jsp">
            <table>
                <thead>
                    <tr>
                        <th>팀 코드</th>          
                        <th>적요</th>
                        <th>수입 내역</th>
                        <th>금액</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><input type="text" id="teamcode" name="teamcode"></td>
                        <td><input type="text" id="briefs" name="briefs"></td>
                        <td>
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
                            </select>
                        </td>
                        <td><input type="text" id="amount" name="amount"></td>
                    </tr>
                </tbody>
            </table>
            <div class="button-container">
                <input type="button" class="incomebtn" id="incomeAdd" value="추가" onclick="submitForm()">
                <input type="button" class="incomebtn" id="incomeCel" value="닫기" onclick="closeWindow()">
            </div>
        </form>
        <% } %>
    </div>
</body>
</html>
