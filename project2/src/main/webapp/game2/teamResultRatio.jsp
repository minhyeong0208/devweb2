<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="gameMemberMgr" class="pack.game_member2.GameMemberMgr" />
<jsp:useBean id="memberMgr" class="pack.member.MemberMgr" />
<jsp:useBean id="memberDto" class="pack.member.MemberDto" />

<%
// 해당 ID 유저 소속팀 (올해) 승, 무, 패 JSON - 도넛 차트

int thisYear = java.time.LocalDate.now().getYear();

// 현재 로그인한 사용자 세션값 가져오기
String id = (String) session.getAttribute("idKey");
//String id = "user1"; // 확인용

// 해당 유저 팀코드 확인
memberDto = memberMgr.getMember(id);
String teamcode = memberDto.getTeamcode();

// 승무패 수 가져오기
HashMap<String, Integer> mapResultRatio = gameMemberMgr.getResultRatio(thisYear, teamcode);


JSONObject jsonResultRatio = new JSONObject();


// Map to JSON
for(String key : mapResultRatio.keySet()) {
    int value = mapResultRatio.get(key);
    jsonResultRatio.put(key, value);
}



response.getWriter().write(jsonResultRatio.toJSONString());
%>








