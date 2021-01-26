<nav>
    <ul class="breadcrumb">
        <li class="breadcrumb-item">
            <a href="${pageContext.request.contextPath }/">Home</a>
        </li>
        <li class="breadcrumb-item <%=thisPage.equals("cafe") ? "active" : "" %>">
            <a href="${pageContext.request.contextPath}/file/list.jsp">자료실 목록</a>
        </li>
    </ul>
</nav>