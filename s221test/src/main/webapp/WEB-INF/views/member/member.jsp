<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>회원가입</title>
  <script src="http://code.jquery.com/jquery-latest.min.js"></script>
  <style>
    /* 전체 레이아웃 */
    body {
      margin: 0; 
      padding: 0;
      font-family: sans-serif;
      background-color: #f9f9f9;
    }
    .signup-container {
      width: 600px;
      margin: 50px auto;
      background-color: #fff;
      border: 1px solid #ddd;
      border-radius: 8px;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
      padding: 30px;
    }
    .signup-title {
      text-align: center;
      font-size: 20px;
      margin-bottom: 20px;
      font-weight: bold;
    }
    .signup-form label {
      display: block;
      margin-top: 15px;
      font-weight: 600;
    }
    .signup-form input[type="text"],
    .signup-form input[type="password"],
    .signup-form input[type="date"],
    .signup-form select {
      width: 100%;
      height: 36px;
      box-sizing: border-box;
      margin-top: 5px;
      padding: 0 8px;
      font-size: 14px;
    }
    .signup-form .row-inline {
      display: flex;
      align-items: center;
      gap: 8px;
    }
    .signup-form .row-inline input[type="text"] {
      flex: 1;
    }
    .error-msg {
      color: red;
      font-size: 13px;
      margin-top: 5px;
      display: none; /* 기본은 숨김 */
    }
    /* 비밀번호 안내 문구/조건 충족 시 색상 변화 예시 */
    .pw-msg {
      font-size: 13px;
      margin-top: 5px;
      color: #999;
    }
    .pw-msg.valid {
      color: green;
    }
    .pw-msg.invalid {
      color: red;
    }

    /* 버튼 */
    .btn-dup-check {
      height: 36px;
      padding: 0 12px;
      background-color: #03c75a;
      color: #fff;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 14px;
    }
    .btn-dup-check:hover {
      background-color: #02a74a;
    }
    .btn-search {
      height: 36px;
      padding: 0 12px;
      background-color: #4285f4;
      color: #fff;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 14px;
    }
    .btn-search:hover {
      background-color: #3074e6;
    }
    .btn-submit {
      width: 100%;
      height: 48px;
      background-color: #F5C3B2;
      color: #fff;
      font-size: 16px;
      font-weight: 600;
      border: none;
      border-radius: 4px;
      margin-top: 30px;
      cursor: pointer;
    }
    .btn-submit:hover {
      color: #F5C3B2;
      background-color: #f5f5f5;
    }
    .radio-group {
      margin-top: 5px;
    }
    .radio-group label {
      font-weight: normal;
      margin-right: 15px;
    }

    /* 국가 선택 예시 (번호 표시) */
    .country-select {
      width: 100%;
      margin-top: 5px;
    }

    /* 숨김 처리 (membership=0) */
    input[type="hidden"] {
      display: none;
    }
  </style>
