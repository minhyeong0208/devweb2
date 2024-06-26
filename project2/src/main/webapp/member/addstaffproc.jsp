<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
request.setCharacterEncoding("utf-8");
%>
    
<jsp:useBean id="staffMgr" class="pack.staff.StaffMgr" />
<jsp:useBean id="sbean" class="pack.staff.StaffBean" />
<jsp:setProperty property="*" name="sbean"/> <!-- 이걸로 setting을 해야 빈 객체에서 값을 가져올 수 있는 듯? -->

<%
String flag = request.getParameter("flag");  // insertStat 폼의 쿼리스트링의 키값
boolean result = false;


if(flag.equals("insert")) {
   result = staffMgr.staffInsert(sbean);
} else if (flag.equals("update")) {
   result = staffMgr.staffUpdate(sbean);
} else if (flag.equals("delete")) {
   result = staffMgr.staffDelete(sbean.getCode());
} else {
   response.sendRedirect("addstaffinfo.jsp");
}

if(result) {
   if(flag.equals("update") || flag.equals("insert")) {      
%>
      <script type="text/javascript">
         alert('정상 처리되었습니다.');
         window.close();
         location.href="addstaffinfo.jsp";
      </script>
<%   } else { %>
      <script type="text/javascript">
         alert('정상 처리되었습니다.');
         window.close();
         location.href="addstaffinfo.jsp";
      </script>
<%
   }
} else {
   if(flag.equals("update") || flag.equals("insert")) {      
%>
      <script type="text/javascript">
         alert('스태프 추가 실패');
         history.back();
      </script>
<%   } else { %>
      <script type="text/javascript">
         alert('스태프 수정 실패');
         location.href="addstaffinfo.jsp";
      </script>
<%
   }
}
%>
