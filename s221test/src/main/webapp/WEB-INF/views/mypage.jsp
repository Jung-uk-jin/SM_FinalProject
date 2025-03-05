<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    <title>Weverse Clone</title>
    <link rel="stylesheet" href="/css/mypage.css">
    <script>
    // 1. 로그아웃
    $(document).ready(function() {
        $(".logout").click(function() {
            location.href = "/logout"; 
        });
    });
    
    // 2. 검색창 토글
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
    }; // 2번 끝

	 
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
				    </div>
				</a></li>
                <li><a onclick="openAlert()"><i style="font-size: 35px; position: relative; top: -5px;" class="fa-regular fa-envelope"></i></a></li>
                <li><a><i class="fa-regular fa-user"></i></a></li>
                <li><a href="/user_setting"><i class="fa-solid fa-gear"></i></a></li>
            </c:if>
                <li class="cart"><a onclick="cartBtn()"><i class="fa-solid fa-cart-shopping"></i></a></li>
            </ul>
        </nav>
    </header>

    <!-- 개인정보 -->
    <section class="banner">
    	<div class="myname">
	        <div class="banner-item intro"><strong>박우정</strong>&nbsp;님</div>
	        <div class="banner-item email">qkr****@naver.com</div>
	        <button type="submit" class="logout">로그아웃</button>
    	</div>
    </section>

    <!-- 배너 아래 메인 부분, 연한 회색 배경 -->
    <main class="main-container">
        <div class="main-content">
            <div class="main-content">
            <div class="all_">
			    <!-- 왼쪽 사이드바 -->
			    <div class="sidebar">
			        <!-- 적립금/쿠폰 정보 -->
			        <div class="wallet">
			            <!-- 적립금 박스 -->
						<a><div class="wallet-item coupon">
						    <div class="wallet-label"><strong>쿠폰 / 적립금</strong></div>
						    <div class="wallet-amount">0장&nbsp;<i class="fa-solid fa-chevron-right" style="font-size: 16px; padding: 0;"></i></div>
						</div></a>
						<!-- 쿠폰 박스 -->
						<a><div class="wallet-item reward-points">
						    <div class="wallet-label"><strong>구독권</strong></div>
						    <div class="wallet-amount"><i class="fa-solid fa-chevron-right" style="font-size: 16px; padding: 0;"></i></div>
						</div></a>
			        </div>
					<hr style="border: 0.5px solid rgba(0, 0, 0, 0.05);">
			        <!-- 메뉴 리스트 -->
			        <div class="menu">
			            <div class="menu-item" onclick="navigateTo('order-history')">주문 내역</div>
			            <div class="menu-item" onclick="navigateTo('cancel-history')">취소/반품/교환 내역</div>
			            <div class="menu-item" onclick="navigateTo('my-reviews')">내가 쓴 리뷰</div>
			            <div class="menu-item" onclick="navigateTo('recent-products')">최근 본 상품</div>
			        </div>
			    </div>
	
	
	            <!-- 회원 정보 -->
				<div class="user-details">
				    <h2>회원정보 <button id="edit-btn">수정</button></h2>
				    <form>
				        <div class="form-group">
				            <label>이름</label>
				            <input type="text" value="김슬기" readonly>
				        </div>
				
				        <div class="form-group">
				            <label>아이디</label>
				            <input type="text" value="slefhjgsle123" readonly>
				        </div>
				
				        <div class="form-group">
				            <label>비밀번호 변경</label>
				            <button type="button">비밀번호 변경</button>
				        </div>
				
				        <div class="form-group">
				            <label>이메일</label>
				            <input type="email" value="test@example.com" readonly>
				        </div>
				
				        <div class="form-group">
				            <label>주소</label>
				            <input type="text" value="주소를 입력하세요" readonly>
				        </div>
				
				        <div class="form-group">
				            <label>휴대폰</label>
				            <input type="text" value="010-" readonly>
				        </div>
				
				        <div class="form-group">
				            <label>생년월일</label>
				            <input type="date" readonly>
				        </div>
				    </form>
				</div>
			</div>

        </div>
	    <!-- 추천 아티스트 -->   
	    <a><div class="fixed-heart">
			<img src="/images/index_login/heart.png" alt="Heart" />
		</div></a>
		
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
    </main>
    <!-- 푸터 -->
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
