<%@page import="pack.stat.StatBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="pack.stat.StatDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="sessioncheck.jsp"%>
<jsp:useBean id="statMgr" class="pack.stat.StatMgr"></jsp:useBean>
<jsp:useBean id="playerMgr" class="pack.player.PlayerMgr"></jsp:useBean>

<%
// 정렬 방법 및 칼럼명
String sort = request.getParameter("sort");
String column = request.getParameter("column");

// 시작, 종료 일자
String start = request.getParameter("start_date");
String end = request.getParameter("end_date");

// 페이징 처리를 위한 변수 선언
int spage = 1, pageCount = 0;  // pageCount : 페이지 수

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>선수단 통계</title>
<link href="../css/memberStatistic.css" rel="stylesheet" type="text/css"> <!-- 새 CSS 파일 추가 -->
<script type="text/javascript" src="../js/stat.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script type="text/javascript">
window.onclick = () => {
    document.querySelector("#filter").onclick = changeValue;
}
</script>
</head>
<body>
    <%@ include file="member_bar.jsp"%>
    <div class="container">
        <form name="filterSort" method="get">
            <div class="table-container">
                <div class="left-section">
                    <label for="start_date">일자</label>
                    <input type="date" name="start_date" id="start_date">
                    <span>~</span>
                    <input type="date" name="end_date" id="end_date">
                </div>
                <div class="right-section">
                    <label for="sortOrder">정렬순서</label>
                    <select id="sortOrder" name="sort">
                        <option value="asc" selected>오름차순</option>
                        <option value="desc">내림차순</option>
                    </select>
                    <label for="columnOrder">정렬기준</label>
                    <select id="columnOrder" name="column">
                        <option value="stat_code" selected>일련번호</option>
                        <option value="stat_bn">등번호</option>
                        <option value="stat_season">시즌</option>
                        <option value="stat_match">출전경기</option>
                        <option value="stat_goal">득점</option>
                        <option value="stat_as">도움</option>
                        <option value="stat_yellow">경고</option>
                        <option value="stat_red">퇴장</option>
                    </select>
                    <input type="button" id="filter" value="필터">
                    <button type="button" onclick="window.open('insertstat.jsp', '', 'width=500, height=250, status=no,toolbar=no,scrollbars=no,location=no,menubar=no')">추 가</button>
                </div>
            </div>
        </form>
        
        <div id="filterResultTable" style="display:none;"></div>
        
        <form name="deleteStatFrm">
            <input type="hidden" name="flag">
            <div id="resultTable">
                <table style="text-align: left;" border="1">
                    <tr>
                        <th>일련번호</th><th>등번호</th><th>선수명</th><th>시즌</th><th>출전경기</th><th>골</th><th>도움</th><th>경고</th><th>퇴장</th><th>수정/삭제</th>
                    </tr>
                    
                    <%
                    try {
                        spage = Integer.parseInt(request.getParameter("page"));
                    } catch(Exception e) {
                        spage = 1;  // spage 값을 주지 않는 경우, 기본값은 1로 설정
                    }
                    if(spage <= 0) spage = 1; 
                    
                    statMgr.totalList(start, end, teamcode);  // 전체 레코드 수
                    pageCount = statMgr.getPageCount(); // 페이지 수
                    
                    ArrayList<StatBean> list = statMgr.getStatistic(spage, column, sort, start, end, teamcode);
                    
                    for (StatBean s : list) {
                    %>
                        <tr style="text-align: center;">
                            <td><%=s.getCode()%></td>
                            <td><%=s.getBn()%></td>
                            <td><%=s.getName()%></td>
                            <td><%=s.getSeason()%></td>
                            <td><%=s.getMatch()%></td>
                            <td><%=s.getGoal()%></td>
                            <td><%=s.getAs()%></td>
                            <td><%=s.getYellow()%></td>
                            <td><%=s.getRed()%></td>
                            <td>
                                <input type="hidden" name="code" value="<%=s.getCode()%>">
                                <button type="button" onclick="window.open('updatestat.jsp?code=<%=s.getCode() %>', '', 'width=400, height=300')">수정</button>
                                <button type="button" onclick="javascript:deleteStatData('<%=s.getCode()%>')">삭제</button>
                            </td>
                        </tr>
                        <%
                    }
                    %>
                </table>
                <br>
                
                <!-- 팀 통계 테이블 -->
			<table class="teamStat">
				<tr>
					<th colspan="2">선택 기간 통계</th>
				</tr>
				<%
				StatBean teamResult = statMgr.getTotalStat(start, end, teamcode);
				%>
				<tr>
					<td>득점 수</td>
					<td><%=teamResult.getTotalGoal() %></td>
				</tr>
				<tr>
					<td>도움 수</td>
					<td><%=teamResult.getTotalAs() %></td>
				</tr>
				<tr>
					<td>경고 수</td>
					<td><%=teamResult.getTotalYellow() %></td>
				</tr>
				<tr>
					<td>퇴장 수</td>
					<td><%=teamResult.getTotalRed() %></td>
				</tr>
			</table>
            </div>    
        </form>
        
        <div class="pagination">
            <ul>
                <% for(int i = 1; i <= pageCount; i++) { %>
                    <li>
                        <a href="statistic.jsp?start_date=<%=(start != null ? start : "")%>&end_date=<%=(end != null ? end : "")%>&sort=<%=(sort != null ? sort : "asc")%>&column=<%=(column != null ? column : "stat_code")%>&page=<%=i%>"><%=i%></a>
                    </li>    
                <% } %>
            </ul>
        </div>
    </div>
</body>
</html>
