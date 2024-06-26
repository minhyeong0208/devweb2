<%@page import="pack.expend.ExpendMgr"%>
<%@page import="pack.expend.ExpendBean"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    ExpendMgr expendMgr = new ExpendMgr();
    request.setCharacterEncoding("UTF-8");

    boolean dataAdded = false;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String teamcode = request.getParameter("teamcode");
        String briefs = request.getParameter("briefs");
        String expendType = request.getParameter("expendType");
        String amountStr = request.getParameter("amount");
        int amount = Integer.parseInt(amountStr);

        // 새로운 ExpendBean 객체 생성
        ExpendBean ebean = new ExpendBean();
        ebean.setTeamcode(teamcode); // 팀 코드 설정
        ebean.setBriefs(briefs);
        
        // 필요시 직접 코드 값을 설정 (이 부분은 상황에 따라 다름)
        // ebean.setExpendCode(여기에 적절한 코드 값);

        // 지출 유형에 따라 적절한 필드를 설정
        switch (expendType) {
            case "선수 구매":
                ebean.setPybuy(amount);
                break;
            case "교통비":
                ebean.setTrans(amount);
                break;
            case "식비":
                ebean.setEat(amount);
                break;
            case "유지보수":
                ebean.setMaintain(amount);
                break;
            case "코치 급여":
                ebean.setCosalary(amount);
                break;
            case "감독 급여":
                ebean.setHcsalary(amount);
                break;
            case "스태프 급여":
                ebean.setStsalary(amount);
                break;
            case "훈련":
                ebean.setTraining(amount);
                break;
            case "마케팅":
                ebean.setMkting(amount);
                break;
        }

        // 데이터베이스에 데이터 삽입
        boolean b = expendMgr.expendInsert(ebean);

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
<title>지출내역 추가</title>
<link href="../css/income_expend.css" rel="stylesheet" type="text/css">
<script type="text/javascript">

function closeWindow() {
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
        document.getElementById('addForm').submit();
    }
}
</script>
</head>
<body class="expend-add-page">
    <div class="expend-container">
        <% if (dataAdded) { %>
        <div class="success-message">
            데이터가 성공적으로 추가되었습니다.
        </div>
        <div class="button-container">
            <input type="button" class="expendbtn" value="닫기" onclick="closeWindow()">
        </div>
        <% } else { %>
        <h1>지출내역 추가</h1>
        <form id="addForm" method="post" action="expendadd.jsp">
            <table>
                <thead>
                    <tr>
                        <th>팀 코드</th>
                        <th>적요</th>
                        <th>지출 내역</th>
                        <th>금액</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><input type="text" id="teamcode" name="teamcode"></td>
                        <td><input type="text" id="briefs" name="briefs"></td>
                        <td>
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
                            </select>
                        </td>
                        <td><input type="text" id="amount" name="amount"></td>
                    </tr>
                </tbody>
            </table>
            <div class="button-container">
                <input type="button" class="expendbtn" id="expendAdd" value="추가" onclick="submitForm()">
                <input type="button" class="expendbtn" id="expendCel" value="닫기" onclick="closeWindow()">
            </div>
        </form>
        <% } %>
    </div>
</body>
</html>
