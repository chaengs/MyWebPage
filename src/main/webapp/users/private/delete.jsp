<%@ page import="test.users.dao.UsersDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String id=(String)session.getAttribute("id");
    UsersDao.getInstance().delete(id);
    session.removeAttribute("id");
%>
<html>
<head>
    <title>/users/private/delete.jsp</title>
</head>
<body>
<script>
    alert("<%=id%>님 탈퇴 처리 되었습니다." );
    location.href = "${pageContext.request.contextPath}/";
</script>
</body>
</html>
