<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>/users/private/pwd_updateform.jsp</title>
    <jsp:include page="../../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<div class="container">
    <h3>비밀번호 수정</h3>
    <form action="${pageContext.request.contextPath}/users/private/pwd_update.jsp" method="post" id="myForm">
        <div>
            <label for="pwd">기존 비밀번호</label>
            <input type="password" name="pwd" id="pwd"/>
        </div>
        <div>
            <label for="newPwd">새 비밀번호</label>
            <input type="password" name="newPwd" id="newPwd"/>
        </div>
        <div>
            <label for="newPwd2">새 비밀번호 확인</label>
            <input type="password" id="newPwd2"/>
        </div>
        <button type="submit">수정하기</button>
        <button type="reset">취소</button>
    </form>
</div>
<script>
    $("#myForm").on("submit", function(){
        let pwd1 = $("#newPwd").val();
        let pwd2 = $("#newPwd2").val();
        if(pwd1 != pwd2){
            alert("비밀번호를 확인 하세요!");
            event.preventDefault();//폼 전송 막기
        }
    });
</script>
</body>
</html>
