<%@page import="pack.stat.StatBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:useBean id="adminDto" class="pack.admin.AdminDto" />
<jsp:useBean id="adminMgr" class="pack.admin.AdminMgr" />
<%
String id = (String) session.getAttribute("adminKey");
adminDto = adminMgr.getAdmin(id);
//System.out.println(adminDto);
String teamcode = adminDto.getTeamcode(); 
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
