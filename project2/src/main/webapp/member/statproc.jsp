<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="statMgr" class="pack.stat.StatMgr" />
<jsp:useBean id="sBean" class="pack.stat.StatBean" />
<jsp:setProperty property="*" name="sBean"/> 

<%
request.setCharacterEncoding("utf-8");
String flag = request.getParameter("flag");  // insertStat 폼의 쿼리스트링의 키값

// 최근 한 달 설정
LocalDate curDate = LocalDate.now();
LocalDate monthAgo = curDate.minusMonths(1);

boolean result = false;

if(flag.equals("insert")) {
    result = statMgr.statInsert(sBean);
} else if (flag.equals("update")) {
    result = statMgr.statUpdate(sBean);
} else if (flag.equals("delete")) {
    result = statMgr.statDelete(request.getParameter("code"));   // 폼에서 전달된 code 값 사용
} else {
    response.sendRedirect("stat_test.jsp");
}

if(result) {
    if(flag.equals("update") || flag.equals("insert")) {		
%>
        <script type="text/javascript">
            alert('정상 처리되었습니다.');
            window.close();
        </script>
<%	} else { %>
        <script type="text/javascript">
            alert('정상 처리되었습니다.');
            location.href="statistic.jsp?start_date=<%=monthAgo%>&end_date=<%=curDate%>&sort=asc&column=stat_code";
        </script>
<%
    }
} else {
    if(flag.equals("update") || flag.equals("insert")) {		
%>
        <script type="text/javascript">
            alert('오류 발생!');
            history.back();
        </script>
<%	} else { %>
        <script type="text/javascript">
            alert('오류 발생!');
            location.href="statistic.jsp?start_date=<%=monthAgo%>&end_date=<%=curDate%>&sort=asc&column=stat_code";
        </script>
<%
    }
}
%>
