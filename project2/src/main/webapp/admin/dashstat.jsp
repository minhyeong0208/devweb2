<%@page import="pack.stat.StatBean"%>
<%@page import="java.util.ArrayList"%>

<%@ include file="sessioncheck_admin.jsp" %>

<%
//String id = (String) session.getAttribute("adminKey");
// sessioncheck_admin.jsp로부터 로그인한 사람의 세션 아이디를 받아와 헤딩 팀의 팀코드를 저장
//adminDto = adminMgr.getAdmin(id);
//teamcode = adminDto.getTeamcode(); 
%>

<jsp:useBean id="statMgr" class="pack.stat.StatMgr"></jsp:useBean>
{
  "stat": [
    <%
      ArrayList<StatBean> list = statMgr.getStatistic(teamcode);
      for (int i = 0; i < list.size(); i++) {
        StatBean s = list.get(i);
        out.print("{");
        out.print("\"code\":\"" + s.getCode() + "\",");
        out.print("\"bn\":\"" + s.getBn() + "\",");
        out.print("\"name\":\"" + s.getName() + "\",");
        out.print("\"season\":\"" + s.getSeason() + "\",");
        out.print("\"match\":\"" + s.getMatch() + "\",");
        out.print("\"goal\":\"" + s.getGoal() + "\",");
        out.print("\"as\":\"" + s.getAs() + "\",");
        out.print("\"yellow\":\"" + s.getYellow() + "\",");
        out.print("\"red\":\"" + s.getRed() + "\"");
        out.print("}");
        if (i < list.size() - 1) {
          out.print(",");
        }
      }
    %>
  ]
}
