$(document).ready(function() {

	
	// ✅ 날짜 변경 시 seatPopUp 페이지로 이동(좌석은 자동 초기화)
	$('.date-select').on('change', function () {
        let scheduleNo = $(this).val();
		
		// seatPopUp 페이지로 이동하면서 scheduleNo를 전달
        window.location.href = "/ticketShop/seatPopUp?scheduleNo=" + scheduleNo;
    });
	
	
	

    // 다음 단계 버튼 클릭 이벤트 처리
    $('.prevStepBtn').on('click', function() {
        alert('이전 단계로 돌아갑니다.');
		let scheduleNo = $('.date-select').val();
		// seatPopUp 페이지로 이동하면서 scheduleNo를 전달
        window.location.href = "/ticketShop/seatPopUp?scheduleNo=" + scheduleNo;
    });
	
    $('.nextStepBtn').on('click', function() {
        alert('다음 단계로 넘어갑니다.');
		window.location.href = '/ticketShop/paymentPopUp2';
    });
	
	
});
