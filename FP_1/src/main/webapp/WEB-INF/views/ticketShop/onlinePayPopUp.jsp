<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스트리밍 티켓 주문창</title>
<link rel="stylesheet" href="../css/ticket/onlinePayPopUp.css">
 <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap" rel="stylesheet">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<div class="container">
        <h2 class="title">상품 결제</h2>
        <div class="product">
            <div class="product-image"></div>
            <div class="details">
                <h3>LIVE + Re-Streaming - aespa &lt; SYNK : PARALLEL LINE - ENCORE &gt;</h3>
            </div>
        </div>
        <div class="price-box">
            <div class="price-row"><span>상품금액</span><span>₩55,000</span></div>
            <div class="price-row"><span>사용 가능 리워드</span><span>0 pt</span></div>
            <div class="price-row"><span>사용 할 리워드</span>
                <select>
                    <option>포인트사용 안함</option>
                </select>
            </div>
            <hr>
            <div class="price-row"><strong>실결제 금액</strong><strong>₩55,000</strong></div>
            <div class="price-row"><span>지급 예정 리워드</span><span>55 pt</span></div>
        </div>
        <button class="pay-btn">결제하기</button>
    </div>

</body>
</html>