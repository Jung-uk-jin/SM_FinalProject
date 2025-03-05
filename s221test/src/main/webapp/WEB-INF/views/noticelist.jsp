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
    <link rel="stylesheet" href="/css/notice.css">
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
    
    // 3. 공지사항 상세보기
function openModal(title, description, date) {
    // 모달 열기
    document.getElementById("noticeModal").style.display = "flex";
    document.body.classList.add("no-scroll"); // 스크롤 막기

    // 헤더에 modal-open 클래스 추가
    document.querySelector("header").classList.add("modal-open");

    // 다른 모달이 열려 있다면 닫기
    document.getElementById("messageModal").style.display = "none";

    // 모달 닫기 버튼 이벤트 리스너
    document.querySelector(".close-btn").addEventListener("click", function() {
        // 모달 닫기
        document.getElementById("noticeModal").style.display = "none";
        document.body.classList.remove("no-scroll"); // 스크롤 허용

        // 헤더에서 modal-open 클래스 제거
        document.querySelector("header").classList.remove("modal-open");
    });
}

// 공지사항 모달 외부 클릭 시 닫기
window.addEventListener("click", function(event) {
    let noticeModal = document.getElementById("noticeModal");
    if (event.target === noticeModal) {
        noticeModal.style.display = "none";
        document.body.classList.remove("no-scroll");

        // 헤더에서 modal-open 클래스 제거
        document.querySelector("header").classList.remove("modal-open");
    }
});

// 3번 끝
	 
	 // 4. 장바구니 클릭시
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
	}; // 4번 종료
	
	// 5. 알림창 모달 열기
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
	}); // 5번 끝
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
                <li><a href="/mypage"><i class="fa-regular fa-user"></i></a></li>
                <li><a href="/user_setting"><i class="fa-solid fa-gear"></i></a></li>
            </c:if>
                <li class="cart"><a onclick="cartBtn()"><i class="fa-solid fa-cart-shopping"></i></a></li>
            </ul>
        </nav>
    </header>
    <main class="main-container">
    <!-- 핑크배너 -->
    <section class="banner">
        <div class="banner-item">Fanzy Showcase &lt; Chase Our Hearts &gt;</div>
        <div class="banner-item">2025 Fanzy Con Festival</div>
    </section>

    <!-- 공지사항 -->
    <section class="notice-board">
        <h2>공지사항</h2>
        <a onclick="openModal()">
		    <div class="notice-item">
		        <h3><span class="new-badge">new</span>2025년 팬지 쇼케이스 안내</h3>
		        <p>2025년 팬지 쇼케이스 &lt; Chase Our Hearts &gt;에 대한 자세한 정보가 공개되었습니다.</p>
		        <span class="date">2025.02.27</span>
		    </div>
		</a>

        <div class="notice-item">
            <h3><a href="/notice/2">2025 팬지 컨 페스티벌</a></h3>
            <p>2025년 팬지 컨 페스티벌에 대한 모든 정보가 업데이트되었습니다.</p>
            <span class="date">2025.02.20</span>
        </div>
        <div class="notice-item">
            <h3><a href="/notice/3">회원 정보 변경 안내</a></h3>
            <p>회원님들께서 이용하실 수 있는 새로운 서비스가 오픈되었습니다. 서비스 변경 안내를 확인해 주세요.</p>
            <span class="date">2025.02.15</span>
        </div>
        <div class="notice-item">
            <h3><a href="/notice/4">시스템 점검 공지</a></h3>
            <p>시스템 점검으로 인한 일시적인 서비스 중단에 대해 안내드립니다.</p>
            <span class="date">2025.02.10</span>
        </div>
        <!-- 페이지 네비게이션 (넘버링) -->
		<div class="pagination">
		    <a href="/notices?page=1" class="page-link"><i class="fa-solid fa-angle-left"></i></a>
		    <a href="/notices?page=1" class="page-link">1</a>
		    <a href="/notices?page=2" class="page-link">2</a>
		    <a href="/notices?page=3" class="page-link">3</a>
		    <a href="/notices?page=4" class="page-link">4</a>
		    <a href="/notices?page=5" class="page-link"><i class="fa-solid fa-angle-right"></i></a>
		</div>
    </section>
    
    <!-- 공지사항 상세보기 모달창 -->
	<div id="noticeModal" class="modal" style="display: none;">
	    <div class="notice-content">
	        <span class="close-btn">&times;</span>
	        <h3 id="notice-title">[이벤트] 위버스 앱 아이콘 투표 이벤트 진행 안내 (2025.02.27)</h3>
	        <span id="notice-date">2025.02.27</span>
	        <hr>
	        <p id="notice-description">
	        안녕하세요. 위버스입니다.<br/>
디지털 멤버십의 새로운 혜택으로 ‘위버스 앱 아이콘 변경’기능이 오픈되었습니다!<br/><br/>

신규 기능 혜택 오픈을 기념하며 ‘내가 가장 좋아하는 위버스 앱 아이콘 투표 이벤트’를 진행합니다.<br/>
이벤트 상세 내용은 아래를 확인 부탁드리며 많은 참여 부탁드립니다.<br/><br/>


📌이벤트 일정<br/>
- 투표 기간 : 2025.02.18(화) 오후 1시 ~ 2025.03.04(화) 오후 11시 59분 (KST)<br/>
- 당첨자 혜택 지급 : 2025.03.07(금)<br/><br/>

📌당첨자 혜택<br/>
WEB 전용 9젤리 지급 (1,000명)<br/>
당첨자에게 젤리 지급 시 개별 알림 발송 예정<br/><br/>

📌이벤트 참여 방법<br/>
해당 링크를 눌러 내가 가장 좋아하는 위버스 앱 아이콘을 골라 투표해 주세요!<br/>
투표 1회 참여시 앱 아이콘 후보는 1개만 선택할 수 있으며, 위버스 계정 당 1일 2회까지 투표 가능합니다.<br/><br/>

📌이벤트 유의사항<br/>
- 해당 투표 이벤트는 모든 위버스 회원이 참여 가능하지만 앱 아이콘 변경 기능은 디지털 멤버십 구독자 대상 혜택으로 구독 시 변경 가능합니다.<br/>
- 당첨자는 실제 투표 결과로 선정된 앱 아이콘과 참여자가 투표한 앱 아이콘의 순위와 상관없이 선발됩니다.<br/>
- 이벤트 당첨자 발표 기간까지 디지털 멤버십 구독을 유지하고, 매일 투표에 참여하실 수록 당첨 확률이 더 높아집니다.<br/>
- 투표 완료 후 수정 및 취소는 불가합니다.<br/><br/>

앞으로 더 다양해질 디지털 멤버십의 혜택에 많은 기대 부탁드립니다.<br/>

감사합니다.<br/>

아리가또 고자이마스<br/>
아리가또 고자이마스<br/>
아리가또 고자이마스<br/>
아리가또 고자이마스<br/>
아리가또 고자이마스<br/>
아리가또 고자이마스<br/>
아리가또 고자이마스<br/>
아리가또 고자이마스<br/>
</p>

	        
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