<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원가입</title>
	</head>
	<body>
		<h2>회원가입</h2>
		<form action="member" method="post">
			<label>아이디</label>
			<input type="text" name="id"><br/>
			<label>패스워드</label>
			<input type="text" name="pw"><br/>
			<label>이름</label>
			<input type="text" name="name"><br/>
			<label>전화번호</label>
			<input type="text" name="phone"><br/>
			<label>성별</label><br/>
			<input type="radio" id="man" name="gender" value="man">
			<label for="man">남자</label>
			<input type="radio" id="woman" name="gender" value="woman">
			<label for="woman">여자</label>
			<br/>
			<label>취미</label><br/>
			<input type="checkbox" id="game" name="hobby" value="game">
			<label for="game">게임</label>
			<input type="checkbox" id="sing" name="hobby" value="sing">
			<label for="sing">노래</label>
			<input type="checkbox" id="health" name="hobby" value="health">
			<label for="health">헬스</label>
			<input type="checkbox" id="piano" name="hobby" value="piano">
			<label for="piano">피아노</label>
			<input type="checkbox" id="soccer" name="hobby" value="soccer">
			<label for="soccer">축구</label>
			<br/>
			<input type="submit" value="회원가입">
		</form>
		<div>
			<a href="/">메인페이지 이동</a>
		</div>
	</body>
</html>