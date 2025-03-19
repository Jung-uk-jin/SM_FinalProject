<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fm"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>아티스트 물건 전체</title>
<link rel="stylesheet" as="style" crossorigin
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable.min.css" />
<link rel="stylesheet" href="/css/updownstyle.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	
<style>
/* 기본 스타일 초기화 */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: "Pretendard Variable", sans-serif;
	background-color: #fff;
}

.container {
	max-width: 1200px; /* 페이지 전체 너비 */
	width: 100%;
	margin: 5px auto;
	padding: 20px;
}

/* 필터 메뉴 */
.filters {
	display: flex;
	align-items: center;
	margin-bottom: 20px;
}

.filters .filter {
	text-decoration: none;
	color: #333;
	margin-right: 15px;
	font-size: 16px;
	padding: 8px 16px;
	border-radius: 20px;
	background-color: #f1f1f1;
	transition: background-color 0.2s ease, color 0.2s ease;
}

.filters .filter:hover {
	background-color: #eaeaea;
}

.filters .filter.active {
	font-weight: bold;
	background-color: #000;
	color: #fff;
}

.filters label {
	margin-left: auto;
	font-size: 16px;
	color: #333;
	cursor: pointer;
	display: flex;
	align-items: center;
}

.filters input[type="checkbox"] {
	margin-right: 5px;
}

/* 제품 목록: 5열 그리드, 카드 사이 간격 20px */
.product-list {
	display: grid;
	grid-template-columns: repeat(5, 205px); /* 카드 폭 205px, 한 줄에 5개 */
	justify-content: space-between; /* 필요하면 수정 */
	gap: 20px;
}

/* 각 카드(텍스트 영역엔 테두리 X, 전체 높이는 유동) */
.product-item {
	width: 205px;
	background-color: #fff;
	position: relative;
}

a {
	text-decoration: none;
}

/* 사진 영역 (205 x 205)만 회색 배경 + 테두리 */
.product-image {
	position: relative; /* 오버레이를 위한 기준 위치 */
	width: 205px;
	height: 205px;
	background-color: rgba(0, 0, 0, 0.04);
	border: 1px solid #ccc;
	border-radius: 10px;
	overflow: hidden;
}

.overlay {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	display: flex;
	align-items: center;
	justify-content: center;
	transform: translateZ(20px); /* z축 효과 */
	opacity: 0.7; /* 투명도 조절 */
	pointer-events: none; /* 클릭 이벤트 무시 */
}

.overlay img {
	max-width: 100%;
	max-height: 100%;
	object-fit: contain;
}

.product-image img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	mix-blend-mode: multiply;
}

.product-image img:hover {
	transform: scale(1.02);
}

/* Sold Out 라벨 스타일 */
.sold-out-label {
	position: absolute;
	top: 10px;
	right: 10px;
	background: rgba(0, 0, 0, 0.6);
	color: #fff;
	padding: 4px 6px;
	font-size: 12px;
	border-radius: 3px;
}

/* 제품명 & 가격 (테두리 없음) */
.product-name {
	font-size: 14px;
	color: #333;
	margin: 10px;
	margin-bottom: 4px;
	font-weight: 600;
}

.product-price {
	font-size: 14px;
	font-weight: bold;
	color: #000;
	margin: 0 10px 10px;
}

/* 이미지 슬라이더 스타일 */
.slider-container {
	margin-top: 30px;
	position: relative;
	width: 1905px;
	height: 400px;
	overflow: hidden;
}

.slide {
	position: absolute;
	width: 100%;
	height: 100%;
	object-fit: cover;
}
</style>
</head>

<body>
 <header class="WeverseXk21_header">
    <div class="WeverseXk21_logo" id="logo">
        <a href="/"><img src="/images/index_login/logo.png" alt="Logo"></a>
    </div>
    <!-- nav_bar -->
    <nav class="WeverseXk21_nav">
        <ul>
            <c:if test="${session_id==null}">
                <li><button type="button" class="WeverseXk21_sign_in">Sign in</button></li>
            </c:if>
            <c:if test="${session_id!=null}">
                <li><a onclick="searchBtn()">
                    <i class="fa-solid fa-magnifying-glass WeverseXk21_icon_solid"></i>
                    <div id="searchBox" class="WeverseXk21_search_wrapper" style="display: none;">
                        <input style="position: absolute; top:-15px; right:20px;" type="text" id="searchInput" class="WeverseXk21_search_input" placeholder="아티스트 검색" />
                        <div id="searchResults" style="display: none; position: absolute; top: 40px; left: -200px; background: white; border-radius: 10px; box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2); width: 200px; padding: 8px 15px;"></div>
                    </div>
                </a></li>
                <li><a onclick="openAlert()"><i style="font-size: 35px; position: relative; top: -5px;" class="fa-regular fa-envelope WeverseXk21_icon_regular"></i></a></li>
                <li><a href="/mypage"><i class="fa-regular fa-user WeverseXk21_icon_regular"></i></a></li>
                <li><a href="/user_setting"><i class="fa-solid fa-gear WeverseXk21_icon_solid"></i></a></li>
                <li class="WeverseXk21_cart WeverseXk21_coin"><a href="/smain"><img src="/images/index_login/coin.png"></a></li>
                <li class="WeverseXk21_cart" style="position: relative; top:-1px;"><a onclick="cartBtn()"><i class="fa-solid fa-cart-shopping WeverseXk21_icon_cart"></i></a></li>
            </c:if>
            <c:if test="${session_id==null}">
                <li class="WeverseXk21_cart WeverseXk21_coin"><a href="/smain"><img src="/images/index_login/coin.png"></a></li>
                <li class="WeverseXk21_cart" style="position: relative; top:4px;"><a onclick="cartBtn()"><i class="fa-solid fa-cart-shopping WeverseXk21_icon_cart"></i></a></li>
            </c:if>
        </ul>
    </nav>
