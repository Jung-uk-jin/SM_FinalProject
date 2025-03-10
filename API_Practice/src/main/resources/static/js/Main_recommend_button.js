document.addEventListener('DOMContentLoaded', function() {
    const openModalButton = document.getElementById('openModalButton');
    const modal = document.getElementById('modal');
    const closeButton = document.querySelector('.close-btn');

    // 모달 열기
    openModalButton.addEventListener('click', function() {
        modal.style.display = 'block';  // 모달을 보이게 설정
        modal.style.opacity = '0';      // 애니메이션 초기 설정
        modal.style.transform = 'translateY(100%)'; // 아래쪽에서 시작

        // 애니메이션 적용 후 스타일을 변경
        setTimeout(function() {
            modal.style.transition = 'transform 0.5s ease-out, opacity 0.5s ease-out'; 
            modal.style.opacity = '1';
            modal.style.transform = 'translateY(0)';
        }, 10); // 약간의 지연을 주어 애니메이션을 적용
    });

    // 모달 닫기
    closeButton.addEventListener('click', function() {
        modal.style.opacity = '0';      // 닫을 때 애니메이션 효과
        modal.style.transform = 'translateY(100%)'; // 다시 아래로 내려가기

        // 모달을 숨긴 후 display: none으로 설정
        setTimeout(function() {
            modal.style.display = 'none';
        }, 500); // 애니메이션 후 숨기기
    });
});
