<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>/users/loginform.jsp</title>
    <jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../include/navbar.jsp"></jsp:include>
<%
    String url = request.getParameter("url");
    if(url == null){
        String cPath = request.getContextPath();
        url = cPath + "/index.jsp";
    }
%>
<div class="container">
    <h1>로그인</h1>
    <form action="${pageContext.request.contextPath}/users/login.jsp" method="post">
        <input type="hidden" name="url" value="${url}">
        <div class="form-group">
            <label for="id">아이디</label>
            <input type="text" class="form-control" name="id" id="id">
        </div>
        <div class="form-group">
            <label for="pwd">비밀번호</label>
            <input type="text" class="form-control" name="pwd" id="pwd">
        </div>
        <button  class="btn btn-outline-primary" type="submit">로그인</button>
    </form>
</div>
</body>
</html>
