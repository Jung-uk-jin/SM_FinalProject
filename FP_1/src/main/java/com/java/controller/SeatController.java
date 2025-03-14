package com.java.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.apache.catalina.manager.util.SessionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.java.dto.AddressDto;
import com.java.dto.ApproveResponseDto;
import com.java.dto.ArtistDto;
import com.java.dto.CartDto;
import com.java.dto.ConcertDto;
import com.java.dto.ConcertScheduleDto;
import com.java.dto.MemberDto;
import com.java.dto.OrderItemDto;
import com.java.dto.ReadyResponseDto;
import com.java.dto.SeatDto;
import com.java.dto.TicketDto;
import com.java.service.AddressService;
import com.java.service.CartService;
import com.java.service.ConcertService;
//import com.java.service.KakaopayService;
import com.java.service.MService;
import com.java.service.SeatService;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller

//@RestController
//@RequestMapping("/seat")
public class SeatController {
	
	
	@Autowired HttpSession session;
	@Autowired
	private SeatService seatService;
	@Autowired MService memberService;
	@Autowired ConcertService concertService;
	@Autowired CartService cartservice;
	@Autowired AddressService addressService;
//	@Autowired KakaopayService kakaopayService;
	
	
	// 좌석 팝업 오픈 (선택한 일정의 좌석만 조회)
	@GetMapping("/ticketShop/seatPopUp")
	public String seatPopUp(@RequestParam("scheduleNo") Integer scheduleNo, String memberId, Model model) {
		memberId = (String)session.getAttribute("session_id");
		System.out.println("세션에 저장된 ID 1: " + memberId);
		
		List<ConcertScheduleDto> schedules = seatService.getAllSchedules(); // 콘서트 일정 조회
		List<SeatDto> seats = seatService.getSeatsBySchedule(scheduleNo); // 선택한 일정의 좌석 조회
		
		
		model.addAttribute("memberId",memberId);
		model.addAttribute("schedules", schedules); // jsp 로 전달
		model.addAttribute("seats", seats);
	    model.addAttribute("selectedScheduleNo", scheduleNo); // 선택한 일정 전달
		
		return "ticketShop/seatPopUp";
	}
	
	// ✅ 선택한 날짜의 좌석 데이터를 JSON으로 반환하는 API 추가
	@PostMapping("/ticketShop/seatPopUp/seatData")
	@ResponseBody
	public ResponseEntity<List<Map<String, Object>>> getSeatsBySchedule(@RequestParam("scheduleNo") Integer scheduleNo) {
	    List<SeatDto> seats = seatService.getSeatsBySchedule(scheduleNo);

	    // 불필요한 ConcertDto, ConcertScheduleDto, ArtistDto 제거
	    List<Map<String, Object>> simplifiedSeats = seats.stream().map(seat -> {
	        Map<String, Object> seatMap = new HashMap<>();
	        seatMap.put("seatNo", seat.getSeatNo());
	        seatMap.put("seatFloor", seat.getSeatFloor());
	        seatMap.put("seatLevel", seat.getSeatLevel());
	        seatMap.put("seatRow", seat.getSeatRow());
	        seatMap.put("seatCol", seat.getSeatCol());
	        seatMap.put("seatPrice", seat.getSeatPrice());
	        seatMap.put("isReserved", seat.isReserved());
	        seatMap.put("scheduleNo", seat.getConcertScheduleDto().getScheduleNo());
//	        seatMap.put("concertNo", seat.getConcertDto().getconcertNo());
	        return seatMap;
	    }).collect(Collectors.toList());

	    return ResponseEntity.ok(simplifiedSeats);
	}
	
