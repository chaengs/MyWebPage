<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String id = (String)session.getAttribute("id");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>index.jsp</title>
    <jsp:include page="include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="include/navbar.jsp"></jsp:include>
<div class="container">
    <h3>카페 글 목록</h3>
    <ul>
        <li><a href="${pageContext.request.contextPath}/cafe/list.jsp">게시판</a></li>
    </ul>
</div>
</body>
</html>
