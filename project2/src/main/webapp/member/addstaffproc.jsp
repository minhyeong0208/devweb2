<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <!-- 페이지 설정 -->
<% 
request.setCharacterEncoding("utf-8"); // 요청 인코딩을 UTF-8로 설정
%>
    
<jsp:useBean id="staffMgr" class="pack.staff.StaffMgr" /> <!-- StaffMgr 빈 사용 -->
<jsp:useBean id="sbean" class="pack.staff.StaffBean" /> <!-- StaffBean 빈 사용 -->
<jsp:setProperty property="*" name="sbean"/> <!-- 요청 파라미터를 StaffBean 객체의 속성에 설정 -->

<%
String flag = request.getParameter("flag");  // 폼의 쿼리스트링에서 flag 파라미터 값을 가져옴
boolean result = false; // 작업 결과를 저장할 변수 초기화

// flag 값에 따라 삽입, 수정, 삭제 작업 수행
if(flag.equals("insert")) {
   result = staffMgr.staffInsert(sbean); // 스태프 삽입
} else if (flag.equals("update")) {
   result = staffMgr.staffUpdate(sbean); // 스태프 수정
} else if (flag.equals("delete")) {
   result = staffMgr.staffDelete(sbean.getCode()); // 스태프 삭제
} else {
   response.sendRedirect("addstaffinfo.jsp"); // 잘못된 접근 시 리다이렉트
}

// 작업 결과에 따라 알림 메시지 및 페이지 이동
if(result) { // 작업이 성공한 경우
   if(flag.equals("update") || flag.equals("insert")) {      
%>
      <script type="text/javascript">
         alert('정상 처리되었습니다.'); // 성공 알림
         window.close(); // 창 닫기
         location.href="addstaffinfo.jsp"; // 페이지 이동
      </script>
<%   } else { %>
      <script type="text/javascript">
         alert('정상 처리되었습니다.'); // 성공 알림
         window.close(); // 창 닫기
         location.href="addstaffinfo.jsp"; // 페이지 이동
      </script>
<%
   }
} else { // 작업이 실패한 경우
   if(flag.equals("update") || flag.equals("insert")) {      
%>
      <script type="text/javascript">
         alert('스태프 추가 실패'); // 실패 알림
         history.back(); // 이전 페이지로 돌아가기
      </script>
<%   } else { %>
      <script type="text/javascript">
         alert('스태프 수정 실패'); // 실패 알림
         location.href="addstaffinfo.jsp"; // 페이지 이동
      </script>
<%
   }
}
%>
