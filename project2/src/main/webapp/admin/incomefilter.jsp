<%@page import="pack.income.IncomeBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="sessioncheck_admin.jsp" %>
<jsp:useBean id="incomeMgr" class="pack.income.IncomeMgr" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>필터 결과</title>
<link href="../css/income_expend.css" rel="stylesheet" type="text/css">
</head>
<body class="income-filter-page">
	<div class="income-container">
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

        ArrayList<IncomeBean> filteredList = new ArrayList<IncomeBean>();
        if (filterOption != null && !filterOption.isEmpty()) {
            filteredList = incomeMgr.getIncomeByOption(filterOption, teamcode);
        }

        for (IncomeBean i : filteredList) {
        %>
        <tr style="text-align: center;">
            <td><%=i.getCode()%></td>
            <td><%=i.getTeamcode() %></td>
            <td><%=i.getDate()%></td>
            <td><%=i.getBriefs()%></td>
            <td>
                <%
                switch (filterOption) {
                    case "티켓":
                        out.print(i.getTicket());
                        break;
                    case "굿즈":
                        out.print(i.getGoods());
                        break;
                    case "팬":
                        out.print(i.getFan());
                        break;
                    case "방송권":
                        out.print(i.getBroad());
                        break;
                    case "스폰서":
                        out.print(i.getSpon());
                        break;
                    case "광고":
                        out.print(i.getAd());
                        break;
                    case "대여료":
                        out.print(i.getRent());
                        break;
                    case "임대":
                        out.print(i.getLoan());
                        break;
                    case "선수판매":
                        out.print(i.getPysell());
                        break;
                }
                %>
            </td>
        </tr>
        <%
        }
        %>
    </table>
    	 <button class="incomebtn" onclick="window.close()">닫기</button>
	</div>
</body>
</html>
