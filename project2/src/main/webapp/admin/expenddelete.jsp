<%@page import="pack.expend.ExpendMgr"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    ExpendMgr expendMgr = new ExpendMgr();
    request.setCharacterEncoding("UTF-8");

    String code = request.getParameter("expend_code");
    String confirm = request.getParameter("confirm");
    
    boolean dataDeleted = false;

    if (code != null && "yes".equals(confirm)) {
        boolean deleted = expendMgr.deleteExpend(Integer.parseInt(code));

        if (deleted) {
            dataDeleted = true;
        } else {
            out.println("<p>데이터 삭제에 실패했습니다.</p>");
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>지출내역 삭제</title>
    <link href="../css/income_expend.css" rel="stylesheet" type="text/css">
    <script type="text/javascript">
        function closeWindow() {
            window.opener.location.reload();
            window.close();
        }
        
        function submitForm() {
            document.getElementById('deleteForm').submit();
        }
    </script>
</head>
<body class="expend-delete-page">
    <div class="expend-container">
        <% if (dataDeleted) { %>
        <div class="success-message">
            데이터가 성공적으로 삭제되었습니다.
        </div>
        <div class="button-container">
            <input type="button" class="btnexpendadd" value="닫기" onclick="closeWindow()">
        </div>
        <% } else { %>
        <h2>정말 삭제하시겠습니까?</h2>
        <form id="deleteForm" action="expenddelete.jsp" method="post">
            <input type="hidden" name="expend_code" value="<%= code %>">
            <input type="hidden" name="confirm" value="yes">
            <div class="button-container">
                <input type="button" class="btnexpendadd" value="삭제" onclick="submitForm()">
                <input type="button" class="btnexpendadd" value="취소" onclick="closeWindow()">
            </div>
        </form>
        <% } %>
    </div>
</body>
</html>
