<%@ page import="test.users.dto.UsersDto" %>
<%@ page import="test.users.dao.UsersDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String id=(String)session.getAttribute("id"); // session scope
    String email=request.getParameter("email"); // form 전송
    UsersDto dto=new UsersDto();
    dto.setId(id);
    dto.setEmail(email);

    boolean isSuccess = UsersDao.getInstance().update(dto);
%>
<html>
<head>
    <title>/users/private/update.jsp</title>
</head>
<body>
<script>
    <%if(isSuccess){%>
        alert("수정 했습니다.");
        location.href="${pageContext.request.contextPath}users/private/info.jsp";
    <%}else{%>
        alert("수정실패");
        location.href="${pageContext.request.contextPath}/users/private/updateform.jsp";
    <%}%>
</script>
</body>
</html>