</header>

	<!-- 이미지 고유 ID앞 링크 -->
	<c:set var="baseurl" value="https://lh3.googleusercontent.com/d/" />
	
	<!-- Banner -->
	<div class="slider-container">
		<img class="slide" 
			src="${baseurl}1iqnqezaYvtOsfl6ZcOOK3AnZ4B2ZgdiE"
			alt="shopmainbanner"
			onerror="this.onerror=null; this.src='https://picsum.photos/1980/400';" />
	</div>
	<!-- Banner -->

	<!-- container -->
	<div class="container">
	
		<!-- 카테고리, 품절제외 -->
		<div class="filters">
			<a href="#" class="filter active"
				onclick="filterCategory('All', this); return false;">All</a>
			<c:forEach items="${categories}" var="s">
				<a href="#" class="filter"
					onclick="filterCategory('${s}', this); return false;">${s}</a>
			</c:forEach>
			<label> <input type="checkbox" id="hideSold"
				onchange="toggleSoldOut();" /> Hide Sold Out
			</label>
		</div>

		<!-- 제품 목록 -->
		<div class="product-list">
			<c:forEach items="${slist}" var="sdto">
				<div
					class="product-item ${sdto.shop_quantity == 0 ? 'sold-out-item' : ''}"
					data-category="${sdto.shop_category}">
				<a href="/sprodview?shopNo=${sdto.shop_no}">
					<div class="product-image">
						<img src="${baseurl}${sdto.shop_image1}" alt="${sdto.shop_title}"
							onerror="this.onerror=null; this.src='${baseurl}17z6AniRT9Im-Ouxy_7qgqTuJdcR37bhU';" />
						<c:if test="${sdto.shop_quantity == 0}">
							<!-- 품절 오버레이 -->
							<div class="overlay">
								<img src="${baseurl}1pzz7P_CCwBZKjhUBtPwkWJTyZ8Xwia4m" alt="Sold Out" />
							</div>
						</c:if>
					</div>
					<div class="product-name">${sdto.shop_title}</div>
					<div class="product-price">
						<fm:formatNumber value="${sdto.shop_price}" pattern="#,###" /> ₩
					</div>
				</a>
				</div>
			</c:forEach>
			<c:if test="${empty slist}">
				<h1>해당 아티스트의 상품이 없습니다.</h1>
			</c:if>
		</div>
		<!-- 제품 목록 -->
				
	</div>
	<!-- container -->
<footer class="WeverseYb78_footer">
    <div class="WeverseYb78_footer_links">
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
    <div class="WeverseYb78_footer_info">
        <p>
            상호 &nbsp;<strong>Fanzy Company Inc.</strong>
            <span class="WeverseYb78_footer_gap">|</span>
            대표자 &nbsp;<strong>임민영</strong>
            <span class="WeverseYb78_footer_gap">|</span>
            전화번호 &nbsp;<strong>1544-0790</strong>
            <span class="WeverseYb78_footer_gap">|</span>
            FAX &nbsp;<strong>+82)-2-2144-9399</strong>
            <span class="WeverseYb78_footer_gap">|</span>
            주소 &nbsp;<strong> 서울 금천구 동작대로 132, 한라원앤원타워 3층</strong>
            <span class="WeverseYb78_footer_gap">|</span>
            사업자등록번호 &nbsp;<strong>119-86-20319</strong>
            <span class="WeverseYb78_footer_gap">|</span>
            <a href="#">사업자 정보 확인</a>
        </p>
        <p>
            통신판매업 신고번호 &nbsp;<strong>2022-금천가산P-0557호</strong>
            <span class="WeverseYb78_footer_gap">|</span>
            호스팅 서비스 사업자 &nbsp;<strong>Amazon Web Services, Inc., Naver Cloud</strong>
        </p>
        <p>© <strong>FANZY COMPANY Inc.</strong> Ver 2.32.6</p>
    </div>
</footer>


	<script>
    let currentCategory = 'All';

    function filterCategory(category, element) {
      currentCategory = category;
      document.querySelectorAll('.filter').forEach(link => {
        link.classList.toggle('active', link === element);
      });
      updateProductsDisplay();
    }

    function toggleSoldOut() {
      updateProductsDisplay();
    }

    function updateProductsDisplay() {
      const hideSold = document.getElementById('hideSold').checked;
      document.querySelectorAll('.product-item').forEach(item => {
        const matchesCategory = (currentCategory === 'All' || item.dataset.category === currentCategory);
        const isSoldOut = item.classList.contains('sold-out-item');
        if (matchesCategory && (!hideSold || !isSoldOut)) {
          item.style.display = '';
        } else {
          item.style.display = 'none';
        }
      });
    }
  </script>
</body>
</html>

