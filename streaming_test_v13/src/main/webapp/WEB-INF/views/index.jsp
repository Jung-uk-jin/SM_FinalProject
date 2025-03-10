<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>메인페이지</title>
		<style>
		   table {
            width: 100%;
            border-collapse: collapse; /* 테이블 셀 간 경계선 합침 */
        }
        th, td {
            border: 1px solid #ddd; /* 셀 경계선 색상 */
            padding: 8px; /* 셀 안쪽 여백 */
            text-align: center; /* 텍스트 가운데 정렬 */
        }
		</style>
		<script>
		</script>
	</head>
	<body>
		<h2>메인페이지</h2>
		<div>세션아이디 : ${session_id}</div>
		<div>${session_name}님 환영합니다.</div>
		<div>아이디는 aaa,bbb ... ,lll까지 있습니다 비번은 1111</div>
		<ul>
			<c:if test="${session_id == null}">
				<li><a href="/login">로그인</a></li>
				<hr>
				<li><a href="/member">회원가입</a></li>
				<li><a href="/mlist">회원정보</a></li>
				<li><a href="/board/blist">게시판</a></li>
				<li><a href="/board/bwrite">글쓰기</a></li>	
			</c:if>
			<c:if test="${session_id != null}">
				<li><a href="/logout">로그아웃</a></li>
				<hr>
				<li><a href="/member">회원가입</a></li>
				<li><a href="/mlist">회원정보</a></li>
				<li><a href="/board/blist">게시판</a></li>
				<li><a href="/board/bwrite">글쓰기</a></li>
				<li><a href="/chatting">채팅</a></li>
				
				<div>-----------------------------------------------</div>
				
				
 		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>							
				<script>
				$(document).ready(function() {
				    $(".idol").click(function() {
				        var idolName = $(this).text();  // 클릭한 아이돌 이름 가져오기
				        
				        $.ajax({
				            url: "/getRelatedArtists",
				            type: "POST",
				            contentType: "application/json",
				            data: JSON.stringify({ name: idolName }),
				            success: function(response) {
				                $("#recommendations").empty();
				                response.forEach(function(artist) {
				                    $("#recommendations").append("<li>" + artist.name + "</li>");
				                });
				            },
				            error: function() {
				                alert("데이터를 불러오는데 실패했습니다.");
				            }
				        });
				    });
				});
				</script>
				
				<ul>
				    <li class="idol">뉴진스</li>
				    <li class="idol">아이브</li>
				    <li class="idol">르세라핌</li>
				    <li class="idol">이세계아이돌</li>
				</ul>
				
				<h3>추천 아이돌</h3>
				<ul id="recommendations"></ul>

			</c:if>
		</ul>
	</body>
</html>