</head>
<body>
  <div class="signup-container">
    <h2 class="signup-title">회원가입</h2>
    
    <form class="signup-form" action="/memberInput" method="post" onsubmit="return validateForm()">
      <!-- 아이디 -->
      <label for="member_id">아이디</label>
      <div class="row-inline">
        <input type="text" id="member_id" name="member_id" placeholder="아이디 입력" required />
        <button type="button" class="btn-dup-check" onclick="checkDuplicate()">중복확인</button>
      </div>
      <span class="error-msg" id="id-error-msg">이미 사용 중인 아이디입니다.</span>
      
      <!-- 비밀번호 -->
      <label for="member_pw">비밀번호</label>
      <input type="password" id="member_pw" name="member_pw" placeholder="비밀번호 (8 - 32자)" required />
      <div class="pw-msg" id="pw-msg">8~32자 이내로 입력하세요.</div>
      
      <!-- 이름 -->
      <label for="member_name">이름</label>
      <input type="text" id="member_name" name="member_name" placeholder="실명 입력" required />
      
      <!-- 닉네임 -->
      <label for="member_nickname">닉네임</label>
      <input type="text" id="member_nickname" name="member_nickname" placeholder="닉네임 입력" required />
      
      <!-- 이메일 (아이디 + 도메인) -->
      <label for="member_email">이메일</label>
      <div class="row-inline">
        <input type="text" id="email_local" placeholder="이메일 아이디" style="flex:1" required />
        <span>@</span>
        <select id="email_domain" style="flex:1">
          <option value="naver.com">naver.com</option>
          <option value="gmail.com">gmail.com</option>
          <option value="hanmail.net">hanmail.net</option>
          <option value="hotmail.com">hotmail.com</option>
        </select>
      </div>
      <!-- 실제 서버로 전송할 hidden input -->
      <input type="hidden" id="member_email" name="member_email" />
      
      <!-- 생년월일 -->
      <label for="member_birth">생년월일</label>
      <input type="text" id="member_birth" name="member_birth" placeholder="YYYY-MM-DD" oninput="formatBirthDate(this)" />
      
      <!-- 전화번호 -->
      <label for="member_phone">전화번호</label>
      <input type="text" id="member_phone" name="member_phone" placeholder="010-1234-5678" oninput="formatPhone(this)" />
      
      <!-- 성별 -->
      <label for="member_gender">성별</label>
        <select id="member_gender" name="member_gender">
          <option value="남자">남자</option>
          <option value="여자">여자</option>
        </select>
        
      <!-- 주소 (우편번호 검색 + 상세주소) -->
      <label for="member_address">주소</label>
      <div class="row-inline">
        <input type="text" id="postcode" placeholder="우편번호" style="flex:1" />
        <button type="button" class="btn-search" onclick="searchPostcode()">검색</button>
      </div>
      <input type="text" id="member_address" name="member_address" placeholder="주소 (검색 후 자동입력)" required />
      <input type="text" id="detailAddress" placeholder="상세주소" />
      
      <!-- 국가/지역 (번호 표시) -->
      <label for="member_country">국가/지역</label>
      <select id="member_country" name="member_country" class="country-select" required>
        <option value="대한민국">대한민국 (+82)</option>
        <option value="일본">일본 (+81)</option>
        <option value="미국">미국 (+1)</option>
        <option value="중국">중국 (+86)</option>
      </select>
      
      <!-- membership hidden: 0 -->
      <input type="hidden" name="member_membership" value="0" />
      
      <!-- usertype (fan / artist) -->
      <label>사용자 유형</label>
      <div class="radio-group">
        <label><input type="radio" name="member_usertype" value="fan" checked /> Fan</label>
        <label><input type="radio" name="member_usertype" value="artist" /> Artist</label>
      </div>
      
      
      <button type="submit" class="btn-submit">가입하기</button>
    </form>
  </div>

  <script>
    // 아이디 중복확인 (예시)
    function checkDuplicate() {
      const memberId = document.getElementById('member_id').value.trim();
      if(!memberId) {
        alert("아이디를 입력하세요.");
        return;
      }
      
      $.ajax({
          url: '/checkMemberId',
          type: 'POST',
          data: { memberId: memberId },
          dataType: 'json',
          success: function(data) {
            if (data.exists) {
              $('#id-error-msg').show();
            } else {
              $('#id-error-msg').hide();
              alert("사용 가능한 아이디입니다.");
            }
          },
          error: function(xhr, status, error) {
            console.error("Error:", error);
          }
        });
    }
    
    // 비밀번호 길이 검사
    const pwInput = document.getElementById('member_pw');
    const pwMsg = document.getElementById('pw-msg');
    pwInput.addEventListener('input', () => {
      const val = pwInput.value;
      if(val.length >= 8 && val.length <= 32) {
        pwMsg.textContent = "사용 가능한 비밀번호입니다.";
        pwMsg.classList.add('valid');
        pwMsg.classList.remove('invalid');
      } else {
        pwMsg.textContent = "8~32자 이내로 입력하세요.";
        pwMsg.classList.add('invalid');
        pwMsg.classList.remove('valid');
      }
    });

    // 이메일 domain과 local 합쳐서 hidden input으로 전달
    const emailLocal = document.getElementById('email_local');
    const emailDomain = document.getElementById('email_domain');
    const emailHidden = document.getElementById('member_email');
    function updateEmail() {
      emailHidden.value = emailLocal.value + "@" + emailDomain.value;
    }
    emailLocal.addEventListener('input', updateEmail);
    emailDomain.addEventListener('change', updateEmail);

    // 생년월일 자동 포맷 (YYYY-MM-DD)
    function formatBirthDate(obj) {
      // 모든 숫자 이외의 문자는 제거
      let val = obj.value.replace(/\D/g, '');
      
      // 4자리 이상이면 'YYYY-' 형태로 만들어주기
      if (val.length >= 4) {
        val = val.slice(0,4) + '-' + val.slice(4);
      }
      // 7자리 이상이면 'YYYY-MM-' 형태로 만들어주기
      if (val.length >= 7) {
        val = val.slice(0,7) + '-' + val.slice(7);
      }
      
      // 최대 10자리까지만 허용 (YYYY-MM-DD)
      if (val.length > 10) {
        val = val.slice(0,10);
      }
      
      obj.value = val;
    }

    // 전화번호 자동 포맷 (010-1234-5678)
    function formatPhone(obj) {
      // 숫자 이외의 문자는 제거
      let val = obj.value.replace(/\D/g, '');
      
      let result = '';
      
      // 3자리 이하
      if (val.length < 4) {
        result = val;
      }
      // 7자리 이하 (3자리 + - + 나머지)
      else if (val.length < 8) {
        result = val.slice(0,3) + '-' + val.slice(3);
      }
      // 그 이상 (3자리 + - + 4자리 + - + 나머지)
      else {
        result = val.slice(0,3) + '-' + val.slice(3,7) + '-' + val.slice(7,11);
      }

      obj.value = result;
    }
    
    // 우편번호 검색 (실제 Daum 주소 API 연동 시 여기에 추가)
    function searchPostcode() {
      alert("우편번호 검색 창 오픈 (Daum 우편번호 서비스 등 연동)");
      // 예시로 임의 값 대입
      document.getElementById('postcode').value = "12345";
      document.getElementById('member_address').value = "서울시 강남구 테헤란로 123";
    }

    // 폼 최종 검증
    function validateForm() {
      // 비밀번호 유효성
      const pwVal = pwInput.value;
      if(pwVal.length < 8 || pwVal.length > 32) {
        alert("비밀번호는 8~32자 이내로 입력해주세요.");
        pwInput.focus();
        return false;
      }
      // 이메일 값 업데이트
      updateEmail();
      // 기타 필요한 검증 로직 추가
      
      return true; // 통과 시 폼 전송
    }
  </script>
</body>
</html>