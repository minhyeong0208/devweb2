<%@page import="java.time.LocalDate"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="sessioncheck_admin.jsp" %>    

<jsp:useBean id="incomeMgr" class="pack.income.IncomeMgr" />
<%
String edate = LocalDate.now().toString();
String sdate = LocalDate.now().minusMonths(1).toString();

ArrayList<String> incomeColName = incomeMgr.getColumn();
ArrayList<Integer> income = incomeMgr.getIncome(incomeColName, sdate, edate, teamcode);

// JSON 데이터 변환
JSONObject jsonObject = new JSONObject();
for (int i = 3; i < incomeColName.size() - 1; i++) {
    String key = incomeColName.get(i);
    Integer value = income.get(i);
    jsonObject.put(key, value);
}
response.getWriter().write(jsonObject.toJSONString());
//System.out.println(jsonObject.toJSONString());
%>