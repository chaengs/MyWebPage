<%@ page import="java.net.URLEncoder" %>
<%@ page import="test.users.dto.UsersDto" %>
<%@ page import="test.users.dao.UsersDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String url = request.getParameter("url");
    String encodedUrl = URLEncoder.encode(url);

    String id = request.getParameter("id");
    String pwd=request.getParameter("pwd");
    UsersDto dto=new UsersDto();
    dto.setId(id);
    dto.setPwd(pwd);

    boolean isValid = UsersDao.getInstance().isValid(dto);
%>
<html>
<head>
    <title>/users/login.jsp</title>
</head>
<body>
<script>
    <%if(isValid){%>
        alert("${id}님 로그인 되었습니다.")
        location.href = "${url}";
    <%}else{%>
        alert("아이디 혹은 비밀번호가 틀렸습니다.")
        location.href = "${pageContext.request.contextPath}/users/loginform.jsp";
    <%}%>
</script>
</body>
</html>
