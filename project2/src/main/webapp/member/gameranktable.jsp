<%@page import="pack.member.Scraping"%>
<%@page import="pack.member.TeamDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
Scraping scraping = new Scraping();
List<TeamDto> teamDataList = scraping.scrapeRank();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table style="text-align: center; width: 100%;">
	<thead>
		<tr>
			<th>순위</th>
			<th>팀명</th>
			<th>경기수</th>
			<th>승점</th>
			<th>승</th>
			<th>무</th>
			<th>패</th>
			<th>득점</th>
			<th>실점</th>
		</tr>
	</thead>
	<tbody>
	<%
	for (TeamDto team : teamDataList){
		%>
		<tr>
			<th><%=team.rank %></th>
			<td><%=team.title %></td>
			<td><%=team.match %></td>
			<td><%=team.victoryPoint %></td>
			<td><%=team.victory %></td>
			<td><%=team.draw %></td>
			<td><%=team.defeat %></td>
			<td><%=team.goals %></td>
			<td><%=team.loss %></td>
		</tr>
		<%
	}
	%>

	</tbody>
</table>
</body>
</html>