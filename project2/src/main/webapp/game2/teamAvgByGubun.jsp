<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="gameMemberMgr" class="pack.game_member2.GameMemberMgr" />
<jsp:useBean id="memberMgr" class="pack.member.MemberMgr" />
<jsp:useBean id="memberDto" class="pack.member.MemberDto" />

<%
// (올해) 구분별 통계 수치 - JSON으로
int thisYear = java.time.LocalDate.now().getYear();
int lastYear = thisYear - 1;

// 현재 로그인한 사용자 세션값 가져오기
String id = (String) session.getAttribute("idKey");
//String id = "user1"; // 확인용

// 해당 유저 팀코드 확인
memberDto = memberMgr.getMember(id);
String teamcode = memberDto.getTeamcode();

// 구분별 통계값 가져오기
HashMap<String, Double> mapHome = gameMemberMgr.getAvgByGubun(thisYear, teamcode); // 홈
HashMap<String, Double> mapAway = gameMemberMgr.getAvgByGubun(thisYear, teamcode); // 원정

// 가져온 통계데이터 JSON 객체 생성
JSONArray array = new JSONArray();
JSONObject json_home = new JSONObject();
JSONObject json_away = new JSONObject();

// Map to JSON
// home
for(String key : mapHome.keySet()) {
    double value = mapHome.get(key);
    json_home.put(key, value);
}
    array.add(json_home);

// away
for(String key : mapAway.keySet()) {
    double value = mapAway.get(key);
    json_away.put(key, value);
}
    array.add(json_away);

response.getWriter().write(array.toJSONString());
%>