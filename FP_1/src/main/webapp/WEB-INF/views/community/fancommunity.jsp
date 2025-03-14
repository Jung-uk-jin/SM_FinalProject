<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    <title>Global Fandom Platform - Fanzy</title>
    <link rel="stylesheet" href="/css/community.css">
    <script>
    // 1. 로그아웃
    $(document).ready(function() {
        $(".logout").click(function() {
            location.href = "/logout"; 
        });
    });
    
	 // 2. 검색창 토글
	    window.onload = () => {
		    document.getElementById('searchInput').addEventListener('keyup', searchArtist);
		    document.getElementById('searchBtn').addEventListener('click', searchBtn);
		};
		
		const searchArtist = () => {
		    const query = document.getElementById('searchInput').value.trim();
		    const resultsBox = document.getElementById('searchResults');
		    const searchBox = document.getElementById('searchBox');
		
		    if (query.length === 0) {
		        resultsBox.style.display = 'none';
		        resultsBox.innerHTML = '';
		        return;
		    }
		
		    fetch('/search?query=' + encodeURIComponent(query))
		        .then(response => {
		            if (!response.ok) {
		                throw new Error('검색 요청 실패');
		            }
		            return response.json();
		        })
		        .then(data => {
		            if (!data || data.length === 0) {
		                resultsBox.innerHTML = '<p style="padding: 10px;">검색 결과가 없습니다.</p>';
		                resultsBox.style.display = 'block';
		                return;
		            }
		
		            resultsBox.innerHTML = data.map(artist => 
		                '<div class="search-result-item">' +
		                    '<img src="' + artist.imageUrl + '" alt="' + artist.name + '" class="search-result-img">' +
		                    '<span class="search-result-name">' + artist.name + '</span>' +
		                '</div>'
		            ).join('');
		            resultsBox.style.display = 'block';
		        })
		        .catch(error => console.error('Error fetching search results:', error));
		};
		
		
		const searchBtn = () => {
		    const searchBox = document.getElementById('searchBox');
		    const searchIcon = document.querySelector('.fa-magnifying-glass');
		    const searchInput = document.getElementById('searchInput');
		    const searchLi = document.querySelector('nav ul li a'); // a 요소 선택

		    // 검색창과 검색 아이콘을 토글
		    if (searchBox.style.display === 'none' || searchBox.style.display === '') {
		        searchBox.style.display = 'block'; // 검색창을 보이게
		        searchIcon.style.visibility = 'hidden'; // 검색 아이콘 숨기기
		        searchIcon.style.opacity = '0'; // 아이콘을 완전히 투명하게 만듦
		        searchInput.focus(); // 검색창이 보일 때 포커스를 맞추기
		        searchLi.classList.add('no-hover'); // hover 비활성화
		    }
		};
		
		
		//CSS 추가 (필요하면 HTML의 <style> 태그 안에 넣어줘)
		const style = document.createElement('style');
		style.innerHTML = `
		    .search-result-item {
		        display: flex;
		        align-items: center;
		        padding: 5px;
		        cursor: pointer;
		    }
		    .search-result-item:hover {
		        background-color: #f0f0f0;
		    	border-radius: 5px;
		    }
		    .search-result-img {
		        width: 30px;
		        height: 30px;
		        border-radius: 50%;
		        margin-right: 10px;
		    }
		    .search-result-name {
		        font-size: 14px;
		    }
		`;
		document.head.appendChild(style);
		
		document.addEventListener("click", (event) => {
		    const resultsBox = document.getElementById("searchResults");
		    const searchBox = document.getElementById("searchBox");
		    const searchInput = document.getElementById("searchInput");
		    const searchBtn = document.querySelector('nav ul li a'); // 검색 버튼
		    const searchIcon = document.querySelector(".fa-magnifying-glass");
		    const searchLi = document.querySelector('nav ul li a'); // hover 효과 복구용

		    if (
		        !resultsBox.contains(event.target) && 
		        !searchBox.contains(event.target) &&
		        event.target !== searchInput &&
		        event.target !== searchBtn && 
		        !searchBtn.contains(event.target) // 검색 버튼 클릭 예외 처리
		    ) {
		        resultsBox.style.display = "none";  
		        searchBox.style.display = "none";  
		        searchIcon.style.visibility = "visible";  
		        searchIcon.style.opacity = "1";  
		        searchLi.classList.remove('no-hover'); // hover 효과 복구
		    }
		}); // 2번 끝
	
	// 3. 장바구니 클릭시
	const cartBtn = () => {
	    const sessionId = '${session_id}';  
	
	    if (sessionId) {  // sessionId가 있으면
	        window.location.href = "/cart";
	    } else {
	        const isLogin = confirm("로그인이 필요합니다. 로그인하시겠습니까?");
	        if (isLogin) {
	            window.location.href = "/login"; // 로그인 페이지로 이동
	        }
	    }
	}; // 3번 종료
	
	// 4. 알림창 모달 열기
	// 프로그레스바 위치 및 너비 업데이트 함수
	function updateProgressBar(targetIndex) {
	    let totalTabs = $(".modal-link").length;  // 탭의 총 개수
	    let progressWidth = (1 / totalTabs) * 100;  // 각 탭의 너비 비율

	    // 프로그레스바의 왼쪽 위치를 인덱스를 기준으로 설정
	    let progressLeft = (targetIndex / totalTabs) * 100;

	    // progress2의 위치와 너비 설정
	    $(".progress2").css({
	        "left": progressLeft + "%",  // 실선의 위치
	        "width": progressWidth + "%"  // 실선의 너비
	    });
	}

	// 알림창 모달 열기
	const openAlert = () => {
	    $("#messageModal").show();

	    // 모달이 열릴 때 기본적으로 'all' 타겟을 보여주기
	    $(".notification-content").removeClass("active").hide();  // 모든 콘텐츠 숨기기
	    $("#all").addClass("active").show();  // 'all' 콘텐츠만 보여주기

	    // 'all' 탭 글자 색상 변경 (모달이 열릴 때)
	    $(".modal-link").css("color", "");  // 모든 탭 글자 색 초기화
	    $(".modal-link[data-target='all']").css("color", "#ff9a9e");  // 'all' 탭 글자 색상 변경

	    // 초기 핑크 실선 위치 설정 (전체 탭에 맞춰)
	    updateProgressBar(0);  // 'all' 탭이 첫 번째이므로 인덱스 0으로 설정
	};

	// 모달 닫기 (배경 클릭 시)
	$(document).ready(function () {
	    // 'messageModal' 외부를 클릭 시 모달을 닫는 코드
	    $("#messageModal").click(function (e) {
	        if ($(e.target).closest(".message-content").length === 0) {  // 클래스 이름 수정
	            $("#messageModal").hide();
	        }
	    });

	    // 탭 전환
	    $(".modal-link").click(function (e) {
	        e.preventDefault();
	        let target = $(this).data("target");

	        // 모든 탭의 색을 원래 상태로 되돌리기
	        $(".modal-link").css("color", "");  // 텍스트 색 원래 상태로 복원

	        // 클릭한 탭만 색상 변경 (ff9a9e)
	        $(this).css("color", "#ff9a9e");

	        // 콘텐츠 전환
	        $(".notification-content").removeClass("active").hide();
	        $("#" + target).addClass("active").show();

	        // 해당 탭에 대한 프로그레스바 위치 업데이트
	        let targetIndex = $(this).parent().index(); // 클릭된 탭의 인덱스 (0부터 시작)

	        // 해당 탭에 맞게 핑크 실선 위치 및 너비 업데이트
	        updateProgressBar(targetIndex);  // 클릭한 탭에 맞춰 업데이트
	    });
	}); // 4번 끝
    </script>
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
    <!-- 배너 아래 메인 부분, 연한 회색 배경 -->
    <main class="main-container">
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
	
	    <div class="container">
	        <div class="feed">
	            <!-- ✅ 글쓰기 버튼 (클래스명 변경) -->
	            <div class="post-box-main" onclick="openModal()">
	                <img src="images/profile.png" alt="프로필 이미지">
	                <input type="text" placeholder="위버스에 포스트를 남겨보세요.">
	            </div>
	        </div>
	            
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
	
	            <!-- ✅ 모달 창 (클래스명 변경) -->
	            <div id="postModal" class="post-modal">
	                <div class="post-modal-content">
	                    <h2>포스트 쓰기</h2>
	                    <p>${adto.artist_group_name}</p>
	                    <form action="/fcwrite" method="post" enctype="multipart/form-data">
	                        <textarea placeholder="위버스에 남겨보세요..." name="f_community_content" rows="17"></textarea>
	                        <input type="hidden" name="artist_no" value="${param.artist_no}">
	                        <input type="hidden" name="nicknameDto.nickname_name" value="${sessionScope.nickname}">
	                        <div class="file-buttons">
	                            <label for="image-upload">
	                                <img src="images/album.png" alt="사진 추가">
	                            </label>
	                            <input type="file" id="image-upload" name="imageFile" accept="image/*" style="display: none;">
	                        </div>
	                        <div class="modal-footer">
	                            <button type="button" class="close-btn" onclick="closeModal()">닫기</button>
	                            <button class="submit-btn">등록</button>
	                        </div>
	                    </form>
	                </div>
	            </div>
	
	            <!-- ✅ 전체 리스트 -->
	            <div class="post-list">
	                <c:forEach var="post" items="${list}">
	                    <div class="post-item">
	                        <div class="post-header">
	                            <img src="images/profile.png" alt="프로필 이미지">
	                            <span class="username">${post.nicknameDto.nickname_name}</span>
	                            <span class="timestamp">
	                                <fmt:formatDate value="${post.f_community_date}" pattern="MM.dd HH:mm"/>
	                            </span>
	                        </div>
	
	                        <c:if test="${not empty post.f_community_image}">
	                            <img src="/upload/artist/${post.f_community_image}" alt="게시글 이미지" style="max-width:100%;">
	                        </c:if>
	
	                        <div class="post-content">
	                            ${post.f_community_content}
	                        </div>
	                    </div>
	                </c:forEach>
	            </div>
	        
	    </div>
	
	    <!-- ✅ 상세보기 모달 (클래스명 변경) -->
	    <div id="postModal2" class="post-modal" onclick="closeModal2()">
	        <div class="post-modal-content" onclick="event.stopPropagation()">
	            <div class="post-header modal-header">
	                <img src="images/profile.png" alt="프로필 이미지">
	                <span class="username" id="modalUsername"></span>
	                <span class="timestamp" id="modalTimestamp"></span>
	            </div>
	            <div class="image-container" id="modalImage"></div>
	            <div class="post-content" id="modalContent"></div>
	            <div class="comment-section">
	                <div id="commentListContainer">
	                    <div id="commentList"></div>
	                </div>
	                <form action="/comments/add" method="post" id="commentForm">
	                    <div class="comment-input-box">
	                        <input type="hidden" id="communityNoInput" name="communityNo" value="">
	                        <input type="text" id="commentInput" placeholder="댓글을 입력하세요." name="comment_content">
	                        <button type="button" class="comment-submit" onclick="addComment()">등록</button>
	                    </div>
	                </form>
	            </div>
	        </div>
	    </div>

	        
	    <!-- 추천 아티스트 -->
		<a><div class="fixed-heart">
			    <img src="/images/index_login/heart.png" alt="Heart" />
		</div></a>
		</main>
		
		
		<!-- 알림 모달창 -->
		<div id="messageModal" class="modal" style="display: none;">
		    <div class="message-content">
		        <div class="message-header">
		            <span class="modal-title">알림</span>
		        </div>
		        <div class="message-body">
		            <ul>
		                <li><a href="#" class="modal-link" data-target="all">전체</a></li>
		                <li><a href="#" class="modal-link" data-target="plave">Plave</a></li>
		                <li><a href="#" class="modal-link" data-target="shop">Shop</a></li>
		            </ul>
					<!-- 진행 상태 표시 (회색 실선과 핑크 실선) -->
		            <div class="progress-bar2">
		                <div class="progress2"></div>
		            </div>
		            <!-- 각 탭에 대한 알림 내용 -->
		            <div class="notification-content" id="all">
		                전체 알림 내용...
		            </div>
		            <div class="notification-content" id="plave" style="display: none;">
		                Plave 알림 내용...
		            </div>
		            <div class="notification-content" id="shop" style="display: none;">
		                Shop 알림 내용...
		            </div>
		        </div>
		    </div>
		</div>
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
	                document.getElementById("modalImage").innerHTML = "<img src='/upload/artist/" + postImage + "' alt='게시글 이미지'>";
	            } else {
	                document.getElementById("modalImage").innerHTML = "";
	            }
	            
	            // 댓글 초기화 및 새로 로드
	            $("#commentList").empty();
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
			            url: "/fancomment/delete", // 삭제를 처리할 컨트롤러 URL
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
	                url: "/fancommunity/detail",
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
	                    	// 조건: 댓글 작성자가 현재 사용자와 같으면 수정/삭제 버튼 추가
	                    	if (detailData[i].nicknameDto.nickname_name === currentUserNickname) {
	                    	    htmlData += '          <div class="comment-options">';
	                    	    htmlData += '              <button class="comment-options-btn menu-btn" onclick="toggleOptionsMenu(this)">...</button>';
	                    	    htmlData += '              <div class="comment-options-menu" style="display: none;">';
	                    	    htmlData += '                  <button class="delete-comment" onclick="deleteComment(' + detailData[i].comment_no + ', ' + detailData[i].communityDto.f_community_no + '); event.stopPropagation();">삭제하기</button>';
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
		    	url:"/comments/add",
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
	                url: "/fancommunity/getPost", // 게시글 상세 정보를 JSON으로 반환하는 엔드포인트
	                type: "GET",
	                data: { communityNo: communityNo },
	                dataType: "json",
	                success: function(postData) {
	                	console.log("수정창을 엽니다.")
	                	console.log("postData : ",postData)
	                	console.log("이미지 : ",postData.f_community_image)
	                    // postData는 FanCommunityDto 객체 (JSON)라고 가정
	                    // 모달 타이틀을 "포스트 수정"으로 변경
	                    document.getElementById("modalTitle").textContent = "포스트 수정";
	                	
	                	
	                    // 기존 내용 채워넣기
	                    document.getElementById("f_community_content").value = postData.f_community_content;
	                    // 만약 이미지가 있다면 미리보기 세팅
	                    if (postData.f_community_image && postData.f_community_image.trim() !== "") {
	                        document.getElementById("previewImage2").src = "/upload/artist/" + postData.f_community_image;
	                        document.getElementById("imagePreviewContainer2").style.display = "block";
	                    } else {
	                        document.getElementById("imagePreviewContainer2").style.display = "none";
	                    }
	                    // 수정 시 필요한 communityNo 값을 hidden input에 세팅
	                    document.getElementById("communityNoInput2").value = postData.f_community_no;
	                    // 폼 action을 수정 전용 URL로 변경 (예: "/fancommunity/update")
	                    document.getElementById("postForm").action = "/fcupdate";
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
			            url: "/fancommunity/delete", // 삭제를 처리할 컨트롤러 URL
			            type: "post",
			            data: { communityNo: communityNo},
			            dataType: "text", // 또는 JSON, 서버에서 어떻게 반환하는지에 따라
			            success: function(response) {
			                alert("게시글이 삭제되었습니다.");
			                // 삭제 후 페이지 새로고침 또는 목록 업데이트
			                 window.location.replace("/fancommunity?artist_no=" + artistNo);
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
	        	    url: "/comments/count",
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
	    
</body>
</html>
