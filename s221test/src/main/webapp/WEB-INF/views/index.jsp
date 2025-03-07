<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    <title>Weverse Clone</title>
    <link rel="stylesheet" href="/css/styles.css">
    <script>
	    $(document).ready(function () {
	    	// 1. 이벤트 배너 슬라이드 기능(5초 자동 슬라이드, 클릭시 이동가능)
	        let $wrapper = $(".event-wrapper");
	        let $container = $(".event");
	        let $prevBtn = $(".prev-btn");
	        let $nextBtn = $(".next-btn");
	
	        let cardWidth = $(".event-card").outerWidth(true); // 카드 너비 + 간격
	        let slideWidth = cardWidth; // 슬라이드 한 번에 이동할 너비는 카드 너비
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
	            $container.stop().animate({ scrollLeft: newScrollLeft }, 535, "swing", updateButtons);
	            updateProgressBar(newScrollLeft); // 진행 표시줄 업데이트
	        });
	
	        $prevBtn.click(function () {
	            let newScrollLeft = Math.max($container.scrollLeft() - slideWidth, 0);
	            $container.stop().animate({ scrollLeft: newScrollLeft }, 535, "swing", updateButtons);
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
	                $container.stop().animate({ scrollLeft: newScrollLeft }, 535, "swing", updateButtons);
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
	}; // 4번 종료

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
	                <c:if test="${mdto.member_usertype eq 'Admin'}">
	             	   <li><a href="/admin"><i class="fa-solid fa-gear"></i></a></li>
	                </c:if>
	                <c:if test="${mdto.member_usertype ne 'Admin'}">
	             	   <li><a href="/user_setting"><i class="fa-solid fa-gear"></i></a></li>
	                </c:if>
	            </c:if>
	                <li class="cart"><a onclick="cartBtn()"><i class="fa-solid fa-cart-shopping"></i></a></li>
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
			            <div class="event-card">
			            	<div style="left:30%" class="text-overlay">
							    <h2 style="font-size: 20px; text-shadow: 2px 2px 4px #87CEEB;">PLAVE</h2><br><br>
						        <p style="text-shadow: 2px 2px 4px #87CEEB;">PLAVE 2nd ANNIVERSARY<br>
						        <strong style="text-shadow: 2px 2px 4px #87CEEB;">POP-UP STORE</strong><br></p>
						        <p style="text-shadow: 2px 2px 4px #87CEEB;">Happy Plave Day 💌</p>
						    </div>
			            	<a><img src="/images/index_login/plave.jpg"></a>
			            </div>
			            <div class="event-card">
				            <div style="left:27%" class="text-overlay">
							    <h2 style="font-size: 20px; text-shadow: 2px 2px 4px #2da2e6;">Fanzy</h2><br><br>
						        <p style="font-size: 24px; text-shadow: 2px 2px 4px #2da2e6;">2025년 핫 데뷔 루키<br>
						        <strong style="text-shadow: 2px 2px 4px #2da2e6;">HOT DEBUT ROOKIE</strong><br></p>
						        <p style="font-size: 18px; text-shadow: 2px 2px 4px #2da2e6;">남자.ver</p>
						    </div>
			            	<a><img src="/images/index_login/신인남돌.jpg"></a>
			            </div>
			            <div class="event-card">
						    <div style="left:25%" class="text-overlay">
						    	<h2 style="font-size: 20px; text-shadow: 2px 2px 4px #FFB6C1;">Fanzy</h2><br><br>
						        <p style="text-shadow: 2px 2px 4px #FFB6C1;">2025년 핫 데뷔 루키<br>
						        <strong style="text-shadow: 2px 2px 4px #FFB6C1;">HOT DEBUT ROOKIE</strong><br></p>
						        <p style="font-size: 18px; text-shadow: 2px 2px 4px #FFB6C1;">여자.ver</p>
						    </div>
						    <a><img src="/images/index_login/신인여돌.jpg"></a>
						</div>
						<div class="event-card">
			            	<div style="left:28%" class="text-overlay">
							    <h2 style="font-size: 20px; text-shadow: 2px 2px 4px #e4a9fe;">TOMORROW X TOGETHER</h2><br><br>
						        <strong style="text-shadow: 2px 2px 4px #e4a9fe;"><p style="text-shadow: 2px 2px 4px #e4a9fe;">TXT</strong><br>
						        <strong style="text-shadow: 2px 2px 4px #e4a9fe;">6TH ANNIVERSARY</strong><br></p>
						        <p style="font-size: 18px; text-shadow: 2px 2px 4px #e4a9fe;">FANZY샵에서 만나보세요!</p>
						    </div>
			            	<a><img src="/images/index_login/tom.png"></a>
			            </div>
			            <div class="event-card">
			            	<div style="left:20%" class="text-overlay">
							    <h2 style="font-size: 20px; text-shadow: 2px 2px 4px #5ebb25;">ISEGYE IDOL</h2><br><br>
						        <p style="text-shadow: 2px 2px 4px #5ebb25;">버츄얼아이돌?<br>
						        <strong style="text-shadow: 2px 2px 4px #5ebb25;">But your idol.. ♡</strong><br></p>
						        <p style="font-size: 18px; text-shadow: 2px 2px 4px #5ebb25;">이세돌 굿즈 출시!</p>
						    </div>
			            	<a><img src="/images/index_login/idol.jpg"></a>
			            </div>
			            <div class="event-card">
			            	<div style="left:25%" class="text-overlay">
							    <h2 style="font-size: 20px; text-shadow: 2px 2px 4px #e4a9fe;">aespa</h2><br><br>
						        <p style="text-shadow: 2px 2px 4px #e4a9fe;">새로운 차원의 음악<br>
						        <strong style="text-shadow: 2px 2px 4px #e4a9fe;">Next Level</strong><br></p>
						        <p style="text-shadow: 2px 2px 4px #e4a9fe;">MEMBERSHIP OPEN</p>
						    </div>
			            	<a><img src="/images/index_login/aespa.jpg"></a>
			            </div>
			            <div class="event-card">
			            	<div style="left:25%" class="text-overlay">
							    <h2 style="font-size: 20px; text-shadow: 2px 2px 4px #e4a9fe;">SEVENTEEN</h2><br><br>
						        <p style="text-shadow: 2px 2px 4px #e4a9fe;">다양한 소통을 원해?<br>
						        <strong style="text-shadow: 2px 2px 4px #e4a9fe;">캐럿이 되어보세요!</strong><br></p>
						        <p style="font-size: 18px; text-shadow: 2px 2px 4px #e4a9fe;">MEMBERSHIP OPEN</p>
						    </div>
			            	<a><img src="/images/index_login/universe2.jpg"></a>
			            </div>
			        </div>
			    </div>
			    <button class="slide-btn next-btn">&#10095;</button>
			</section>
			<!-- 진행 상태 표시 (회색 실선과 검정 실선) -->
		    <div class="progress-bar">
		        <div class="progress"></div>
		    </div>
	        
	        <!-- 공지사항(로그인 안하면 광고만 뜸) -->
	        <section class="notice">
				<c:if test="${session_id!=null}">
		    	<a href="/noticelist">
					<div>
					    <h3>띵동! 첫 DM 메시지가 도착했어요!</h3>
						<p>멤버십 구독하고, 프라이빗 메시지에서만 볼 수 있는 특별한 소식을 확인하세요!<p>
					</div>
			    	<img alt="notice" src="/images/index_login/notice1.jpg">
				</a>
			    </c:if>
				<c:if test="${session_id==null}">
			    	<img alt="notice" src="/images/index_login/ad.png">
			    </c:if>
			</section>
	
	        <!-- 굿즈샵 -->
	        <c:if test="${session_id!=null}">
		        <section class="merch">
				    <h2>Merch</h2>
				    <div class="merch-container">
				        <div class="merch-item">
				            <div class="temBox"><img src="/images/index_login/goods1.png" alt="PLAVE OFFICIAL LIGHT STICK"></div>
				            <p class="merch-title">PLAVE OFFICIAL LIGHT STICK</p>
				            <p class="merch-price">₩49,000</p>
				        </div>
				        <div class="merch-item">
				            <div class="temBox"><img src="/images/index_login/goods2.png" alt="Caligo Pt.1 (Fugitive Ver.)"></div>
				            <p class="merch-title">3rd Mini Album 'Caligo Pt.1' (Fugitive Ver.)</p>
				            <p class="merch-price">₩18,500</p>
				        </div>
				        <div class="merch-item">
				            <div class="temBox"><img src="/images/index_login/goods3.png" alt="Caligo Pt.1 (Vanguard Ver.) Random"></div>
				            <p class="merch-title">3rd Mini Album 'Caligo Pt.1' (Vanguard Ver.) Random</p>
				            <p class="merch-price">₩17,000</p>
				        </div>
				        <div class="merch-item">
				            <div class="temBox"><img src="/images/index_login/goods4.png" alt="Caligo Pt.1 (POCAALBUM Ver.)"></div>
				            <p class="merch-title">3rd Mini Album 'Caligo Pt.1' (POCAALBUM Ver.)</p>
				            <p class="merch-price">₩13,300</p>
				        </div>
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
			        	<c:forEach var="i" begin="0" end="20" step="1" varStatus="status">
			                <!-- 새로운 행(tr) 시작 (5개마다) -->
			                <c:if test="${status.index % 5 == 0}">
			                    <tr>
			                </c:if>
			
			                <td>
			                    <div class="artist-card">
			                       <a href=""><img src="/images/index_login/test.jpg" alt="Artist"></a> 
			                        <div class="artist-name">아티스트명</div>
			                    </div>
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