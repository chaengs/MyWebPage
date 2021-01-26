<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>/users/signup_form.jsp</title>
    <jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../include/navbar.jsp"></jsp:include>
<div class="container">
    <h3>회원 가입</h3>
    <!--
        [ novalidate 로 웹브라우저 자체의 검증기능 사용하지 않기 ]
        <input type="email" />  같은경우 웹브라우저가 직접 개입하기도 한다.
        해당기능 사용하지 않기 위해서는 novalidate 를 form 에 명시해야 한다.
     -->
    <form action="signup.jsp" method="post" id="myForm" novalidate>
        <div class="form-group">
            <label for="id">아이디</label>
            <input class="form-control" type="text" name="id" id="id"/>
            <small class="form-text text-muted">영소문자로 5-10글자 사이의 아이디를 입력하세요.</small>
            <div class="invalid-feedback">사용할수 없는 아이디 입니다</div>
        </div>
        <div class="form-group">
            <label for="pwd">비밀번호</label>
            <input class="form-control" type="password" name="pwd" id="pwd"/>
            <small class="form-text text-muted">5-10글자 사이로 입력하세요.</small>
            <div class="invalid-feedback">비밀번호를 확인 하세요</div>
        </div>
        <div class="form-group">
            <label for="pwd2">비밀번호 확인</label>
            <input class="form-control" type="password" id="pwd2"/>
        </div>
        <div class="form-group">
            <label for="email">이메일</label>
            <input class="form-control" type="email" name="email" id="email"/>
            <div class="invalid-feedback">이메일 형식을 확인 하세요.</div>
        </div>
        <button class="btn btn-outline-primary" type="submit">가입</button>
    </form>
</div>
<script>
    //아이디, 비번, 이메일 정규표현식
    let reg_id=/^[a-z].{4,9}$/;
    let reg_pwd=/^.{5,10}$/;
    let reg_email=/@/;

    let isIdValid=false;
    let isPwdValid=false;
    let isEmailValid=false;
    let isFormValid=false;

    $("#myForm").on("submit", function(){
       isFormValid = isIdValid && isPwdValid && isEmailValid;
      if(!isFormValid) {
           return false; ///폼 전송 막기
        }
    });

    //이메일 입력할 때 실행할 함수
    $("#email").on("input", function (){
        let inputEmail = $("#email").val();

        $("#email").removeClass("is-valid is-invalid");
        if(!reg_email.test(inputEmail)){
            isEmailValid = false;
            $("#email").addClass("is-invalid");
        }else{
            isEmailValid = true;
            $("#email").addClass("is-valid");
        }
    });

    $("#pwd, #pwd2").on("input", function(){
        let pwd=$("#pwd").val();
        let pwd2=$("#pwd2").val();

        $("#pwd").removeClass("is-valid is-invalid");
        if(!reg_pwd.test(pwd)){
            $("#pwd").addClass("is-invalid");
            isPwdValid = false;
            return;
        }

        if(pwd==pwd2){//만일 같으면
            $("#pwd").addClass("is-valid");
            isPwdValid=true;
        }else{
            $("#pwd").addClass("is-invalid");
            isPwdValid=false;
        }
    });

    //아이디 입력란에 입력했을때 실행할 함수 등록
    $("#id").on("input", function(){
        let inputId=$("#id").val();
        $("#id").removeClass("is-valid is-invalid");
        if(!reg_id.test(inputId)){
            $("#id").addClass("is-invalid");
            isIdValid=false;
            return;
        }
        $.ajax({
            url:"checkid.jsp",
            method:"GET",
            data:"inputId="+inputId,
            success:function(responseData){
                /*
                    checkid.jsp 페이지에서 응답할때
                    contentType="application/json" 이라고 설정하면
                    함수의 인자로 전달되는 responseData 는 object 이다.
                    {isExist:true} or {isExist:false}
                    형식의 object 이기 때문에 바로 사용할수 있다.
                */
                console.log(responseData);
                if(responseData.isExist){//이미 존재하는 아이디인 경우
                    $("#id").addClass("is-invalid");
                    isIdValid=false;
                }else{
                    $("#id").addClass("is-valid");
                    isIdValid=true;
                }
            }
        });
    });
</script>
</body>
</html>