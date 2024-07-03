<%@page import="java.time.LocalDate"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="sessioncheck_admin.jsp" %>
<jsp:useBean id="incomeMgr" class="pack.income.IncomeMgr" />
<jsp:useBean id="expendMgr" class="pack.expend.ExpendMgr" />

<%
// 시작일자, 종료일자 
String end_date = LocalDate.now().toString();
String start_date = LocalDate.now().minusMonths(12).toString();
id = (String)session.getAttribute("adminKey");

//리스트 형태로 수입 값 획득
ArrayList<String> incomeColName = incomeMgr.getColumn();
ArrayList<Integer> colIncome = incomeMgr.getIncome(incomeColName, start_date, end_date, teamcode);

// 지출
ArrayList<String> expendColName = expendMgr.getColumn();
ArrayList<Integer> colExpend = expendMgr.getExpend(expendColName, start_date, end_date, teamcode);

int incomeSum = 0, expendSum = 0;
for(int i = 3; i < colIncome.size() - 1; i++) {
	incomeSum += colIncome.get(i);
	expendSum += colExpend.get(i);
}

//JSON 데이터 변환
JSONObject jsonObject = new JSONObject();
jsonObject.put("총 수입", incomeSum);
jsonObject.put("총 지출", expendSum);
response.getWriter().write(jsonObject.toJSONString());


%>
