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


// 5. 회원탈퇴 클릭 시
function deactivateAccount() {
    location.href = "/deactivate";  // 탈퇴 페이지로 이동
} // 5번 종료


// 6. 사이드 바 클릭 시
$(document).ready(() => {
    
    $(".reward-points").click(() => {
        const headerHeight = 300;  
        $('html, body').animate({
            scrollTop: $(".subscribe").offset().top - headerHeight  // .couponHere 위치에서 헤더 높이만큼 빼기
        }, 500);  // 500ms 동안 부드럽게 스크롤
    });
    
    $(".order").click(() => {
        const headerHeight = 300;  
        $('html, body').animate({
            scrollTop: $(".order-history").offset().top - headerHeight  // .couponHere 위치에서 헤더 높이만큼 빼기
        }, 500);  // 500ms 동안 부드럽게 스크롤
    });
    
    $(".return").click(() => {
        const headerHeight = 300;  
        $('html, body').animate({
            scrollTop: $(".return-exchange").offset().top - headerHeight  // .couponHere 위치에서 헤더 높이만큼 빼기
        }, 500);  // 500ms 동안 부드럽게 스크롤
    });
    
    $(".review").click(() => {
        const headerHeight = 300;  
        $('html, body').animate({
            scrollTop: $(".my-reviews").offset().top - headerHeight  // .couponHere 위치에서 헤더 높이만큼 빼기
        }, 500);  // 500ms 동안 부드럽게 스크롤
    });
    
    $(".viewed").click(() => {
        const headerHeight = 300;  
        $('html, body').animate({
            scrollTop: $(".recently-viewed").offset().top - headerHeight  // .couponHere 위치에서 헤더 높이만큼 빼기
        }, 500);  // 500ms 동안 부드럽게 스크롤
    });
}); // 6번 끝



    
