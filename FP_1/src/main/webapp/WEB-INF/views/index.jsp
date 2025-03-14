<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="modal.jsp" %> <!-- 모달 HTML 코드 포함 -->
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script type="text/javascript" src="../js/Main_recommend_button.js"></script>
    <title>Global Fandom Platform - Fanzy</title>
    <link rel="stylesheet" href="/css/styles.css">
    <link rel="stylesheet" href="/css/Main_recommend_button.css">
    <script>
	    $(document).ready(function () {
	    	// 1. 이벤트 배너 슬라이드 기능(5초 자동 슬라이드, 클릭시 이동가능)
	        let $wrapper = $(".event-wrapper");
	        let $container = $(".event");
	        let $prevBtn = $(".prev-btn");
	        let $nextBtn = $(".next-btn");
	
	        let cardWidth = $(".event-card").outerWidth(true); // 카드 너비 + 간격
	        let slideWidth = cardWidth*2; // 슬라이드 한 번에 이동할 너비는 카드 너비
	        let maxScroll = $wrapper[0].scrollWidth - $container.width(); // 스크롤 최대 값 (전체 내용의 너비에서 컨테이너의 너비를 뺀 값)
	
	        let $progress = $(".progress"); // 진행 표시줄 요소
	
	        function updateButtons() {
	            let scrollLeft = $container.scrollLeft();
	            $prevBtn.prop("disabled", scrollLeft <= 0);
	            $nextBtn.prop("disabled", scrollLeft >= maxScroll);
	        }
	
	        // 슬라이드 이동
	        $nextBtn.click(function () {
	            let newScrollLeft = Math.min($container.scrollLeft() + slideWidth, maxScroll);
	            $container.stop().animate({ scrollLeft: newScrollLeft }, 1000, "swing", updateButtons);
	            updateProgressBar(newScrollLeft); // 진행 표시줄 업데이트
	        });
	
	        $prevBtn.click(function () {
	            let newScrollLeft = Math.max($container.scrollLeft() - slideWidth, 0);
	            $container.stop().animate({ scrollLeft: newScrollLeft }, 1000, "swing", updateButtons);
	            updateProgressBar(newScrollLeft); // 진행 표시줄 업데이트
	        });
	
	        // 진행 표시줄 업데이트 함수
	        function updateProgressBar(scrollLeft) {
	            let progressWidth = (scrollLeft / maxScroll) * 100; // 비율에 따라 진행 표시줄의 width를 계산
	            $progress.css("width", progressWidth + "%"); // 진행 표시줄 width 업데이트
	        }
	
	        // 자동 슬라이드 기능
	        let autoSlideInterval = setInterval(function () {
	            let currentScrollLeft = $container.scrollLeft();
	            let newScrollLeft = currentScrollLeft + slideWidth;
	
	            // 끝에 도달하면 처음으로 돌아가도록 설정
	            if (newScrollLeft > maxScroll) {
	                newScrollLeft = 0; // 처음으로 돌아가게 설정
	                $progress.css("width", "0%"); // 진행 표시줄도 처음으로 리셋
	            }
	
	            // 슬라이드를 끝까지 이동시키기 위해 `maxScroll` 값과 비교
	            if (newScrollLeft <= maxScroll) {
	                $container.stop().animate({ scrollLeft: newScrollLeft }, 1000, "swing", updateButtons);
	            }
	
	            updateProgressBar(newScrollLeft); // 진행 표시줄 업데이트
	        }, 4000); // 4초마다 슬라이드 이동
	        // 1번 종료
	        
	        
            // 2. 'Sign in' 버튼 클릭 시
            $(".sign_in").click(function() {
                // 로그인 페이지로 이동
                location.href = "/login"; 
            }); // 2번 종료

            // 로그인 여부
            if("${param.chkLogin}"=="1"){
        		alert("로그인이 되었습니다.");
        	}
        	if("${param.chkLogin}"=="0"){
        		alert("로그아웃 되었습니다.")
        	}
        	
        	// 회원탈퇴
        	if("${param.deactivate}"=="1"){
        		alert("회원탈퇴가 완료되었습니다.");
        	}
        	

	    });
	    
	 // 3. 알림창 모달 열기
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
		}); // 3번 끝

		// 4. 검색창 토글
		window.onload = () => {
			document.getElementById('searchInput').addEventListener('keyup', searchArtist);
		    
		    // 🔥 NULL 체크 추가해서 오류 방지
		    const searchBtnElement = document.getElementById('searchBtn');
		    if (searchBtnElement) {
		        searchBtnElement.addEventListener('click', searchBtn);
		    }
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
		}); // 4번 종료


	// 5. 장바구니 클릭시
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
	}; // 5번 종료
	
	
	// 6. 번역
    function googleTranslateElementInit() {
        new google.translate.TranslateElement({
            pageLanguage: 'ko',
            includedLanguages: 'en,ko,zh,ja,fr,de,es,it,pt,ru',
            layout: google.translate.TranslateElement.InlineLayout.SIMPLE
        }, 'google_translate_element');
    }

    // 쿠키에서 번역 언어 가져오는 함수
    function getTranslateCookie() {
        let matches = document.cookie.match(/(^| )googtrans=([^;]+)/);
        return matches ? decodeURIComponent(matches[2]) : null;
    }

    // 저장된 번역 언어 강제 적용
    function applySavedTranslation() {
        let savedLang = getTranslateCookie();
        if (!savedLang) return;

        let langCode = savedLang.split('/')[2]; // "/auto/ko" → "ko"

        let checkExist = setInterval(function () {
            let selectBox = document.querySelector('.goog-te-combo');
            if (selectBox) {
                clearInterval(checkExist);
                selectBox.value = langCode;
                selectBox.dispatchEvent(new Event('change')); // 번역 실행
                console.log("번역 적용됨:", langCode);
            }
        }, 500);
    }

    // 페이지 로드 시 번역 유지
    window.addEventListener("load", function () {
        googleTranslateElementInit(); // 구글 번역 위젯 초기화
        setTimeout(function () {
            let banner = document.querySelector(".goog-te-banner-frame");
            if (banner) {
                banner.style.display = "none";
            }
            document.body.style.top = "0px"; // 혹시 top margin이 생기면 제거
        }, 800); // 번역 적용될 시간 고려
    }); // 6번 끝
    
    // 7. 알림창 ul 드래그
    document.addEventListener("DOMContentLoaded", function () {
        const artistListWrapper = document.querySelector(".artist-list-wrapper");  // ul을 감싸는 부모 요소
        const artistList = document.querySelector(".artist-list");  // ul 요소
        let isMouseDown = false;  // 마우스를 눌렀는지 여부
        let startX;  // 마우스 시작 위치
        let scrollLeft;  // 시작 시의 scrollLeft 값

        // 드래그 기능 설정
        const enableDrag = () => {
            // 마우스를 클릭했을 때 (드래그 시작)
            artistListWrapper.addEventListener("mousedown", (e) => {
                if (e.target.classList.contains("modal-link")) return;  // 링크 클릭 시 드래그 방지
                isMouseDown = true;
                startX = e.pageX - artistListWrapper.offsetLeft;  // 마우스 시작 위치
                scrollLeft = artistListWrapper.scrollLeft;  // 현재 스크롤 위치
                artistListWrapper.style.cursor = "grabbing";  // 드래그 중 커서 변경
            });

            // 마우스를 이동했을 때 (드래그 중)
            artistListWrapper.addEventListener("mousemove", (e) => {
                if (!isMouseDown) return;  // 마우스가 클릭되지 않았다면 이동하지 않음
                const moveX = e.pageX - artistListWrapper.offsetLeft - startX;  // 마우스 이동 거리
                artistListWrapper.scrollLeft = scrollLeft - moveX;  // 부모의 scrollLeft를 이동
            });

            // 마우스 버튼을 뗐을 때 (드래그 끝)
            artistListWrapper.addEventListener("mouseup", () => {
                isMouseDown = false;
                artistListWrapper.style.cursor = "grab";  // 커서 원래대로
            });

            // 마우스가 요소 밖으로 나갔을 때 (드래그 끝)
            artistListWrapper.addEventListener("mouseleave", () => {
                isMouseDown = false;
            });
        };

        // 탭 전환시 드래그 이벤트가 리셋되지 않도록 함
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

            // 드래그 기능 다시 활성화
            enableDrag();

            // 해당 탭에 대한 프로그레스바 위치 업데이트
            let targetIndex = $(this).parent().index(); // 클릭된 탭의 인덱스 (0부터 시작)

            // 해당 탭에 맞게 핑크 실선 위치 및 너비 업데이트
            updateProgressBar(targetIndex);  // 클릭한 탭에 맞춰 업데이트
        });

        // 페이지 로드 시 드래그 활성화
        enableDrag();
    }); // 7번 끝


    </script>
	</head>
	<body>
	    <header>
	        <div id="logo">
	        	<a href="/"><img src="/images/index_login/logo.png" alt="Logo"></a>
	        </div>
	        <!-- nav_bar -->
	        <nav>
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
	        </nav>
	    </header>
	    
	    <main>
	    	<!-- 핑크배너 -->
	        <section class="banner">
	            <div class="banner-item">Fanzy Showcase &lt; Chase Our Hearts &gt;</div>
	            <div class="banner-item">2025 Fanzy Con Festival</div>
	        </section>
	    	<!-- 이벤트 배너 -->
	        <section class="event-container">
			    <button class="slide-btn prev-btn">&#10094;</button>
			    <div class="event">
			        <div class="event-wrapper">
			        	<a href="https://shop.weverse.io/ko/shop/KRW/artists/3/categories/6?subCategoryId=5388"><div class="event-card">
			            	<div  style="left:28%" class="text-overlay">
							    <h2 style="font-size: 20px; text-shadow: 2px 2px 4px #e4a9fe;">TOMORROW X TOGETHER</h2><br><br>
						        <strong style="text-shadow: 2px 2px 4px #e4a9fe;"><p style="text-shadow: 2px 2px 4px #e4a9fe;">TXT</strong><br>
						        <strong style="text-shadow: 2px 2px 4px #e4a9fe;">6TH ANNIVERSARY</strong><br></p>
						        <p style="font-size: 18px; text-shadow: 2px 2px 4px #e4a9fe;">FANZY샵에서 만나보세요!</p>
						    </div>
			            	<img src="/images/index_login/tom.png">
			            </div></a>
			            <a><div class="event-card">
			            	<div style="left:23%" class="text-overlay">
							    <h2 style="font-size: 20px; text-shadow: 2px 2px 4px #5ebb25;">ISEGYE IDOL</h2><br><br>
						        <p style="text-shadow: 2px 2px 4px #5ebb25;">버츄얼아이돌?<br>
						        <strong style="text-shadow: 2px 2px 4px #5ebb25;">But your idol.. ♡</strong><br></p>
						        <p style="font-size: 18px; text-shadow: 2px 2px 4px #5ebb25;">이세계아이돌 굿즈 출시!</p>
						    </div>
			            	<img src="/images/index_login/idol.jpg">
			            </div></a>
						<a href="/event"><div class="event-card">
				            <div style="left:27%" class="text-overlay">
							    <h2 style="font-size: 20px; text-shadow: 2px 2px 4px #2da2e6;">BTS</h2><br><br>
						        <p style="font-size: 24px; text-shadow: 2px 2px 4px #2da2e6;">BTS Worldwide<br>
						        <strong style="text-shadow: 2px 2px 4px #2da2e6;">HandSEOM 공식상품</strong><br></p>
						        <p style="font-size: 18px; text-shadow: 2px 2px 4px #2da2e6;">Fanzy샵 예약 판매 중!</p>
						    </div>
			            	<img src="/images/index_login/bts.png">
			            </div></a>
			            <a href="https://happy-plave-day.oopy.io/"><div class="event-card">
			            	<div style="left:30%" class="text-overlay">
							    <h2 style="font-size: 20px; text-shadow: 2px 2px 4px #87CEEB;">PLAVE</h2><br><br>
						        <p style="text-shadow: 2px 2px 4px #87CEEB;">PLAVE 2nd ANNIVERSARY<br>
						        <strong style="text-shadow: 2px 2px 4px #87CEEB;">POP-UP STORE</strong><br></p>
						        <p style="text-shadow: 2px 2px 4px #87CEEB;">Happy Plave Day 💌</p>
						    </div>
			            	<img src="/images/index_login/plave.jpg">
			            </div></a>
			            <a><div class="event-card">
			            	<div style="left:25%" class="text-overlay">
							    <h2 style="font-size: 20px; text-shadow: 2px 2px 4px #e4a9fe;">aespa</h2><br><br>
						        <p style="text-shadow: 2px 2px 4px #e4a9fe;">새로운 세계의 음악<br>
						        <strong style="text-shadow: 2px 2px 4px #e4a9fe;">Next Level</strong><br></p>
						        <p style="text-shadow: 2px 2px 4px #e4a9fe;">MEMBERSHIP OPEN</p>
						    </div>
			            	<img src="/images/index_login/aespa.jpg">
			            </div></a>
			            <a href="/event"><div class="event-card">
				            <div style="left:29%" class="text-overlay">
							    <h2 style="font-size: 20px; text-shadow: 2px 2px 4px #515151;">BTS</h2><br><br>
						        <p style="font-size: 24px; text-shadow: 2px 2px 4px #515151;">HOPE on the street<br>
						        <strong style="text-shadow: 2px 2px 4px #515151;">VOL.1 LP</strong><br></p>
						        <p style="font-size: 18px; text-shadow: 2px 2px 4px #515151;">앨범의 감동을 LP로 느껴보세요!</p>
						    </div>
			            	<img src="/images/index_login/jhope.png">
			            </div></a>
			        </div>
			    </div>
			    <button class="slide-btn next-btn">&#10095;</button>
			</section>
			<!-- 진행 상태 표시 (회색 실선과 검정 실선) -->
		    <div class="progress-bar">
		        <div class="progress"></div>
		    </div>
		    
		    <!-- 나의 커뮤니티 -->
	        <c:if test="${session_id!=null}">
		        <section class="myCommunity">
	        	<c:if test="${not empty nlist}">
				    <div class="myC">
				        <h2>나의 커뮤니티</h2>
				        <div class="community-container">
				            <c:forEach var="n" items="${nlist}">
				                <a href="/artist?artist_no=${n.artistDto.artist_no}">
					                <div class="artist-card">
					                    <img src="images/${n.artistDto.artist_group_image}" alt="Artist">
					                    <div class="artist-name">${n.artistDto.artist_group_name}</div>
					                </div>
				                </a> 
				            </c:forEach>
				        </div>
				    </div>
				   </c:if>
				    <!-- 공지사항 -->
			        <div class="notice">
				    	<a href="/noticelist?page=0&artistNo=0">
							<div>
							    <h3>딩동! 첫 DM 메시지가 도착했어요!</h3>
								<p>멤버십 구독하고, 프라이빗 메시지에서만 볼 수 있는 특별한 소식을 확인하세요!<p>
							</div>
					    	<img alt="notice" src="/images/index_login/notice1.jpg">
						</a>
					</div>
				</section>

	        <!-- 굿즈샵 -->
		        <section class="merch">
				    <h2>Merch</h2>
				    <a><div class="idolMerch">PLAVE</div></a>
				    <a><div class="idolMerch">RIIZE</div></a>
				    <div class="merch-container">
				        <a><div class="merch-item">
				            <div class="temBox"><img src="/images/index_login/goods1.png" alt="PLAVE OFFICIAL LIGHT STICK"></div>
				            <p class="merch-title">PLAVE OFFICIAL LIGHT STICK</p>
				            <p class="merch-price">₩49,000</p>
				        </div></a>
				        <a><div class="merch-item">
				            <div class="temBox"><img src="/images/index_login/goods2.png" alt="Caligo Pt.1 (Fugitive Ver.)"></div>
				            <p class="merch-title">3rd Mini Album 'Caligo Pt.1' (Fugitive Ver.)</p>
				            <p class="merch-price">₩18,500</p>
				        </div></a>
				        <a><div class="merch-item">
				            <div class="temBox"><img src="/images/index_login/goods3.png" alt="Caligo Pt.1 (Vanguard Ver.) Random"></div>
				            <p class="merch-title">3rd Mini Album 'Caligo Pt.1' (Vanguard Ver.) Random</p>
				            <p class="merch-price">₩17,000</p>
				        </div></a>
				        <a><div class="merch-item">
				            <div class="temBox"><img src="/images/index_login/goods4.png" alt="Caligo Pt.1 (POCAALBUM Ver.)"></div>
				            <p class="merch-title">3rd Mini Album 'Caligo Pt.1' (POCAALBUM Ver.)</p>
				            <p class="merch-price">₩13,300</p>
				        </div></a>
				    </div>
				</section>
			</c:if>
			<c:if test="${session_id==null}">
			</c:if>
			
	        <section>
	        	<!-- 아티스트DM -->
	        	<div class="artist-dm-section">
				    <div class="dm-title">
				        <img src="/images/index_login/send.png" alt="DM 아이콘" class="dm-icon">
				        <h2>아티스트와 DM을 나눠 보세요!</h2>
				    </div>
				    <div class="dm-list">
				    	<c:forEach var="i" begin="0" end="7" step="1" varStatus="status">
				        <a><div class="dm-item"><img src="/images/index_login/test.jpg" alt="artist"><span class="art_name">아티스트 이름</span></div></a>
				    	</c:forEach>
				        <a><div class="dm-item refresh"><img src="/images/index_login/refresh.png" alt="새로고침"></div></a>
				    </div>
				</div>
				<!-- 아티스트 -->
			    <div class="artist-section">
			    <h2>새로운 아티스트를 만나보세요 !</h2>
			    <table class="artist-table">
			        <tbody>
			            <c:forEach items="${list}" var="adto" varStatus="status">
			                <!-- 새로운 행(tr) 시작 (5개마다) -->
			                <c:if test="${status.index % 5 == 0}">
			                    <tr>
			                </c:if>
			
			                <td>
			                	<a href="/artist?artist_no=${adto.artist_no}">
			                    <div class="artist-card">
			                       	<img src="images/${adto.artist_group_image }" alt="Artist"> 
			                        <div class="artist-name">${adto.artist_group_name}</div>
			                    </div>
			                    </a>
			                </td>
			
			                <!-- 5개마다 행(tr) 닫기 -->
			                <c:if test="${status.index % 5 == 4 or status.last}">
			                    </tr>
			                </c:if>
		         	    </c:forEach>
			        </tbody>
			    </table>
				</div>
	        </section>
	       
	    	<!-- 추천 아티스트 ==> modal.jsp 파일로 분리
			<c:if test="${session_id != null}">
			    <a>
			        <div class="fixed-heart" id="openModalButton" onclick="openRecommendationModal()">
			            <img src="/images/index_login/heart.png" alt="Heart" />
			        </div>
			    </a>
			</c:if>
			
		<div id="recommendationModal" class="modal-recommend">
		    <div class="modal-recommend-content">
		        <span id="recommend-close-btn"><i class="fa-solid fa-chevron-down"></i></span>
		        <h2>추천 아티스트</h2> -->
		        <!-- 추천 아티스트 목록 
		        <div class="recommend-artist-list">
		            <ul id="recommendation-list">-->
		                <!-- 초기에는 비어있고, 이후 JavaScript로 채워집니다.
		            </ul>
		        </div>
		    </div>
		</div> -->

			
			<!-- 알림 모달창 -->
			<div id="messageModal" class="modal" style="display: none;">
			    <div class="message-content">
			        <div class="message-header">
			            <span class="modal-title">알림</span>
			        </div>
			        <div class="message-body">
		                <div class="artist-list-wrapper">
		                    <ul class="artist-list">
		                        <li><a href="#" class="modal-link" data-target="all">전체</a></li>
		                        <li><a href="#" class="modal-link" data-target="plave">Plave</a></li>
		                        <li><a href="#" class="modal-link" data-target="bts">BTS</a></li>
		                        <li><a href="#" class="modal-link" data-target="blackpink">BLACKPINK</a></li>
		                        <li><a href="#" class="modal-link" data-target="shop">Shop</a></li>
		                    </ul>
		                </div>
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
			<div id="google_translate_element"></div>
	    </main>
	    
	    <footer>
	        <div class="footer-links">
	        <a href="#">이용약관</a>    
	        <a href="#">서비스운영정책</a>    
	        <a href="#">유료서비스 이용약관</a>    
	        <a href="#">청소년 보호 정책</a>    
	        <a href="#"><strong>개인정보처리방침</strong></a>    
	        <a href="#">쿠키정책</a>    
	        <a href="#">쿠키 설정</a>    
	        <a href="#">입점 신청</a>    
	        <a href="#">고객센터</a>
	    </div>
	    <div class="footer-info">
		    <p>
		        상호 &nbsp;<strong>Weverse Company Inc.</strong>
		        <span class="footer-gap">|</span>
		        대표자 &nbsp;<strong>임민영</strong>
		        <span class="footer-gap">|</span>
		        전화번호 &nbsp;<strong>1544-0790</strong>
		        <span class="footer-gap">|</span>
		        FAX &nbsp;<strong>+82)-2-2144-9399</strong>
		        <span class="footer-gap">|</span>
		        주소 &nbsp;<strong> 서울 금천구 동작대로 132, 한라원앤원타워 3층</strong>
		        <span class="footer-gap">|</span>
		        사업자등록번호 &nbsp;<strong>119-86-20319</strong>
		        <span class="footer-gap">|</span>
		        <a href="#">사업자 정보 확인</a>
		    </p>
		    <p>
		        통신판매업 신고번호 &nbsp;<strong>2022-성남분당A-0557호</strong>
		        <span class="footer-gap">|</span>
		        호스팅 서비스 사업자 &nbsp;<strong>Amazon Web Services, Inc., Naver Cloud</strong>
		    </p>
		    <p>© <strong>WEVERSE COMPANY Inc.</strong> Ver 2.32.6</p>
		</div>	
	    </footer>
	</body>
	</html>