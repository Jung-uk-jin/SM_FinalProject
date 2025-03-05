<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    <title>Weverse Clone</title>
    <link rel="stylesheet" href="/css/login.css">
    <script>
	    if("${param.chkLogin}"=="1"){
			alert("로그인이 되었습니다.");
			location.href="/";
		}else if("${param.chkLogin}"=="0"){
			alert("아이디 또는 비밀번호가 일치하지 않습니다.");
		}
	    </script>
</head>
<body>
    <div class="login-container">
    	<div id="logo">
        	<a href="/"><img src="/images/index_login/logoPink.png" alt="Logo"></a>
        </div>
        <form action="/login" method="POST" name="loginFrm">
            <label for="id">ID</label>
            <input type="id" id="id" name="id" required><br>
            
            <label for="password">Password</label>
            <input type="password" id="password" name="pw" required><br>
            
            <button type="submit">로그인</button>
            <p class="forgot-password"><a href="#">비밀번호를 잊어버리셨나요?</a></p>
        </form>
        <div class="social-login">
            <button class="social-btn kakao"></button>
            <button class="social-btn google"></button>
            <button class="social-btn x"></button>
        </div>
    </div>
    
</body>
</html>
