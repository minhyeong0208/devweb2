<%@page import="pack.income.IncomeBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="sessioncheck_admin.jsp" %>

<jsp:useBean id="incomeMgr" class="pack.income.IncomeMgr" />
<jsp:useBean id="expendMgr" class="pack.expend.ExpendMgr" />

<%
int spage = 1; 			// 현재 페이지 번호
int itemsPerPage = 10;   // 페이지당 항목 수
int totalItems = 0;     // 전체 항목 수
int pageCount = 0;      // 전체 페이지 수

if (request.getParameter("page") != null) {
    spage = Integer.parseInt(request.getParameter("page"));
}

// 데이터 가져오기
String sdate = request.getParameter("start_date");
String edate = request.getParameter("end_date");

ArrayList<IncomeBean> list = new ArrayList<IncomeBean>();
if (sdate != null && edate != null) {
    list = incomeMgr.getIncomeAll(sdate, edate, teamcode);
} else {
    list = incomeMgr.getIncomeAll("", "", teamcode); // 기본 값 (예: 모든 데이터)
}

totalItems = list.size();
pageCount = (int) Math.ceil((double) totalItems / itemsPerPage);

// 현재 페이지에 해당하는 데이터 가져오기
int startIndex = (spage - 1) * itemsPerPage;
int endIndex = Math.min(startIndex + itemsPerPage, totalItems);
List<IncomeBean> pageList = new ArrayList<>();
if (startIndex < totalItems) {
    pageList = list.subList(startIndex, endIndex);
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수입 내역</title>
<script src="../js/income.js"></script>
<link href="../css/income_expend.css" rel="stylesheet" type="text/css">

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<!-- 날짜 라이브러리 -->
<script type="text/javascript">
window.onload = function() {
    document.querySelector("#search").onclick = setDate;
    document.querySelector("#filter").onclick = filterData;
    document.querySelector("#incomeAdd").onclick = incomeAdd;
}
</script>
</head>
<body class="income-info-page">
   <%@ include file="admin_bar.jsp"%>
    <div class="container">
        <h1 style="text-align: center;">수입내역</h1>
        <div class="form-container">
            <form name="dateForm" method="get" action="income_info.jsp" class="date-form">
                <div class="form-group">
                    <label for="start_date">일자</label>
                    <input type="date" name="start_date">
                    &nbsp;&nbsp;~&nbsp;&nbsp;
                    <input type="date" name="end_date">
                    <input type="button" value="검색" id="search">
                </div>
            </form>

            <form name="filterForm" method="get" action="income_info.jsp" class="filter-form">
                <div class="form-group">
                    <select name="filter_option" id="filter_option" class="styled-select">
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
                    <input type="button" id="filter" value="필터">
                </div>
                <input type="button" class="incomeadd" id="incomeAdd" value="추 가">
            </form>
        </div>
        
        <div id="filterResultTable" style="display:none;"></div>  

        <!-- 기존 기능 테이블 -->
        <div id="resultTable">
            <table style="text-align: left;" border="1">
                <tr>
                    <th>코드</th>
                    <th>팀명</th>
                    <th>날짜</th>
                    <th>적요</th>
                    <th>티켓</th>
                    <th>굿즈</th>
                    <th>팬</th>
                    <th>방송권</th>
                    <th>스폰서</th>
                    <th>광고</th>
                    <th>대여료</th>
                    <th>임대</th>
                    <th>선수판매</th>
                    <th>수정/삭제</th>
                </tr>

                <%
                for (IncomeBean i : pageList) {
                %>
                <tr style="text-align: center;">
                    <td><%=i.getCode()%></td>
                    <td><%=i.getTeamcode() %></td>
                    <td><%=i.getDate()%></td>
                    <td><%=i.getBriefs()%></td>
                    <td><%=i.getTicket()%></td>
                    <td><%=i.getGoods()%></td>
                    <td><%=i.getFan()%></td>
                    <td><%=i.getBroad()%></td>
                    <td><%=i.getSpon()%></td>
                    <td><%=i.getAd()%></td>
                    <td><%=i.getRent()%></td>
                    <td><%=i.getLoan()%></td>
                    <td><%=i.getPysell()%></td>
                    <td>
                        <button class="incomebtn" onclick="editIncome(<%=i.getCode()%>)">수정</button>
                        <button class="incomebtn" onclick="deleteIncome(<%=i.getCode()%>)">삭제</button>
                    </td>
                </tr>
                <%
                }
                %>
            </table>
        </div>

        <!-- 페이지 네비게이션 -->
        <div class="pagination">
            <ul>
                <% for (int i = 1; i <= pageCount; i++) { %>
                    <li>
                        <a href="income_info.jsp?page=<%=i%><%=(sdate != null ? "&start_date=" + sdate : "")%><%=(edate != null ? "&end_date=" + edate : "")%>"><%=i%></a>
                    </li>
                <% } %>
            </ul>
        </div>
    </div>
</body>
</html>