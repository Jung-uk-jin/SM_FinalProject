<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <link rel="stylesheet" href="css/community.css">
    <title>슬라이드 게시글</title>
<style>
    /* 기본 스타일 */
      body {
      margin: 0;
      padding: 0;
      font-family: Arial, sans-serif;
    }
    .post-box, .post-input {
        display: flex;
        align-items: center;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 20px;
        width: 700px;
    }
    .post-box img, .post-header img, .profile-img {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        margin-right: 10px;
    }
    .profile-img { width: 30px; height: 30px; }
    input[type="text"] {
        flex: 1;
        border: none;
        outline: none;
        font-size: 14px;
    }
    .file-buttons {
        display: flex;
        gap: 10px;
    }
    .file-buttons img {
        width: 32px;
        height: 32px;
        cursor: pointer;
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
        width: 700px;
        height: 500px;
        padding: 0 20px 20px 20px;
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
/* 네비게이션 스타일 */
.navbar {
    width: 100%;
    background: white;
    padding: 15px 20px;
    display: flex;
    justify-content: center; /* 가운데 정렬 */
    align-items: center;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.nav-bar { 
    background-color: #F5C3B2; 
    padding: 10px 0; 
}

.navbar .logo {
    font-size: 1.5rem;
    font-weight: bold;
}



.nav-menu {
    display: flex;
    justify-content: center;
    align-items: center;
    list-style: none;
    padding: 0;
    margin: 0;
    height: 30px;
}

.nav-item { margin: 0 30px; } /* 너무 넓었던 간격 줄임 */

.menu a, .menu button, .nav-link {
    text-decoration: none;
    font-size: 1rem;
    background: none;
    border: none;
    cursor: pointer;
    font-family: inherit;
}

.nav-link {
    color: white !important;
    font-weight: 600;
    padding: 5px 10px;
    position: relative;
}

.nav-link:hover { color: lightgray !important; }

    /* 레이아웃 스타일 */
    .container {
        display: flex;
        max-width: 1200px;
        margin: 20px auto;
        gap: 20px;
    }
    .feed, .sidebar {
        background-color: white;
        padding: 20px;
        border-radius: 10px;
    }
    .feed { flex: 2; }
    .sidebar {
        flex: 1;
        display: flex;
        flex-direction: column;
        gap: 15px;
    }
    .image-container {
        position: relative;
        display: inline-block;
    }
    .image-text {
    	width: 300px;
        position: absolute;
        top: 80%;
        left: 50%;
        transform: translate(-50%, -50%);
        color: white;
        font-size: 30px;
        font-weight: bold;
        padding: 5px 10px;
        text-align: center;
    }
    .img-fluid {
        width: 360px;
        height: 300px;
        border-radius: 5px;
    }
    .image-grid {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
        justify-content: center;
    }
    .post-item {
        display: flex;
        flex-direction: column;
        padding: 15px;
        border-bottom: 1px solid #ddd;
    }
    .post-header {
    	
        display: flex;
        align-items: center;
        margin-bottom: 5px;
    }
    .username {
        font-weight: bold;
        font-size: 16px;
        margin-right: 5px;
    }
    .timestamp {
        font-size: 12px;
        color: gray;
    }
    .post-content {
        text-align: left;
        font-size: 14px;
        margin-top: 5px;
    }
    .comment-icons {
        display: flex;
        gap: 10px;
        margin-top: 10px;
        color: gray;
        cursor: pointer;
    }
    .comment-icons i { font-size: 16px; }
    .detail-image {
        width: calc(33.33% - 10px);
        max-width: 200px;
        display: block;
        margin: 10px 0;
        align-self: flex-start;
        border-radius: 10px;
    }
    
    
    
    /* 구분선 스타일 */
.section-divider {
    margin: 20px 0;
    border: none;
    border-top: 1px solid #ddd;  /* 연한 회색 실선 */
}

/* 댓글 영역 */
.comment-section {
    margin-top: 20px;
}

/* 댓글 헤더 (N개의 댓글) */
.comment-header {
    font-weight: bold;
    margin-bottom: 10px;
}

/* 댓글 목록의 각 아이템 */
.comment-item {
    display: flex;
    align-items: flex-start;
    margin-bottom: 15px;
}

/* 프로필 이미지 */
.comment-profile {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    margin-right: 10px;
}

/* 댓글 내용 박스 */
.comment-content {
    background-color: #f7f7f7;
    padding: 10px;
    border-radius: 10px;
    max-width: 80%;
}

/* 댓글 작성자 */
.comment-username {
    font-weight: bold;
}

/* 댓글 작성 시간 */
.comment-timestamp {
    font-size: 12px;
    color: gray;
    margin-bottom: 5px;
    text-align: left; 
}

/* 댓글 본문 */
.comment-text {
    margin-top: 5px;
}

/* 댓글 입력 박스 */
.comment-input-box {
    display: flex;
    align-items: center;
    margin-top: 10px;
}

/* 댓글 입력창 */
.comment-input {
    flex: 1;
    padding: 8px;
    font-size: 14px;
    border-radius: 10px;
    border: 1px solid #ccc;
    outline: none;
}

/* 댓글 등록 버튼 */
.comment-submit {
    margin-left: 10px;
    padding: 8px 12px;
    font-size: 14px;
    background-color: #007bff;
    border: none;
    border-radius: 10px;
    color: #fff;
    cursor: pointer;
}
.comment-submit:hover {
    background-color: #0056b3;
}

/* 드롭다운 컨테이너 */
.dropdown {
    position: relative;
    display: inline-block; /* 혹은 block, 상황에 맞게 조정 */
}

/* 드롭다운 버튼 스타일 */
.menu-btn {
    background: none;
    border: none;
    cursor: pointer;
    font-size: 18px;
}

/* 드롭다운 내용 (처음엔 숨김) */
.dropdown-content {
    display: none;
    position: absolute;
    right: 0; /* 오른쪽 정렬 */
    background-color: #fff;
    min-width: 100px;
    border: 1px solid #ccc;
    border-radius: 5px;
    z-index: 999;
    text-align: left;
    box-shadow: 0 2px 5px rgba(0,0,0,0.15);
}

/* 드롭다운 내부 아이템 */
.menu-item {
    padding: 10px;
    cursor: pointer;
}
.menu-item:hover {
    background-color: #f0f0f0;
}

.comment-header {
    display: flex;
    align-items: center;
    
}

.comment-username {
    /* 원하는 스타일 적용 */
}

.comment-options {
    /* 옵션 영역 스타일 */
}

.like-icon {
    width: 24px;   /* 원하는 너비 */
    height: 24px;  /* 원하는 높이 */
    cursor: pointer;  /* 클릭 가능하게 보이도록 포인터 커서 추가 (선택 사항) */
}
#commentListContainer {
    height: 200px;
    overflow-y: auto;
    border: 1px solid #ddd; /* 선택사항: 테두리 추가 */
    padding: 10px;          /* 선택사항: 내부 여백 */
}
</style>
</head>
<body>
    <header>
	        <div id="logo">
	        	<a href="/"><img src="/images/index_login/logo.png" alt="Logo"></a>
	        </div>
	        <!-- nav_bar -->
	        <div class="holy">
	            <ul>
	            <c:if test="${session_id==null}">
	                <li><button type="button" class="sign_in">Sign in</button></li>
	            </c:if>
				<c:if test="${session_id!=null}">
	                <li><a onclick="searchBtn()">
					    <i class="fa-solid fa-magnifying-glass"></i>
					    <div id="searchBox" style="display: none;">
					        <input style="position: absolute; top:-15px; right:20px;"  type="text" id="searchInput" placeholder="검색..." />
					        <div id="searchResults" style="display: none; position: absolute; top: 40px; left: -200px; background: white; border-radius: 10px; box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2); width: 200px; padding: 8px 15px;"></div>
					    </div>
					</a></li>
	                <li><a onclick="openAlert()"><i style="font-size: 35px; position: relative; top: -5px;" class="fa-regular fa-envelope"></i></a></li>
	                <li><a href="/mypage"><i class="fa-regular fa-user"></i></a></li>
	                <li><a href="/user_setting"><i class="fa-solid fa-gear"></i></a></li>
	                <li class="cart coin"><a><img src="/images/index_login/coin.png"></a></li>
	                <li class="cart" style="position: relative; top:2px;"><a onclick="cartBtn()"><i class="fa-solid fa-cart-shopping"></i></a></li>
	            </c:if>
	            <c:if test="${session_id==null}">
	                <li class="cart coin"><a><img src="/images/index_login/coin.png"></a></li>
	                <li class="cart" style="position: relative; top:4px;"><a onclick="cartBtn()"><i class="fa-solid fa-cart-shopping"></i></a></li>
	            </c:if>
	            </ul>
	        </div>
	    </header>
<nav class="nav-bar">
	<ul class="nav-menu">
        <li class="nav-item">
            <a class="nav-link active-link" href="/fancommunity?artist_no=${adto.artist_no }">Fan</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/artistcommunity?artist_no=${adto.artist_no }">Artist</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/media?artist_no=${adto.artist_no }">Media</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/live?artist_no=${adto.artist_no }">Live</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#" target="_blank">Shop <i class="bi bi-box-arrow-up-right"></i></a>
        </li>
    </ul>
</nav>

<script>
    // 클릭하면 active 클래스 변경하는 JS 코드
    document.querySelectorAll(".nav-link").forEach(item => {
        item.addEventListener("click", function() {
            document.querySelectorAll(".nav-link").forEach(link => {
                link.classList.remove("active-link");
            });
            this.classList.add("active-link");
        });
    });
</script>


	<div class="container">
	    <!-- 왼쪽 피드 영역 -->
	    <div class="feed">
	        <!-- 1번: 글쓰기 버튼 -->
		    
		    <div class="post-box" onclick="openModal()">
		        <img src="images/profile.png" alt="프로필 이미지">
		        <input type="text" placeholder="위버스에 포스트를 남겨보세요.">
		    </div>
		
		    
		    <!-- 2번: 모달 창 -->
		    <div id="postModal" class="modal">
		        <div class="modal-content">
		            <h2>포스트 쓰기</h2>
		            <p>${adto.artist_group_name}</p>
		            <form action="/acwrite" method="post"  enctype="multipart/form-data">
			            <textarea placeholder="위버스에 남겨보세요..."name="a_community_content" rows=17;></textarea>
			            <input type="hidden" name="artist_no" value="${param.artist_no}">
			            <input type="hidden" name="nicknameDto.nickname_name" value="${sessionScope.nickname}">
           			    <div class="file-buttons">
					        <!-- 이미지 파일 업로드 -->
					        <label for="image-upload">
					            <img src="images/album.png" alt="사진 추가">
					        </label>
					        <input type="file" id="image-upload" name="imageFile" accept="image/*" style="display: none;">
					    </div>
					      
					    <!-- 미리보기 이미지 태그 추가 -->
					    <div id="imagePreviewContainer" style="display: none; margin-top: 10px;">
					        <img id="previewImage" src="" alt="미리보기 이미지" style="max-width: 100%;">
					    </div>
					    
		            	<div class="modal-footer">
		                <button type="button" class="close-btn" onclick="closeModal()">닫기</button>
		                <div class="file-buttons">
		                	<button class="submit-btn">등록</button>
				    	</div>
		            </form>
	            </div>
	        </div>
    	</div>
	    	
	    	<!-- 수정용 모달 -->
			<div id="postModal3" class="modal" >
			    <div class="modal-content" >
			        <h2 id="modalTitle">포스트 수정</h2>
		            <p>${adto.artist_group_name}</p>
			        <form id="postForm" action="/acupdate" method="post" enctype="multipart/form-data">
			            <!-- 게시글 내용: 수정 시 기존 내용 채워 넣을 예정 -->
			            <textarea id="a_community_content" placeholder="위버스에 남겨보세요..." name="a_community_content" rows=17;></textarea>
			            <input type="hidden" name="artist_no" value="${param.artist_no}">
			            <input type="hidden" name="nicknameDto.nickname_name" value="${sessionScope.nickname}">
			            <!-- 수정 시 communityNo 필요 -->
			            <input type="hidden" id="communityNoInput2" name="a_community_no" value="">
			            <div class="file-buttons">
			                <!-- 이미지 파일 업로드 -->
			                <label for="image-upload1">
			                    <img src="images/album.png" alt="사진 추가">
			                </label>
			                <input type="file" id="image-upload1" name="imageFile1" accept="image/*" style="display: none;">
			            </div>
			            <!-- 미리보기 이미지 태그 -->
			            <div id="imagePreviewContainer2" style="display: none; margin-top: 10px;">
			                <img id="previewImage2" src="" alt="미리보기 이미지" style="max-width: 100%;">
			            </div>
			            <div class="modal-footer">
			                <button type="button" class="close-btn" onclick="closeModal3()">닫기</button>
			                <div class="file-buttons">
			                    <!-- (추가 옵션 등) -->
			                </div>
			                <button type="submit" class="submit-btn">등록</button>
			            </div>
			        </form>
			    </div>
			</div>
	    	
		<!-- 전체 리스트 -->
		<div class="post-list">
    	<c:forEach var="post" items="${list}">
        <!-- .post-item에 position: relative;를 적용 -->
        <div class="post-item" data-community-no="${post.a_community_no}" style="position: relative;"
             onclick="openModal2('${post.nicknameDto.nickname_name}', '${post.a_community_content}', '${post.a_community_date}', '${post.a_community_image}', this.dataset.communityNo)">
             
            <!-- 수정/삭제 드롭다운 (작성자일 때만 노출) -->
            <c:choose>
                <c:when test="${post.nicknameDto.nickname_name eq sessionScope.nickname}">
                    <div class="dropdown" style="position: absolute; top: 10px; right: 10px; z-index: 10;">
                        <!-- 드롭다운 열기 버튼 -->
                        <button class="menu-btn" onclick="toggleMenu(event)">...</button>
                        <!-- 드롭다운 내용 -->
                        <div class="dropdown-content" style="display: none; position: absolute; top: 30px; right: 0;">
                            <div class="menu-item" onclick="updatePost(${post.a_community_no}, ${post.artistDto.artist_no}); event.stopPropagation();" style="font-size:15px;">수정하기</div>
                            <div class="menu-item" onclick="deletePost(${post.a_community_no}, ${post.artistDto.artist_no}); event.stopPropagation();" style="font-size:15px;">삭제하기</div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- 작성자가 아니면 버튼 미노출 -->
                </c:otherwise>
            </c:choose>
            
            <!-- 게시글 헤더 -->
            <div class="post-header">
                <img src="images/profile.png" alt="프로필 이미지">
                <span class="username">${post.nicknameDto.nickname_name}</span>
                <span class="timestamp">
                    <fmt:formatDate value="${post.a_community_date}" pattern="MM.dd HH:mm" />
                </span>
            </div>
            
            <!-- 이미지 영역 -->
            <c:if test="${not empty post.a_community_image}">
                <img src="/upload/test/${post.a_community_image}" alt="게시글 이미지" style="max-width:100%;">
            </c:if>
            <c:if test="${empty post.a_community_image}">
                <!-- 이미지 없을 때 -->
            </c:if>
            
            <!-- 게시글 내용 -->
            <div class="post-content">
                ${post.a_community_content}
            </div>
            
            <!-- 댓글/좋아요 아이콘
            <div class="like-container">
			    <img src="images/빈하트.png" alt="좋아요" 
			         class="like-icon" 
			         data-liked="false" 
			         onclick="toggleLike(this, 'images/빈하트.png', 'images/가득찬하트.png', ${post.a_community_no}, '${sessionScope.nickname}'), event.stopPropagation()">
			    <span class="like-count" id="likeCount_${post.a_community_no}">
			        
			    </span>
			</div>
             -->
            <hr>
			<!-- 댓글 개수 표시 -->
			<!-- 예: 기본값은 서버에서 넘긴 commentList의 길이 -->
			<div class="comment-header" id="commentCount_${post.a_community_no}" onclick="event.stopPropagation()">
			    <!-- 초기값은 빈 문자열이나 기본값(예: "0개의 댓글") -->
			</div>
        </div>
    </c:forEach>
    
</div>

			
			<!-- 상세보기 모달 -->
			<div id="postModal2" class="modal" onclick="closeModal2()">
			    <div class="modal-content" onclick="event.stopPropagation()">
			     	<!-- 여기 안쪽을 클릭하면 이벤트가 전파되지 않아서 창이 안 닫힘, 우끼끼~ -->
			        <div class="post-header modal-header"> <!-- 모달 전용 -->
			            <img src="images/profile.png" alt="프로필 이미지">
			            <span class="username" id="modalUsername"></span>
			            <span class="timestamp" id="modalTimestamp"></span>
			        </div>
			        <div class="image-container" id="modalImage">
			 			
			        </div>
			        <div class="post-content" id="modalContent"></div>
			        
			        <!-- 구분선 -->
			        <br>
       				<hr class="section-divider" />
			        
			        <!-- 댓글 영역 시작, 우끼끼~! -->
			        <div class="comment-section">
			            
			            <div id="commentListContainer" style="height: 300px; overflow-y: auto;">
				            <!-- 실제 댓글 리스트 -->
				            <div id="commentList">
				            
				            </div>
			             </div>
			            <!-- 구분선 -->
				        <br>
	       				<hr class="section-divider" />
			            
			            <!-- 댓글 입력 -->
		         		<form action="/acomments/add" method="post" id="commentForm">
				            <div class="comment-input-box">
							    <!-- 게시글 번호(community_no)를 숨겨서 전송 -->
							    <input type="hidden" id="communityNoInput" name="communityNo" value="">
							    <!-- 로그인한 사용자의 닉네임 -->
							    <input type="hidden" name="memberNickname" value="${sessionScope.nickname}">
				                <input type="text" id="commentInput" placeholder="댓글을 입력하세요." class="comment-input" name="comment_content">
				                <button type="button" class="comment-submit" onclick="addComment()">등록</button>
			            </div>
		         		</form>
			        </div>
			        <!-- 댓글 영역 끝 -->
			    </div>
			</div>
	
	    	
	    </div>
	    <script>
	        function openModal() {
	            document.getElementById("postModal").style.display = "flex";
	        }
	        function closeModal() {
	            document.getElementById("postModal").style.display = "none";
	        }
	        function closeModal3() {
	            console.log("closeModal2 호출됨", document.getElementById("postModal3"));
	            $("#postModal3").hide(); // jQuery를 이용해서 숨기기
	        }

	        var currentUserNickname = '${sessionScope.nickname}';
	        function openModal2(postId, postContent, postDate, postImage, communityNo) {
	            // 게시글 데이터 세팅
	            document.getElementById("modalUsername").textContent = postId;
	            document.getElementById("modalTimestamp").textContent = postDate;
	            document.getElementById("modalContent").textContent = postContent;
	            if (postImage && postImage.trim() !== "") {
	                document.getElementById("modalImage").innerHTML = "<img src='/upload/test/" + postImage + "' alt='게시글 이미지'>";
	            } else {
	                document.getElementById("modalImage").innerHTML = "";
	            }
	            
	            // 댓글 초기화 및 새로 로드
	            $("#commentList").empty();
	            console.log("🚀 loadComments 실행됨, communityNo:", communityNo);
	            loadComments(communityNo);
	            
	            // 숨겨진 input에 communityNo 설정
	            document.getElementById("communityNoInput").value = communityNo;
	            
	            // 모달 열기
	            document.getElementById("postModal2").style.display = "flex";
	        }
	        
	        function toggleOptionsMenu(button) {
	            // 버튼의 바로 다음 요소(옵션 메뉴)를 토글하는 예시
	            var menu = button.nextElementSibling;
	            if (menu.style.display === "block") {
	                menu.style.display = "none";
	            } else {
	                menu.style.display = "block";
	            }
	            event.stopPropagation();
	        }

	        function editComment(commentNo) {
	            // 수정 기능 구현 예시
	            alert("댓글 수정 기능 구현: 댓글 번호 " + commentNo);
	        }
	        
	        var currentUserNickname = '${sessionScope.nickname}';
	        function deleteComment(commentNo, communityNo) {
	            // 삭제 기능 구현 예시
	            if (confirm(commentNo+"번 댓글을 삭제하시겠습니까?")) {
	            	$.ajax({
			            url: "/artistcomment/delete", // 삭제를 처리할 컨트롤러 URL
			            type: "post",
			            data: { commentNo: commentNo},
			            dataType: "text", // 또는 JSON, 서버에서 어떻게 반환하는지에 따라
			            success: function(response) {
			                alert("게시글이 삭제되었습니다.");
			                // 삭제 후 페이지 새로고침 또는 목록 업데이트
			                loadComments(communityNo);
			                //location.href="/fancommunity?artist_no="+artistNo
			            },
			            error: function() {
			                alert("게시글 삭제에 실패했습니다.");
			            }
			        });
	            }
	        }

	        
	       
	        function loadComments(communityNo) {
	            $.ajax({
	                url: "/artistcommunity/detail",
	                type: "get",
	                data: { communityNo: communityNo },
	                dataType: "json",
	                success: function(detailData) {
	                    console.log(detailData);
	                    var htmlData = "";
	                    
	                    for (let i = 0; i < detailData.length; i++) {
	                    	htmlData += '<div class="comment-item">';
	                    	htmlData += '  <img src="images/profile.png" alt="프로필" class="comment-profile">';
	                    	htmlData += '  <div class="content">';
	                    	htmlData += '      <div class="comment-header" style="display: flex; align-items: center; justify-content: space-between;">';
	                    	htmlData += '          <div class="comment-username">' + detailData[i].nicknameDto.nickname_name + '</div>';
	                    	// 조건: 댓글 작성자가 현재 사용자와 같으면 수정/삭제 버튼 추가currentUserNickname 
	                    	if (detailData[i].nicknameDto.nickname_name === currentUserNickname) {
	                    	    htmlData += '          <div class="comment-options">';
	                    	    htmlData += '              <button class="comment-options-btn menu-btn" onclick="toggleOptionsMenu(this)">...</button>';
	                    	    htmlData += '              <div class="comment-options-menu" style="display: none;">';
	                    	    htmlData += '                  <button class="delete-comment" onclick="deleteComment(' + detailData[i].comment_no + ', ' + detailData[i].artistcommunityDto.a_community_no + '); event.stopPropagation();">삭제하기</button>';
	                    	    htmlData += '              </div>';
	                    	    htmlData += '          </div>';
	                    	}
	                    	htmlData += '      </div>'; // end .comment-header
	                    	htmlData += '      <div class="comment-timestamp">' + new Date(detailData[i].comment_date).toLocaleString() + '</div>';
	                    	htmlData += '      <div class="comment-text">' + detailData[i].comment_content + '</div>';
	                    	htmlData += '  </div>'; // end .content
	                    	htmlData += '</div>'; // end .comment-item
	                    }
	                    $("#commentList").html(htmlData);
	                },
	                error: function() {
	                    console.error("상세 정보 로드 실패11");
	                }
	            });
	        }

	       
	        
	        
	        
	        
	        

	        function closeModal2() {
	            document.getElementById("postModal2").style.display = "none";
	        }
	        
	        document.getElementById("image-upload").addEventListener("change", function(event) {
	            let file = event.target.files[0];
	            if (file && file.type.startsWith("image/")) {
	                let reader = new FileReader();
	                reader.onload = function(e) {
	                    let previewImage = document.getElementById("previewImage");
	                    previewImage.src = e.target.result;
	                    // 미리보기 컨테이너 보이기
	                    document.getElementById("imagePreviewContainer").style.display = "block";
	                }
	                reader.readAsDataURL(file);
	            } else {
	                // 이미지 파일이 아니면 미리보기 숨기기
	                document.getElementById("imagePreviewContainer").style.display = "none";
	            }
	        });
	        
	     // 댓글 추가 함수
		function addComment() {
	    	// 입력값 확인
		    if ($("#commentInput").val().length<1) {
		        alert("내용을 입력하셔야 합니다.");
		        return; // 빈 댓글은 추가 안 함, 우끼끼~!
		    }
		    
		    //ajax
		    let htmlData = "";
		    $.ajax({
		    	url:"/acomments/add",
		    	type:"post",
		    	data:$("#commentForm").serialize(), //form의 모든 데이터를 서버전송 
		    	dataType:'json',
		    	success:function(data){ //서버에서 dto객체 받음.
		    		
		    		htmlData += ' <div class="comment-item">';
		    		htmlData += ' <img src="images/profile.png" alt="프로필" class="comment-profile">';
		    		htmlData += ' <div class="comment-content">';
		    		htmlData += ' <div class="comment-username">'+data.nicknameDto.nickname_name+'</div>';
		    		htmlData += ' <div class="comment-timestamp">'+data.comment_date+'</div>';
		    		htmlData += ' <div class="comment-text">'+data.comment_content+'</div>';
		    		htmlData += ' </div>';
		    		htmlData += ' </div>';
		                    
		    		$("#commentList").prepend(htmlData);
		    		
		    		updateCommentCount();
		    		  // 댓글 입력창 초기화 여기!
		            document.getElementById("commentInput").value = "";
		    		
		    	},
		    	error:function(){
		    		alert("실패");
		    	}
		    });
		    
	        // 입력창 초기화
	        commentInput.value = "";
		    
		    
		}
	     
	     //댓글 수
	     
	        function toggleMenu(event) {
	            // 이벤트 전파 막아서 바깥 클릭 시 닫힐 수 있도록
	            event.stopPropagation();

	            let dropdownContent = document.getElementById("dropdownMenu");
	            if (dropdownContent.style.display === "block") {
	                dropdownContent.style.display = "none";
	            } else {
	                dropdownContent.style.display = "block";
	            }
	        }

	        // 바깥을 클릭하면 드롭다운이 닫히도록
	        document.addEventListener("click", function() {
	            let dropdownContent = document.getElementById("dropdownMenu");
	            if (dropdownContent) {
	                dropdownContent.style.display = "none";
	            }
	        });
			//게시글수정
	        function updatePost(communityNo, artistNo) {
	        	// AJAX를 통해 해당 게시글의 데이터를 가져옴 (수정용 엔드포인트)
	            $.ajax({
	                url: "/artistcommunity/getPost", // 게시글 상세 정보를 JSON으로 반환하는 엔드포인트
	                type: "GET",
	                data: { communityNo: communityNo },
	                dataType: "json",
	                success: function(postData) {
	                	console.log("수정창을 엽니다.")
	                	console.log("postData : ",postData)
	                	console.log("이미지 : ",postData.a_community_image)
	                    // postData는 FanCommunityDto 객체 (JSON)라고 가정
	                    // 모달 타이틀을 "포스트 수정"으로 변경
	                    document.getElementById("modalTitle").textContent = "포스트 수정";
	                	
	                	
	                    // 기존 내용 채워넣기
	                    document.getElementById("a_community_content").value = postData.a_community_content;
	                    // 만약 이미지가 있다면 미리보기 세팅
	                    if (postData.a_community_image && postData.a_community_image.trim() !== "") {
	                        document.getElementById("previewImage2").src = "/upload/test/" + postData.a_community_image;
	                        document.getElementById("imagePreviewContainer2").style.display = "block";
	                    } else {
	                        document.getElementById("imagePreviewContainer2").style.display = "none";
	                    }
	                    // 수정 시 필요한 communityNo 값을 hidden input에 세팅
	                    document.getElementById("communityNoInput2").value = postData.a_community_no;
	                    // 폼 action을 수정 전용 URL로 변경 (예: "/fancommunity/update")
	                    document.getElementById("postForm").action = "/acupdate";
	                    // 모달 열기
	                    document.getElementById("postModal3").style.display = "flex";
	                },
	                error: function() {
	                    console.error("게시글 상세 정보 로드 실패");
	                }
	            });
	        }
	     // 페이지 로드 시 파일 선택 이벤트 핸들러 등록
	        document.addEventListener("DOMContentLoaded", function() {
	            document.getElementById("image-upload1").addEventListener("change", function(event) {
	                let file = event.target.files[0];
	                if (file && file.type.startsWith("image/")) {
	                    let reader = new FileReader();
	                    reader.onload = function(e) {
	                        document.getElementById("previewImage2").src = e.target.result;
	                        document.getElementById("imagePreviewContainer2").style.display = "block";
	                    };
	                    reader.readAsDataURL(file);
	                } else {
	                    document.getElementById("previewImage2").src = "";
	                    document.getElementById("imagePreviewContainer2").style.display = "none";
	                }
	            });
	        });
			
	        //게시글삭제
	       function deletePost(communityNo, artistNo) {
			    if (confirm(communityNo+"번 게시글을 삭제하시겠습니까?")) {
			        $.ajax({
			            url: "/artistcommunity/delete", // 삭제를 처리할 컨트롤러 URL
			            type: "post",
			            data: { communityNo: communityNo},
			            dataType: "text", // 또는 JSON, 서버에서 어떻게 반환하는지에 따라
			            success: function(response) {
			                alert("게시글이 삭제되었습니다.");
			                // 삭제 후 페이지 새로고침 또는 목록 업데이트
			                 window.location.replace("/artistcommunity?artist_no=" + artistNo);
			                //location.href="/fancommunity?artist_no="+artistNo
			            },
			            error: function() {
			                alert("게시글 삭제에 실패했습니다.");
			            }
			        });
			    }
			}
	        
	        
	        function toggleMenu(event) {
	            event.stopPropagation(); // 클릭 이벤트 전파 차단
	            var dropdown = event.target.nextElementSibling;
	            if (dropdown.style.display === "block") {
	                dropdown.style.display = "none";
	            } else {
	                dropdown.style.display = "block";
	            }
	        }

	        // 바깥 클릭 시 모든 드롭다운 닫기
	        document.addEventListener("click", function() {
	            var dropdowns = document.querySelectorAll(".dropdown-content");
	            dropdowns.forEach(function(dd) {
	                dd.style.display = "none";
	            });
	        });
	        
	        
	        $(document).ready(function(){
	            $('.post-item').each(function(){
	                let communityNo = $(this).data('community-no');  // 각 게시글의 data-community-no 값
	                updateCommentCount(communityNo);
	            });
	        });
	        function updateCommentCount(communityNo) {
	        	$.ajax({
	        	    url: "/acomments/count",
	        	    type: "get",
	        	    data: { communityNo: communityNo },
	        	    dataType: "json",
	        	    success: function(count) {
	        	        console.log("댓글 수 for communityNo " + communityNo + ": ", count);
	        	        var commentCountElement = document.getElementById("commentCount_" + communityNo);
	        	        // 이미지 태그와 댓글 수 텍스트를 함께 삽입
	        	        commentCountElement.innerHTML = '<img src="images/메세지.png" alt="메세지" style="width:20px; height:20px; vertical-align:middle; margin-right: 5px;"> '  + count + "개의 댓글";
	        	        commentCountElement.style.fontSize = "12px"; // 원하는 폰트 크기로 설정
	        	    },
	        	    error: function() {
	        	        console.error("댓글 수 로드 실패");
	        	    }
	        	});
	        }
	        
	        
	     
		
	    </script>
	    
    
	
	    <!-- 오른쪽 사이드바 (경계선 추가) -->
	    <!-- 오른쪽 사이드바 (한 개의 div로 감싸기) -->
	    <div class="sidebar">
	    <!-- ONF 이미지 + 그룹 텍스트 -->
	    <div class="image-container">
	        <img src="images/${adto.artist_group_image}" class="img-fluid" alt="ONF 이미지">
	        <a href="/artist?~~~}"><div class="image-text">${adto.artist_group_name}</div></a>
	    </div>
	
	    <!-- 멤버쉽 가입하기 (맵 영역) -->
	    <div class="image-wrapper">
	        <img src="images/멤버쉽.png" usemap="#membershipMap" alt="멤버쉽 가입하기 이미지" >
	        <map name="membershipMap">
	            <area shape="rect" coords="15,67,333,107" href="#" alt="멤버쉽 가입하기">
	        </map>
	    </div>
	
	    <!-- 구독하기 (맵 영역) -->
	    <div class="image-wrapper">
	        <img src="images/구독하기.png" usemap="#subscribeMap" alt="구독하기 이미지" >
	        <map name="subscribeMap">
	            <area shape="rect" coords="20,47,368,89" href="#" alt="구독하기">
	        </map>
	    </div>
	</div>
</div>
    
</body>
</html>