	// 팝업 - 결제순서 1
	@GetMapping("/ticketShop/paymentPopUp")
	public String paymentPopUp(
			@RequestParam("scheduleNo") Integer scheduleNo,
			MemberDto memberDto, 
			String memberId, 
			Model model) {
		memberId = (String)session.getAttribute("session_id");
		String sessionNick = (String) session.getAttribute("session_nickname");
		System.out.println("세션에 저장된 ID 1: " + memberId);
		
		List<ConcertScheduleDto> schedules = seatService.getAllSchedules(); // 콘서트 일정 조회
		List<SeatDto> seats = seatService.getSeatsBySchedule(scheduleNo); // 선택한 일정의 좌석 조회
		
		
		// ✅ schedules 리스트에서 해당 scheduleNo에 맞는 ConcertScheduleDto 찾기
		ConcertScheduleDto concertScheduleDto = schedules.stream()
				.filter(s -> s.getScheduleNo() == scheduleNo)
		        .findFirst()
		        .get();
		
		if (memberId != null) {
	        MemberDto memberdto = memberService.findById(memberId);
	        List<AddressDto> aList = addressService.findByMemberNickname(sessionNick);
	        List<CartDto> cList = cartservice.findByMemberNickname(sessionNick);

	        ObjectMapper objectMapper = new ObjectMapper();

	        for (CartDto cart : cList) {
	            if (cart.getCart_items() != null) {
	                try {
	                    List<Map<String, Object>> parsedCartItems = objectMapper.readValue(
	                        cart.getCart_items(),
	                        new TypeReference<List<Map<String, Object>>>() {}
	                    );
	                    cart.setParsedCartItems(parsedCartItems); // ✅ JSON 변환한 데이터 저장
	                } catch (Exception e) {
	                    e.printStackTrace();
	                }
	            }
	        }

	        model.addAttribute("mdto", memberdto);
	        model.addAttribute("adto", aList);
	        model.addAttribute("cartList", cList); // ✅ CartDto 리스트 전달

	    }
		
		// ✅ ConcertDto 가져오기
		ConcertDto concertDto = concertScheduleDto.getConcertDto(); 
		System.out.println("concertDto: "+ concertDto);
		
		// ✅ 회원 정보 조회
		memberDto = memberService.findById(memberId);
		
		model.addAttribute("memberDto", memberDto);
		model.addAttribute("schedules", schedules); // jsp 로 전달
		model.addAttribute("seats", seats);
		model.addAttribute("concertScheduleDto", concertScheduleDto); // 일정 정보 추가
	    model.addAttribute("concertDto", concertDto); // 콘서트 정보 추가
	    model.addAttribute("selectedScheduleNo", scheduleNo); // 선택한 일정 전달
		return "ticketShop/paymentPopUp";
		
	}
	
	@PostMapping("/ticketShop/paymentPopUp")
	public String paymentPopUp(
			@RequestBody Map<String, Object> requestSeatData, Model model) {
	    System.out.println("선택된 좌석: " + requestSeatData.get("selectedSeats"));
	    
//	    List<Integer> selectedSeatNos = (List<Integer>) requestSeatData.get("selectedSeats");
//		System.out.println("선택된 좌석 번호들: " + selectedSeatNos.get(0));
//		System.out.println("선택된 좌석 번호들: " + selectedSeatNos);
//	    
//		List<SeatDto> selectedSeats = seatService.getSeatsByIds(selectedSeatNos.get(0),selectedSeatNos.get(1));
	    
//		SeatDto seatdto = seatService.getSeatsById(selectedSeatNos.get(0));
		
	    
	    model.addAttribute("selectedSeats", requestSeatData.get("selectedSeats"));
	    return "ticketShop/paymentPopUp"; 
	}

	
	// 팝업 - 결제순서 2
	@GetMapping("/ticketShop/paymentPopUp2")
	public String paymentPopUp2() {
		return "ticketShop/paymentPopUp2";
		
	}
	
	
	//카카오페이페이지 결제
//	@ResponseBody
//	@PostMapping("/pay/orderPay")
//	public ReadyResponseDto orderPay(OrderItemDto odto,TicketDto tdto) {
//		log.info("tdto name : "+tdto.getTicketTitle());
//		System.out.println("tdto name : "+tdto.getTicketTitle());
//		
//        // 카카오 결제 준비하기
//        ReadyResponseDto readyResponseDto = kakaopayService.payReady(odto,tdto);
//        
//        // 세션에 결제 고유번호(tid) 저장
//        SessionUtils.addAttribute("tid", readyResponseDto.getTid());
//        log.info("결제 고유번호: " + readyResponseDto.getTid());
//        return readyResponseDto;
//		
//	}
//	
//	@GetMapping("/pay/completed")
//    public String payCompleted(@RequestParam("pg_token") String pgToken) {
//    
//		//세션에서 tid값을 가져옴.
//        String tid = SessionUtils.getStringAttributeValue("tid");
//        log.info("결제승인 요청을 인증하는 토큰: " + pgToken);
//        log.info("결제 고유번호: " + tid);
//
//        // 카카오 결제 요청하기
//        ApproveResponseDto approveResponseDto = kakaopayService.payApprove(tid, pgToken);
//
//        System.out.println("승인날짜 : "+approveResponseDto.getApproved_at());
//        
//        return "redirect:/success";
//    }
		
		

}
