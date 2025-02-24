<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원정보수정</title>
	</head>
	<body>
		<h2>회원정보수정</h2>
		<form action="memupdate" method="post">
			<label>아이디</label>
			<input type="text" name="id" value="${mdto.id}" readonly><br/>
			<label>패스워드</label>
			<input type="text" name="pw" value="${mdto.pw}"><br/>
			<label>이름</label>
			<input type="text" name="name" value="${mdto.name}"><br/>
			<label>전화번호</label>
			<input type="text" name="phone" value="${mdto.phone}"><br/>
			<label>성별</label><br/>
			<input type="radio" id="man" name="gender" value="man" ${(fn:contains(mdto.gender,'man'))?'checked':''}>
			<label for="man">남자</label>
			<input type="radio" id="woman" name="gender" value="woman" ${(fn:contains(mdto.gender,'woman'))?'checked':''}>
			<label for="woman">여자</label>
			<br/>
			<label>취미</label><br/>
			<input type="checkbox" id="game" name="hobby" value="game" ${(fn:contains(mdto.hobby,'game'))?'checked':'' }>
			<label for="game">게임</label>
			<input type="checkbox" id="sing" name="hobby" value="sing" ${(fn:contains(mdto.hobby,'sing'))?'checked':'' }>
			<label for="sing">노래</label>
			<input type="checkbox" id="health" name="hobby" value="health" ${(fn:contains(mdto.hobby,'health'))?'checked':'' }>
			<label for="health">헬스</label>
			<input type="checkbox" id="piano" name="hobby" value="piano" ${(fn:contains(mdto.hobby,'piano'))?'checked':'' }>
			<label for="piano">피아노</label>
			<input type="checkbox" id="soccer" name="hobby" value="soccer" ${(fn:contains(mdto.hobby,'soccer'))?'checked':'' }>
			<label for="soccer">축구</label>
			<br/>
			<input type="submit" value="회원정보수정">
		</form>
		<div>
			<a href="/">메인페이지 이동</a>
		</div>
	</body>
</html>