<%@page import="pack.expend.ExpendBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="sessioncheck_admin.jsp" %>

<jsp:useBean id="expendMgr" class="pack.expend.ExpendMgr" />

<%
int spage = 1;             // 현재 페이지 번호
int itemsPerPage = 10;   // 페이지당 항목 수
int totalItems = 0;     // 전체 항목 수
int pageCount = 0;      // 전체 페이지 수

if (request.getParameter("page") != null) {
    spage = Integer.parseInt(request.getParameter("page"));
}

// 데이터 가져오기
String sdate = request.getParameter("start_date");
String edate = request.getParameter("end_date");

ArrayList<ExpendBean> list = new ArrayList<ExpendBean>();
if (sdate != null && edate != null) {
    list = expendMgr.getExpendAll(sdate, edate, teamcode);
} else {
    list = expendMgr.getExpendAll("", "", teamcode); // 기본 값 (예: 모든 데이터)
}

totalItems = list.size();
pageCount = (int) Math.ceil((double) totalItems / itemsPerPage);

// 현재 페이지에 해당하는 데이터 가져오기
int startIndex = (spage - 1) * itemsPerPage;
int endIndex = Math.min(startIndex + itemsPerPage, totalItems);
List<ExpendBean> pageList = new ArrayList<>();
if (startIndex < totalItems) {
    pageList = list.subList(startIndex, endIndex);
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지출 내역</title>
<script src="../js/expend.js"></script>
<link href="../css/income_expend.css" rel="stylesheet" type="text/css">

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<!-- 날짜 라이브러리 -->
<script type="text/javascript">
window.onload = function() {
    document.querySelector("#search").onclick = setDate;
    document.querySelector("#filter").onclick = filterData;
    document.querySelector("#expendAdd").onclick = expendAdd;
}
</script>
</head>
<body class="expend-info-page">
   <%@ include file="admin_bar.jsp"%>
    <div class="container">
        <h1 style="text-align: center;">지출내역</h1>
        <div class="form-container">
            <form name="dateForm" method="get" action="expend_info.jsp" class="date-form">
                <div class="form-group">
                    <label for="start_date">일자</label>
                    <input type="date" name="start_date">
                    &nbsp;&nbsp;~&nbsp;&nbsp;
                    <input type="date" name="end_date">
                    <input type="button" value="검색" id="search">
                </div>
            </form>

            <form name="filterForm" method="get" action="expend_info.jsp" class="filter-form">
                <div class="form-group">
                    <select name="filter_option" id="filter_option" class="styled-select">
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
                    <input type="button" id="filter" value="필터">
                </div>
                <input type="button" class="expendadd" id="expendAdd" value="추 가">
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
                    <th>선수 구매</th>
                    <th>교통비</th>
                    <th>식비</th>
                    <th>유지보수</th>
                    <th>코치 급여</th>
                    <th>감독 급여</th>
                    <th>스태프 급여</th>
                    <th>훈련</th>
                    <th>마케팅</th>
                    <th>수정/삭제</th>
                </tr>

                <%
                for (ExpendBean e : pageList) {
                %>
                <tr style="text-align: center;">
                    <td><%=e.getCode()%></td>
                    <td><%=e.getTeamcode() %></td>
                    <td><%=e.getDate()%></td>
                    <td><%=e.getBriefs()%></td>
                    <td><%=e.getPybuy()%></td>
                    <td><%=e.getTrans()%></td>
                    <td><%=e.getEat()%></td>
                    <td><%=e.getMaintain()%></td>
                    <td><%=e.getCosalary()%></td>
                    <td><%=e.getHcsalary()%></td>
                    <td><%=e.getStsalary()%></td>
                    <td><%=e.getTraining()%></td>
                    <td><%=e.getMkting()%></td>
                    <td>
                        <button class="expendbtn" onclick="editExpend(<%=e.getCode()%>)">수정</button>
                        <button class="expendbtn" onclick="deleteExpend(<%=e.getCode()%>)">삭제</button>
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
                        <a href="expend_info.jsp?page=<%=i%><%=(sdate != null ? "&start_date=" + sdate : "")%><%=(edate != null ? "&end_date=" + edate : "")%>"><%=i%></a>
                    </li>
                <% } %>
            </ul>
        </div>
    </div>
</body>
</html>