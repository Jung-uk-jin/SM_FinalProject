<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <title>좌석 선택 및 결제</title>
    <link rel="stylesheet" href="../css/ticket/paymentPopUp2.css">
    <script src="/socket.io/socket.io.js"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <script src="../js/ticket/paymentPopUp2.js"></script>
</head>
<body>
<div class="header">
    <select class="date-select">
        <option value="2025-03-01 16:00">2025년 3월 1일 16:00</option>
        <option value="2025-03-02 18:00">2025년 3월 2일 18:00</option>
        <option value="2025-03-03 20:00">2025년 3월 3일 20:00</option>
    </select>
    <div class="logo"></div> <!-- 로고 이미지 -->
</div>
<div class="popup">
    <div class="payment-method">
        <h2>결제방식 선택</h2>
        <div class="method-list">
            <label><input type="radio" name="payment" checked> 신용카드</label>
            <label><input type="radio" name="payment"> KB Pay</label>
            <label><input type="radio" name="payment"> 카카오페이</label>
            <label><input type="radio" name="payment"> 무통장입금</label>
            <label><input type="radio" name="payment"> PAYCO</label>
            <label><input type="radio" name="payment"> 공연예매권</label>
        </div>
        <div class="point-info">
            <h3>사용가능한 포인트</h3>
            <ul>
                <li>마이신한포인트 <button>포인트조회</button></li>
                <li>씨티포인트 <button>포인트조회</button></li>
                <li>삼성포인트 <button>포인트조회</button></li>
                <li>외환 YES포인트 <button>포인트조회</button></li>
            </ul>
        </div>
    </div>

    <div class="payment-input">
        <h2>결제수단 입력</h2>
        <div class="card-info">
            <label><input type="radio" name="card" value="general" checked> 일반신용카드</label>
            <select style="margin: 0; margin-bottom: 10px;">
			    <option>카드종류를 선택하세요</option>
			    <option>하나카드 (1만원 청구할인)</option>
			    <option>인터파크롯데카드 (5% 청구할인)</option>
			    <option>NOL 카드 (10% 적립)</option>
			</select>

            <label><input type="radio" name="card" value="hana"> 하나컬쳐카드</label>
            <label><input type="radio" name="card" value="inter"> 인터파크롯데카드</label>
            <label><input type="radio" name="card" value="nol"> NOL 카드</label>
        </div>
        <div class="promotion-banner">
            <img src="../images/banner.png" alt="할인 배너">
        </div>
    </div>

    <div class="sidebar">
        <div class="ticket-info">
            <p>정동원 이야기 3rd 전국투어 콘서트 -</p>
            <p>2025.04.12 ~ 2025.04.13</p>
            <p>부산 벡스코 오디토..</p>
            <p>8세이상 관람가능</p>
            <p>관람시간 : 150분</p>
        </div>
        <h2>MY예매정보</h2>
        <table class="my-table">
            <tr>
                <th>일시</th>
                <td>2025년 4월 12일(토) 17:00</td>
            </tr>
            <tr>
                <th>선택좌석</th>
                <td>S석 2층 E구역 3열 10번</td>
            </tr>
            <tr>
                <th>티켓금액</th>
                <td>110,000원</td>
            </tr>
            <tr>
                <th>수수료</th>
                <td>2,000원</td>
            </tr>
            <tr>
                <th>배송료</th>
                <td>3,200원</td>
            </tr>
            <tr class="total-row">
                <th>총 결제금액</th>
                <td class="total">115,200원</td>
            </tr>
        </table>
        <button class="prevStepBtn">이전단계</button>
        <button class="nextStepPayBtn">결제하기</button>
    </div>
</div>
</body>
</html>
