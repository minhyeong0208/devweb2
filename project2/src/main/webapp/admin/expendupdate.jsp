<%@page import="pack.expend.ExpendMgr"%>
<%@page import="pack.expend.ExpendBean"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="sessioncheck_admin.jsp" %>

<%
    ExpendMgr expendMgr = new ExpendMgr();
    request.setCharacterEncoding("UTF-8");

    String code = request.getParameter("expend_code");
    ExpendBean expend = expendMgr.getExpendById(Integer.parseInt(code), teamcode);

    boolean isUpdated = false;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        teamcode = request.getParameter("teamcode");
        String briefs = request.getParameter("briefs");
        String expendType = request.getParameter("expendType");
        String amountStr = request.getParameter("amount");
        int amount = Integer.parseInt(amountStr);

        expend.setTeamcode(teamcode);
        expend.setBriefs(briefs);

        switch (expendType) {
            case "선수 구매":
                expend.setPybuy(amount);
                break;
            case "교통비":
                expend.setTrans(amount);
                break;
            case "식비":
                expend.setEat(amount);
                break;
            case "유지보수":
                expend.setMaintain(amount);
                break;
            case "코치 급여":
                expend.setCosalary(amount);
                break;
            case "감독 급여":
                expend.setHcsalary(amount);
                break;
            case "스태프 급여":
                expend.setStsalary(amount);
                break;
            case "훈련":
                expend.setTraining(amount);
                break;
            case "마케팅":
                expend.setMkting(amount);
                break;
        }

        boolean updated = expendMgr.updateExpend(expend);
        isUpdated = updated;
        if (updated) {
            // 데이터가 성공적으로 수정되었습니다.
        } else {
            // 데이터 수정에 실패했습니다.
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>지출내역 수정</title>
    <link href="../css/income_expend.css" rel="stylesheet" type="text/css">
    <script type="text/javascript">
        function closeWindow() {
            window.opener.location.reload();
            window.close();
        }

        function validateForm() {
            const teamcode = document.getElementById('teamcode').value.trim();
            const briefs = document.getElementById('briefs').value.trim();
            const expendType = document.getElementById('expendType').value.trim();
            const amount = document.getElementById('amount').value.trim();

            if (!teamcode) {
                alert('팀코드를 입력하지 않았습니다.');
                return false;
            }

            if (!briefs) {
                alert('적요를 입력하지 않았습니다.');
                return false;
            }

            if (!expendType) {
                alert('지출 내역을 선택하지 않았습니다.');
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
<body class="expend-update-page">
    <div class="expend-container">
        <h1>지출내역 수정</h1>
        <form id="editForm" method="post" action="expendupdate.jsp?expend_code=<%= code %>" style="<%= isUpdated ? "display:none;" : "" %>">
            <label for="teamcode">팀 코드:</label> 
            <input type="text" id="teamcode" name="teamcode" value="<%= expend.getTeamcode() %>"><br>
            
            <label for="briefs">적요:</label>
            <input type="text" id="briefs" name="briefs" value="<%= expend.getBriefs() %>"><br>
            
            <label for="expendType">지출 내역:</label>
            <select id="expendType" name="expendType">
                <option value="">-- 선택 --</option>
                <option value="선수 구매">선수 구매</option>
                <option value="교통비">교통비</option>
                <option value="식비">식비</option>
                <option value="유지보수">유지보수</option>
                <option value="코치 급여">코치 급여</option>
                <option value="감독 급여">감독 급여</option>
                <option value="스태프 급여">스태프 급여</option>
                <option value="훈련">훈련</option>
                <option value="마케팅">마케팅</option>
            </select><br><br>
            
            <label for="amount">금액:</label>
            <input type="text" id="amount" name="amount" value=""><br>
            
            <div class="button-container">
                <input type="button" class="btnexpendadd" id="expendUpdate" value="수정" onclick="submitForm()">
            </div>
        </form>
        <%
        if (isUpdated) {
        %>
        <div class="button-container">
            <input type="button" class="btnexpendadd" value="닫기" onclick="closeWindow()">
        </div>
        <%
        }
        %>
    </div>
</body>
</html>
