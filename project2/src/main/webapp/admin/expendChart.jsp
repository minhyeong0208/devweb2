<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="sessioncheck_admin.jsp" %>
<jsp:useBean id="expendMgr" class="pack.expend.ExpendMgr" />
<%
String edate = java.time.LocalDate.now().toString();
String sdate = java.time.LocalDate.now().minusMonths(1).toString();

ArrayList<String> expendColName = expendMgr.getColumn();
ArrayList<Integer> expend = expendMgr.getExpend(expendColName, sdate, edate, teamcode);

// JSON 데이터 변환
JSONObject jsonObject = new JSONObject();
for (int i = 3; i < expendColName.size() - 1; i++) {
    String key = expendColName.get(i);
    Integer value = expend.get(i);
    jsonObject.put(key, value);
}

response.getWriter().write(jsonObject.toJSONString());

%>