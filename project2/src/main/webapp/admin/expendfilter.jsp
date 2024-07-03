<%@page import="pack.expend.ExpendBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="sessioncheck_admin.jsp" %>

<jsp:useBean id="expendMgr" class="pack.expend.ExpendMgr" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>필터 결과</title>
<link href="../css/income_expend.css" rel="stylesheet" type="text/css">
</head>
<body class="expend-filter-page">
	<div class="expend-container">
    <h1>필터 결과</h1>
    <table>
        <tr>
            <th>코드</th>
            <th>팀명</th>
            <th>날짜</th>
            <th>적요</th>
            <th>금액</th>
        </tr>
        <%
        String filterOption = request.getParameter("filter_option");

        ArrayList<ExpendBean> filteredList = new ArrayList<ExpendBean>();
        if (filterOption != null && !filterOption.isEmpty()) {
            filteredList = expendMgr.getExpendByOption(filterOption, teamcode);
        }

        for (ExpendBean e : filteredList) {
        %>
        <tr style="text-align: center;">
            <td><%=e.getCode()%></td>
            <td><%=e.getTeamcode() %></td>
            <td><%=e.getDate()%></td>
            <td><%=e.getBriefs()%></td>
            <td>
                <%
                switch (filterOption) {
                    case "선수 구매":
                        out.print(e.getPybuy());
                        break;
                    case "교통비":
                        out.print(e.getTrans());
                        break;
                    case "식비":
                        out.print(e.getEat());
                        break;
                    case "유지보수":
                        out.print(e.getMaintain());
                        break;
                    case "코치 급여":
                        out.print(e.getCosalary());
                        break;
                    case "감독 급여":
                        out.print(e.getHcsalary());
                        break;
                    case "스태프 급여":
                        out.print(e.getStsalary());
                        break;
                    case "훈련":
                        out.print(e.getTraining());
                        break;
                    case "마케팅":
                        out.print(e.getMkting());
                        break;
                }
                %>
            </td>
        </tr>
        <%
        }
        %>
    </table>
    <button class="expendbtn" onclick="window.close()">닫기</button>
	</div>
</body>
</html>
