<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>메인페이지</title>
		<script>
		</script>
	</head>
	<body>
		<h2>메인페이지</h2>
		<div>세션아이디 : ${session_id}</div>
		<div>${session_name}님 환영합니다.</div>
		<ul>
			<c:if test="${session_id == null}">
				<li><a href="/login">로그인</a></li>
				<hr>
				<li><a href="/member">회원가입</a></li>
				<li><a href="/mlist">회원정보</a></li>
				<li><a href="/board/blist">게시판</a></li>
				<li><a href="/board/bwrite">글쓰기</a></li>
				<li><a href="/admin">관리자페이지</a></li>
				<li><a href="/table">테이블</a></li>
			</c:if>
			<c:if test="${session_id != null}">
				<li><a href="/member/logout">로그아웃</a></li>
				<hr>
				<li><a href="/member">회원가입</a></li>
				<li><a href="/mlist">회원정보</a></li>
				<li><a href="/board/blist">게시판</a></li>
				<li><a href="/board/bwrite">글쓰기</a></li>
				<li><a href="/admin">관리자페이지</a></li>
			</c:if>
		</ul>
	</body>
</html>