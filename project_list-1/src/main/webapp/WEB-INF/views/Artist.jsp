<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ONF 그룹</title>
<style>

/* ===== 기본 스타일 ===== */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Noto Sans KR', sans-serif;
}

body {
    background-color: #121212;
    color: white;
    text-align: center;
}

/* ===== 네비게이션 바 ===== */
.navbar {
    width: 100%;
    background: #121212;
    padding: 15px 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.navbar .logo {
    margin-left: 40px;
    font-size: 1.5rem;
    font-weight: bold;
}

.navbar .logo a {
    text-decoration: none;
    color: #00aaff;
}

.navbar .menu {
    margin-right: 40px;
    display: flex;
    gap: 15px;
}

.menu a, .menu button {
    text-decoration: none;
    font-size: 1rem;
    background: none;
    border: none;
    cursor: pointer;
    font-family: inherit;
    color: #00aaff;
}

/* ===== 메인 컨텐츠 ===== */
.section {
    max-width: 1200px;
    margin: 0 auto;
    text-align: center;
}

.container {
    width: 80%;
    margin: 0 auto;
    padding: 20px;
    position: relative;
}

/* 메인 이미지 섹션 */
.main-image {
    position: relative;
    display: inline-block;
    width: 100%;
    max-width: 1000px;
}

.main-image img {
    width: 100%;
    border-radius: 10px;
    display: block;
}

/* 이미지 내부 ONF 문구 */
.group-text {
    position: absolute;
    bottom: 20px;
    left: 50%;
    transform: translateX(-50%);
    font-size: 76px;
    font-weight: bold;
    color: white;
    text-shadow: 4px 4px 10px rgba(0, 0, 0, 0.9);
    padding: 5px 15px;
    border-radius: 8px;
    width:100%;
}

/* 그라데이션 효과 */
.image::after {
    content: "";
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 30%;
    background: linear-gradient(to top, rgba(0, 0, 0, 0.8), rgba(0, 0, 0, 0));
    border-radius: 10px;
}

/* ===== 프로필 섹션 ===== */
.profile-section {
    text-align: left;
    margin-top: 40px;
}

.profile-images {
    display: flex;
    gap: 15px;
    justify-content: center;
    flex-wrap: nowrap;
    overflow-x: auto;
    padding-bottom: 10px;
}

.profile-item {
    display: flex;
    width: 100px;
    flex-direction: column;
    align-items: center;
    text-align: center;
    overflow: hidden;
}

.profile-item img {
    width: 100px;
    height: 100px;
    border-radius: 30px;
    object-fit: cover;
}

.profile-item p {
    margin-top: 5px;
    font-size: 12px;
    font-weight: bold;
    color: white;
}

/* ===== 미디어 섹션 ===== */
.media-section {
    text-align: left;
    margin-top: 50px;
    margin-bottom: 200px;
}

.media-videos {
    display: flex;
    gap: 15px;
}

.media-video {
    display: inline-block;
    text-align: center;
    width: 280px; height: 150px;
    overflow: hidden;
    border-radius: 15px;
    margin-bottom: 10px;
}

.media-video img {
    width: 100%;
    height: 150px;
    transition: transform 0.3s ease-in-out;
    display: inline-block; /* 변경 */
    
    
}

.media-video:hover img {
    transform: scale(1.1);
}	

.media-texts {
    display: flex;
    gap: 15px;
}

.media-text {
    display: inline-block;
    text-align: center;
    width: 280px; height: 30px;
    overflow: hidden;
}

.community-button {
  position: fixed;
  bottom: 20px;
  right: 20px;
  background-color: #ffffff;
  color: #000;
  padding: 10px 20px;
  border-radius: 20px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  font-weight: bold;
  text-decoration: none;
}
.community-button a {
  color: inherit;
  text-decoration: none;
}
   /* 모달 스타일 */
    .modal {
        display: none;
        position: fixed;
        z-index: 1000;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        justify-content: center;
        align-items: center;
    }
    .modal-content {
        background: white;
        width: 500px;
        height: 200px;
        padding: 20px;
        border-radius: 10px;
        text-align: center;
        overflow-y: auto;
        max-height: 80vh;
    }
    .modal-content textarea {
        display: block;
        width: 90%;
        height: 72%;
        resize: none;
        font-size: 16px;
        margin: 0 auto;
    }
    .modal-footer {
        display: flex;
        justify-content: space-between;
        margin-top: 10px;
    }
    .close-btn, .submit-btn {
        padding: 10px 15px;
        border: none;
        cursor: pointer;
        font-size: 14px;
        border-radius: 5px;
    }
    .close-btn { background: #ccc; }
    .submit-btn { background: #007bff; color: white; }
    .modal-header {
        position: sticky;
        top: 0;
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 15px;
        background-color: white;
        border-bottom: 1px solid #ddd;
        z-index: 1000;
    }

</style>
</head>
<body>
    <!-- 네비게이션 바 -->
    <div class="navbar">
        <div class="logo"><a href="/">A&F</a></div>
        <div class="menu">
            <button onclick="location.href='#'">sign</button>
            <button onclick="location.href='#'">알림</button>
            <button onclick="location.href='#'">스토어</button>
        </div>
    </div>
    
<div class = section>
    <!-- 메인 이미지 섹션 -->
    <div class="container">
        <div class="main-image">
            <img src="images/${adto.artist_group_image}" alt="ONF 그룹 사진">
            <div class="group-text">${adto.artist_group_name}</div> <!-- 이미지 내부 텍스트 -->
        </div>
        
<br>
<br>
<br>
<br>

        <!-- 프로필 섹션 -->
   <div class="profile-section">
    <h2 style="text-align: left;">프로필</h2>
    <br>
    <div class="profile-images" style="display:flex;">  
    	<c:forEach items="${list}" var="amdto">
	        <div class="profile-item" style="width : 100px; overflow:hidden; margin-right: 10px;">
	            <a href="#"><img src="images/${amdto.artistmember_image}" alt="멤버1" style="width : 100px; border-radius: 30px; "></a>
	            <p>${amdto.artistmember_name}</p>
	        </div>
    	</c:forEach>  
        
        <!-- 
        <div class="profile-item" style="width : 100px; overflow:hidden; margin-right: 10px; ">
            <a href="#"><img src="images/현빈.jpeg" alt="멤버1" style="width : 100px; border-radius: 30px;"></a>
            <p>현빈</p>
        </div>
        <div class="profile-item" style="width : 100px; overflow:hidden; margin-right: 10px; ">
            <a href="#"><img src="images/진혁.jpeg" alt="멤버2" style="width : 100px; border-radius: 30px;"></a>
            <p>진혁</p>
        </div>
        <div class="profile-item" style="width : 100px; overflow:hidden; margin-right: 10px;">
           <a href="#"><img src="images/윤.jpeg" alt="멤버3" style="width : 100px; border-radius: 30px;"></a>
            <p>윤</p>
        </div>
        <div class="profile-item" style="width : 100px; overflow:hidden; margin-right: 10px;">
            <a href="#"><img src="images/연우.jpeg" alt="멤버4" style="width : 100px; border-radius: 30px;"></a>
            <p>연우</p>
        </div>
        <div class="profile-item" style="width : 100px; overflow:hidden; margin-right: 10px;">
            <a href="#"><img src="images/시윤.jpeg" alt="멤버5" style="width : 100px; border-radius: 30px;"></a>
            <p>시윤</p>
        </div>
         -->
    </div>
</div>

<br>
<br>

		<!-- 미디어 -->
   	<div class="media-section">
	    <h2 style="text-align: left;">미디어</h2>
	    <br>
	    <div class="media-videos" style="display:flex;">
	        <div class="media-video">
			  <img src="/images/isedol.png" alt="미디어1">
			</div>
	        <div class="media-video">
			  <img src="/images/isedol.png" alt="미디어2">
			</div>
	        <div class="media-video">
			  <img src="/images/isedol.png" alt="미디어3">
			</div>
	    </div>
	    <div class="media-texts" style="display:flex;" >
	   	  <div class="media-text" style="text-align: center;">
		 	 <p>미디어1</p>
	   	  </div>
	   	  <div class="media-text" style="text-align: center;">
		 	 <p>미디어2</p>
	      </div>
	   	  <div class="media-text" style="text-align: center;">
		 	 <p>미디어3</p>
	   	  </div>
	    </div>
	</div>

    </div>
</div>

<div class="community-button" onclick="openModal()">
  커뮤니티 바로가기
</div>

<!-- <a href="/fancommunity?artist_no=${adto.artist_no}"></a> -->

   <!-- 2번: 모달 창 -->
   <div id="postModal" class="modal">
       <div class="modal-content">
           <form action="/nickname" method="post">
	           <textarea placeholder="사용하실 닉네임을 입력하세요..." name="nickname_name"></textarea>
	           <input type="hidden" name="artistDto.artist_no" value="${adto.artist_no}">
	           <input type="hidden" name="memberDto.member_nickname" value="chrislee77">
	           <div class="modal-footer">
	               <button type="button" class="close-btn" onclick="closeModal()">닫기</button>
		    	</div>
	            <button class="submit-btn">등록</button>
           </form>
        </div>
    </div>


	    <script>
	        function openModal() {
	            document.getElementById("postModal").style.display = "flex";
	        }
	        function closeModal() {
	            document.getElementById("postModal").style.display = "none";
	        }
		</script>
</body>
</html>
