<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String thisPage = request.getParameter("thisPage");
    if(thisPage == null){
        thisPage = "";
    }
%>
<nav class="navbar navbar-light navbar-expand-sm fixed-top" style="background-color: #EFBAD6">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath }/">
            <img style="width:35px;height:35px" src="c:\users\shim\desktop\arong.png"> 아롱
        </a>
        <button class="navbar-toggler" data-toggle="collapse" data-target="#topNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="topNav">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item <%=thisPage.equals("cafe") ? "active" : "" %>">
                    <a class="nav-link" href="${pageContext.request.contextPath }/cafe/list.jsp">게시판</a>
                </li>
                <li class="nav-item <%=thisPage.equals("file") ? "active" : "" %>">
                    <a class="nav-link" href="${pageContext.request.contextPath }/file/list.jsp">자료실</a>
                </li>
                <li class="nav-item <%=thisPage.equals("gallery") ? "active" : ""%>">
                    <a class="nav-link" href="${pageContext.request.contextPath }/gallery/list.jsp">사진관</a>
                </li>
            </ul>
            <%
                //로그인된 아이디가 있는지 읽어와 본다.
                String id=(String)session.getAttribute("id");
            %>
            <%if(id==null){ %>
            <a class="btn btn-sm" style="background-color: #DADAFC"
               href="${pageContext.request.contextPath }/users/loginform.jsp">로그인</a>
            <a class="btn btn-sm ml-1" style="background-color: #DADAFC"
               href="${pageContext.request.contextPath }/users/signupform.jsp">회원가입</a>
            <%}else{ %>
            <span class="navbar-text">
					<a href="${pageContext.request.contextPath }/users/private/info.jsp"><%=id %></a>
					<a class="btn btn-sm" href="${pageContext.request.contextPath }/users/logout.jsp" style="background-color: #DADAFC">로그아웃</a>
				</span>
            <%} %>
        </div>
    </div>
</nav>