<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    String id=request.getParameter("id");
    String pwd=request.getParameter("pwd");
    String email=request.getParameter("email");

    UsersDto dto=new UsersDto();
    dto.setId(id);
    dto.setPwd(pwd);
    dto.setEmail(email);
    boolean isSuccess=UsersDao.getInstance().insert(dto);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>/users/signup.jsp</title>
</head>
<body>
<script>
    <%if(isSuccess){%>
        alert("가입되었습니다.");
        location.href="${pageContext.request.contextPath}/";
    <%}else{%>
        alert("가입에 실패했습니다.");
        location.href="${pageContext.request.contextPath}/users/signupform.jsp";
    <%}%>
</script>
</body>
</html>