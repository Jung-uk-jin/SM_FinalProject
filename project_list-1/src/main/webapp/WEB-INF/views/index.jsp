<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <script src="https://kit.fontawesome.com/516da99189.js" crossorigin="anonymous"></script>
    <title>Weverse Clone</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Noto Sans KR', sans-serif;
        }
        body {
            background-color: #eef1f7;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .navbar {
            width: 100%;
            background: white;
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
        }
        .navbar .menu {
        	margin-right:40px;
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
        }
        
        a {
            all: unset;
            cursor: pointer;
        }
        .artist-section {
            margin-top: 40px;
            text-align: center;
        }
        .artist-section h2 {
            font-size: 1.8rem;
            color: #333;
            margin-bottom: 20px;
        }
        .artist-table {
            border-collapse: separate;
            border-spacing: 30px;
            width: auto;
            margin: auto;
        }
        .artist-table td {
         	border-radius: 30px;
            width: 200px;
            height: 200px;
            background-color: white;
            text-align: center;
            font-size: 1rem;
            font-weight: bold;
            border: 1px solid #aaa;
        }
        .artist-card {
		    width: 100%;  
		    height: 230px; /* 고정된 높이 설정 (줄어들지 않게) */
		    display: flex;
		    flex-direction: column;
		    align-items: center;
		    justify-content: space-between;
		}	
        .artist-card img {
        	border-top-left-radius: 30px;
			border-top-right-radius: 30px;
		    width: 200px;
		    height: 170px; /* 원하는 높이로 조정 */
		    object-fit: cover; /* 비율을 유지하면서 잘라내기 */
		}
		.artist-name {
			margin-bottom: 20px;
			
		    font-size: 1.5rem;
		    font-weight: bold;
		    text-align: center;
		    padding-top: 5px;
		}
		
		
		
						
		.slider-container {
            position: relative;
            width: 100%;
            max-width: 800px;
            margin: auto;
            overflow: hidden;
        }
        .slides {
            display: flex;
            transition: transform 0.5s ease-in-out;
        }
        .slides img {
            width: 100%;
        }
        .prev, .next {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background-color: rgba(0,0,0,0.5);
            color: white;
            border: none;
            padding: 10px;
            cursor: pointer;
        }
        .prev { left: 10px; }
        .next { right: 10px; }
        
        
        
        footer {
        width: 100%;
        background: #f8f9fa;
        padding: 20px 0;
        font-size: 14px;
        color: #666;
        text-align: center;
        line-height: 1.6;
    }

    .footer-links {
        margin-bottom: 10px;
    }

    .footer-links a {
        color: #666;
        text-decoration: none;
        margin: 0 5px;
    }

    .footer-links a:hover {
        text-decoration: underline;
    }

    .footer-info p {
        margin: 5px 0;
    }

    .footer-info a {
        color: #007aff;
        text-decoration: none;
        font-weight: bold;
    }

    .footer-info a:hover {
        text-decoration: underline;
    }
        
	</style>
</head>

<body>
 
    <div class="navbar">
        <div class="logo" style="font-size: 1.5rem; font-weight: bold; color: #00aaff; background: none; border: none; cursor: pointer; font-family: inherit;"><a href="/">A&F</a></div>
        <div class="menu">
            <button onclick="location.href='/mobile'" style="font-size: 1.5rem; font-weight: bold; color: #00aaff; background: none; border: none; cursor: pointer; font-family: inherit;">sign</button>
            <div class="divider"></div>
            <button onclick="location.href='#'" style="font-size: 1.5rem; font-weight: bold; color: #00aaff; background: none; border: none; cursor: pointer; font-family: inherit;">알림</button>
            <button onclick="location.href='#'" style="font-size: 1.5rem; font-weight: bold; color: #00aaff; background: none; border: none; cursor: pointer; font-family: inherit;">스토어</button>
        </div>
    </div>
    
    
    
	<div class="slider-container">
        <div class="slides">
            <img src="images/신인남돌.jpg" alt="Slide 1">
            <img src="images/신인여돌.jpg" alt="Slide 2">
            <img src="images/universe2.jpg" alt="Slide 3">
        </div>
        <button class="prev" onclick="moveSlide(-1)">&#10094;</button>
        <button class="next" onclick="moveSlide(1)">&#10095;</button>
    </div>
    
	<script>
    document.addEventListener("DOMContentLoaded", function () {
        let currentIndex = 0;
        const slides = document.querySelector(".slides");
        const totalSlides = document.querySelectorAll(".slides img").length;

        function moveSlide(step) {
            currentIndex = (currentIndex + step + totalSlides) % totalSlides;
            slides.style.transform = `translateX(${-currentIndex * 100}%)`;
        }

        function autoSlide() {
            moveSlide(1);
        }
        
        setInterval(autoSlide, 2000);
    });
</script>

    
    <!-- 아티스트 -->
    <div class="artist-section">
    <h2>새로운 아티스트를 만나보세요</h2>
    <table class="artist-table">
        <tbody>
            <c:forEach items="${list}" var="adto" varStatus="status">
                <!-- 새로운 행(tr) 시작 (5개마다) -->
                <c:if test="${status.index % 5 == 0}">
                    <tr>
                </c:if>

                <td>
                	<a href="/artist?artist_no=${adto.artist_no }">
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

</body>


<footer>
    <div class="footer-links">
        <a href="#">이용약관</a>  |  
        <a href="#">서비스운영정책</a>  |  
        <a href="#">유료서비스 이용약관</a>  |  
        <a href="#">청소년 보호 정책</a>  |  
        <a href="#">개인정보처리방침</a>  |  
        <a href="#">쿠키정책</a>  |  
        <a href="#">쿠키 설정</a>  |  
        <a href="#">입점 신청</a>  |  
        <a href="#">고객센터</a>
    </div>

    <div class="footer-info">
        <p>상호 <strong>Weverse Company Inc.</strong>  |  대표자 <strong>임민영</strong>  |  
           전화번호 <strong>1544-0790</strong>  |  FAX <strong>+82)-2-2144-9399</strong>  |  
           주소 <strong> 서울 서초구 동작대로 132, 안석빌딩 9층</strong>  |  
           사업자등록번호 <strong>119-86-20319</strong>  |  
           <a href="#">사업자 정보 확인</a>
        </p>
        <p>통신판매업 신고번호 <strong>2022-성남분당A-0557호</strong>  |  
           호스팅 서비스 사업자 <strong>Amazon Web Services, Inc., Naver Cloud</strong></p>
        <p>© <strong>WEVERSE COMPANY Inc.</strong> Ver 2.32.6</p>
    </div>
</footer>
</html>

