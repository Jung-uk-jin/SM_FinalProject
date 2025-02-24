<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>가입회원정보</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<style>
			h2{text-align: center;}
			table, th, td{border:1px solid black; border-collapse: collapse;}
			table{width: 800px; text-align: center;}
			th, td{height: 40px;}
		</style>
		<script>
			const deleteBtn = () =>{
				if(confirm("${mdto.id}님을 삭제하시겠습니까?")){
					$.ajax({
						url:"/memdelete",
						type:"post",	
						data:{"id":"${mdto.id}"},
						success:function(data){
							alert("회원정보를 삭제했습니다.");
							location.href="/mlist"
							console.log(data);
						},
						error:function(){
							alert("실패");
						}
					}); // ajax
				}
			}
		</script>
	</head>
	<body>
		<h2>회원가입정보</h2>
		<table>
			<colgroup>
				<col width="15%">
				<col width="15%">
				<col width="15%">
				<col width="15%">
				<col width="15%">
				<col width="*">
			</colgroup>
			<tr>
				<th>아이디</th>
				<th>패스워드</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>성별</th>
				<th>취미</th>
			</tr>
			<tr>
				<td>${mdto.id}</td>
				<td>${mdto.pw}</td>
				<td>${mdto.name}</td>
				<td>${mdto.phone}</td>
				<td>${mdto.gender}</td>
				<td>${mdto.hobby}</td>
			</tr>
		</table>
		<div>
			<a href="/">메인페이지 이동</a>
			<a href="/memupdate?id=${mdto.id}">회원정보수정</a>
			<button onclick="deleteBtn()">회원정보삭제</button>
		</div>
	</body>
</html>