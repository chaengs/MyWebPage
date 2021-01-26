<%@ page import="test.users.dto.UsersDto" %>
<%@ page import="test.users.dao.UsersDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String id=(String)session.getAttribute("id");

    String pwd=request.getParameter("pwd");
    String newPwd=request.getParameter("newPwd");

    UsersDto dto=new UsersDto();
    dto.setId(id);
    dto.setPwd(pwd);
    dto.setNewPwd(newPwd);
    boolean isSuccess= UsersDao.getInstance().updatePwd(dto);
%>
<html>
<head>
    <title>/users/private/pwd_update.jsp</title>
</head>
<body>
<script>
    <%if(isSuccess){
        session.removeAttribute("id");%> //로그아웃
        alert("비밀번호를 수정했습니다.");
        location.href = "${pageContext.request.contextPath}users/loginform.jsp";
    <%}else{ %>
        alert("기존 비밀번호가 일치하지 않습니다.");
        location.href = "${pageContext.request.contextPath}/users/private/pwd_updateform.jsp"
    <%} %>
</script>
</body>
</html>
