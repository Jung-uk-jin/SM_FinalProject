<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="../css/Main_recommend_button.css?v=Y" />
<script type="text/javascript" src="../js/Main_recommend_button.js"></script>
<!DOCTYPE html>
<html>
<head>
    <title>Artist Recommendation</title>
</head>
<style>
        #artistForm {
            display: none;  /* 검색창 숨기기 */
        }
        h2{font-size: 18px; margin-left: 10px; font-weight: 600;} 
    </style>
<body>
    
    <!-- 검색 입력 폼 -->
    <form action="/" method="post" id="artistForm">
        <input type="text" id="artistName" name="artistName" required>
    </form>

    <h2>메인페이지(아티트스 추천)</h2>
    
    <!-- 아티스트 리스트 (이미지 클릭 시 자동으로 검색어 입력) -->
    <div class="artist-list">
        <div class="artist" onclick="setArtistName('슈퍼주니어')">
            <img src="/images/1.jpg" alt="슈퍼주니어" style="width: 70px; height: 70px;">
            <p>슈퍼주니어</p>
        </div>
        <div class="artist" onclick="setArtistName('SEVENTEEN')">
            <img src="/images/1.jpg" alt="세븐틴" style="width: 70px; height: 70px;">
            <p>SEVENTEEN</p>
        </div>
        <div class="artist" onclick="setArtistName('BTS')">
            <img src="/images/1.jpg" alt="BTS" style="width: 70px; height: 70px;">
            <p>BTS</p>
        </div>
        <div class="artist" onclick="setArtistName('뉴진스')">
            <img src="/images/1.jpg" alt="뉴진스" style="width: 70px; height: 70px;">
            <p>뉴진스</p>
        </div>
        <div class="artist" onclick="setArtistName('이세계아이돌')">
            <img src="/images/1.jpg" alt="이세계아이돌" style="width: 70px; height: 70px;">
            <p>이세계아이돌</p>
        </div>
        <!-- 여기에 더 많은 아티스트를 추가 -->
    </div>

    <script>
        // 클릭된 아티스트 이름을 입력창에 자동으로 채워주는 함수
        function setArtistName(artistName) {
            document.getElementById('artistName').value = artistName;
            document.getElementById('artistForm').submit(); // 폼을 자동으로 제출
        }
    </script>

    <button id="openModalButton" class="circle-button">+</button>
		<div id="modal" class="modal">
		  <div class="modal-content">
		    <span class="close-btn">&times;</span>
		    <h2>추천 아티스트</h2>
		    <!-- 여기에 추천 아티스트 목록 등 내용 추가 -->
		        <div>
			        <ul>
			            <c:if test="${not empty recommendations}">
			                <c:forEach var="artist" items="${recommendations}">
			                    <li>
			                        <span>${artist.name}</span>
			                        <img src="${artist.imagePath}" alt="${artist.name}">
			                    </li>
			                </c:forEach>
			            </c:if>
			        </ul>
			    </div>
		  </div>
		</div>
		    

	</body>
</html>