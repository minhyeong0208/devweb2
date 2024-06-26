<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="gameMemberMgr" class="pack.game_member2.GameMemberMgr" />
<jsp:useBean id="memberMgr" class="pack.member.MemberMgr" />
<jsp:useBean id="memberDto" class="pack.member.MemberDto" />

<%
// 올해, 전년도 통계 수치 - JSON으로

int thisYear = java.time.LocalDate.now().getYear();
int lastYear = thisYear - 1;

// 현재 로그인한 사용자 세션값 가져오기
String id = (String) session.getAttribute("idKey");
//String id = "user1"; // 확인용

// 해당 유저 팀코드 확인
memberDto = memberMgr.getMember(id);
String teamcode = memberDto.getTeamcode();
System.out.println(teamcode);
// 작년, 올해 통계값 가져오기
HashMap<String, Double> mapThisYear = gameMemberMgr.getAvgByYear(thisYear, teamcode);
HashMap<String, Double> mapLastYear = gameMemberMgr.getAvgByYear(lastYear, teamcode);

// 가져온 통계데이터 JSON 객체 생성
JSONArray array = new JSONArray();
JSONObject jsonThisYear = new JSONObject();
JSONObject jsonLastYear = new JSONObject();

// Map to JSON
// 올해
for(String key : mapThisYear.keySet()) {
    double value = mapThisYear.get(key);
    jsonThisYear.put(key, value);
}
    array.add(jsonThisYear);

// 작년
for(String key : mapLastYear.keySet()) {
    double value = mapLastYear.get(key);
    jsonLastYear.put(key, value);
}
    array.add(jsonLastYear);

response.getWriter().write(array.toJSONString());
%>








