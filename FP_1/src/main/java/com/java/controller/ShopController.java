package com.java.controller;

import java.security.SecureRandom;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.java.dto.ArtistDto;
import com.java.dto.CartDto;
import com.java.dto.MemberDto;
import com.java.dto.NicknameDto;
import com.java.dto.OrderDto;
import com.java.dto.ReadyResponseDto;
import com.java.dto.ShopDto;
import com.java.repository.ShopRepository;
import com.java.service.AService;
import com.java.service.CartService;
import com.java.service.OrderService;
import com.java.service.SService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.java.dto.ApproveResponseDto;
import com.java.service.KakaopayService;
import com.java.service.MService;
import com.java.service.NicknameService;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ShopController {

	@Autowired HttpSession session;
	@Autowired SService shopService;
	@Autowired AService artistService;
	@Autowired MService memberService;
	@Autowired KakaopayService kakaopayService;
	@Autowired CartService cartService;
	@Autowired private OrderService orderService;
	@Autowired NicknameService nickService;
	@Autowired ShopRepository shopRepository;
	
	
	// 상점 메인 화면 호출
	@GetMapping("/smain")
	public String smain(HttpSession session, Model model) {
	    // 1. 모든 아티스트 목록 가져오기 (기본 데이터)
	    List<ArtistDto> list = artistService.findAll();
	    model.addAttribute("list", list);
	    
	    // 2. 로그인 상태 확인 (세션에서 닉네임 가져오기)
	    String sessionNick = (String) session.getAttribute("session_nickname");
	    System.out.println("로그인이름 : " + sessionNick);
	    
	    // 3. 로그인한 경우, 가입한 커뮤니티 정보 가져오기
	    if (sessionNick != null) {
	        // 닉네임을 이용해 사용자가 가입한 아티스트 목록 조회
	        List<NicknameDto> nlist = nickService.findByMemberDto_MemberNickname(sessionNick);
	        
	        // 닉네임 목록이 존재하는 경우 (가입한 커뮤니티가 있는 경우)
	        if (nlist != null && !nlist.isEmpty()) {
	            // nlist를 JSP에서 참조할 수 있도록 추가
	            model.addAttribute("nlist", nlist);
	            
	            // 필터링된 아티스트 목록도 따로 생성하지 않고 nlist만 사용
	            // JSP에서 n.artistDto 형태로 접근할 것이므로 별도 filteredList가 필요 없음
	        }
	    }
	    return "shop/smain";
	}
	
	
	
	// 아티스트물건 전체 리스트 호출
	@GetMapping("/sprods")
	public String sprods(@RequestParam("artistNo") int artist_no, Model model) {
		// get받은 artist_no 일치하는 ShopDto 전달
		List<ShopDto> list = shopService.findByNo(artist_no);
		model.addAttribute("slist", list);
		
		// ShopDto에서 Shop_category만 따로 전달
		Set<String> categories = list.stream()
	    .map(ShopDto::getShop_category)
	    .collect(Collectors.toCollection(LinkedHashSet::new));
	    model.addAttribute("categories", categories);
		
		System.out.println("artist_no : " + artist_no);
		System.out.println("ShopDto : " + list);
		System.out.println("category : " + categories);
		
		return "shop/sprods";
	}
	
	//상품 상세정보
	@GetMapping("/sprodview")
	public String sprodview(@RequestParam("shopNo") int shop_no, Model model) {
		Optional<ShopDto> slist = shopService.findById(shop_no);
		System.out.println("상품 하나가져오기 : " + slist);
		System.out.println("상품 하나가져오기 : " + slist.get());
		model.addAttribute("prod", slist.get());
		model.addAttribute("artist", slist.get().getArtistDto());
		
		return "shop/sprodview";
	}
	
	
	// 상품 장바구니에 추가
	@PostMapping("/addToCart")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> addToCart(
	    @RequestBody Map<String, Object> productInfo, 
	    HttpSession session
	) {
		//디버그
		System.out.println("AddToCart 요청 수신: " + productInfo);
	    String memberNickname = (String) session.getAttribute("session_nickname");
	    System.out.println("Session Nickname: " + memberNickname); // 로그 추가
	    
	    try {
	        // 상품 번호와 수량 가져오기
	        int shopNo = Integer.parseInt(productInfo.get("shopNo").toString());
	        int quantity = Integer.parseInt(productInfo.get("quantity").toString());
	        
	        // 상품 정보 가져오기
	        Optional<ShopDto> shopOpt = shopService.findById(shopNo);
	        if (!shopOpt.isPresent()) {
	            return ResponseEntity.badRequest().body(Map.of(
	                "success", false, 
	                "message", "상품을 찾을 수 없습니다."
	            ));
	        }
	        ShopDto shop = shopOpt.get();
	        
	        // 장바구니에 이미 담긴 수량 확인
	        int cartQuantity = cartService.getCartItemQuantity(memberNickname, shopNo);
	        
	        // 구매 제한 확인
	        if (cartQuantity + quantity > shop.getShop_buylimit()) {
	            return ResponseEntity.badRequest().body(Map.of(
	                "success", false, 
	                "message", "구매 제한 수량은 " + shop.getShop_buylimit() + "개 입니다. 이미 장바구니에 " + 
	                          cartQuantity + "개가 있어 더 추가할 수 없습니다."
	            ));
	        }
	    
	        // JSON 문자열로 변환
	        ObjectMapper objectMapper = new ObjectMapper();
	        String cartItemsJson = objectMapper.writeValueAsString(
	            List.of(productInfo)
	        );

	        CartDto savedCart = cartService.addToCart(memberNickname, cartItemsJson);
	        
	        return ResponseEntity.ok(Map.of("success", true, "cartNo", savedCart.getCart_no()));
	    } catch (Exception e) {
	        return ResponseEntity.badRequest().body(Map.of("success", false, "message", e.getMessage()));
	    }
	}
	
	
	@GetMapping("/sptwind")
	public String sptwind(@RequestParam("sprodId") int shop_no, 
	                      @RequestParam(value="quantity", required=false, defaultValue="1") int quantity,
	                      HttpSession session, Model model) {
	    // 선택한 물건 정보를 넘긴다
	    Optional<ShopDto> sprod = shopService.findById(shop_no);
	    System.out.println("상품하나 : " + sprod);
	    
	    // 상품 정보가 존재하면
	    if(sprod.isPresent()) {
	        ShopDto product = sprod.get();
	        model.addAttribute("sdto", product);
	        
	        // 로그인한 회원 정보를 넘긴다
	        String memberId = (String) session.getAttribute("session_id");
	        System.out.println("세션아이디 : " + session.getAttribute("session_id"));
	        MemberDto minfo = memberService.findByMemberId(memberId);
	        System.out.println("로그인고객정보 : " + minfo);
	        model.addAttribute("mdto", minfo);
	        
	        // 멤버십 여부에 따라 다른 가격 적용
	        int price;
	        if (minfo != null && "0".equals(minfo.getMember_membership())) {
	        	// 멤버십이 없는 (0이라면) 경우 정상 가격 적용
	        	price = product.getShop_price();
	        	System.out.println("일반 가격 적용: " 	+ price);
	        } else {
	            // 멤버십이 있는 경우 할인 가격 적용
	            price = product.getShop_discount_price();
	            System.out.println("멤버십 할인 가격 적용: " + price);
	        }
	        
	        // 적용된 가격과 총액 모델에 추가
	        model.addAttribute("appliedPrice", price);
	        model.addAttribute("totalPrice", price * quantity);
	        model.addAttribute("quantity", quantity);
	    }
	    
	    return "shop/sptwind";
	}
	
	
	//카카오페이페이지 결제
	@ResponseBody
	@PostMapping("/pay/orderPay")
	public ReadyResponseDto orderPay(OrderDto odto, HttpSession session, 
	                                @RequestParam(required=false, defaultValue="1") Integer orderQuantity) {
	    log.info("odto name : " + odto.getName());
	    System.out.println("구매 수량: " + orderQuantity);
	    
	    // 주문번호 생성
	    String orderNumber = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd")) 
	                       + String.format("%010d", new SecureRandom().nextLong() % 10_000_000_000L);
	    
	    // 세션에 주문 정보와 수량 저장
	    session.setAttribute("orderData", odto);
	    session.setAttribute("orderNumber", orderNumber);
	    session.setAttribute("orderQuantity", orderQuantity); // 수량 별도 저장
	    
	    // 카카오 결제 준비하기
	    ReadyResponseDto readyResponseDto = kakaopayService.payReady(odto);
	    
	    // 세션에 결제 고유번호(tid) 저장
	    SessionUtils.addAttribute("tid", readyResponseDto.getTid());
	    log.info("결제 고유번호: " + readyResponseDto.getTid());
	    
	    return readyResponseDto;
	}

	// 페이결제완료 (통신성공시 실행)
	// FController.java의 payCompleted 메소드 수정
	@GetMapping("/pay/completed")
	public String payCompleted(@RequestParam("pg_token") String pgToken, Model model) {
	    // 세션에서 tid값을 가져옴
	    String tid = SessionUtils.getStringAttributeValue("tid");
	    log.info("결제승인 요청을 인증하는 토큰: " + pgToken);
	    log.info("결제 고유번호: " + tid);

	    // 세션에서 주문 데이터 가져오기
	    HttpSession session = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest().getSession();
	    OrderDto sessionOrderData = (OrderDto) session.getAttribute("orderData");
	    String orderNumber = (String) session.getAttribute("orderNumber");
	    String memberId = (String) session.getAttribute("session_id");
	    
	    // 카카오 결제 요청하기
	    ApproveResponseDto approveResponseDto = kakaopayService.payApprove(tid, pgToken);
	    System.out.println("승인날짜 : " + approveResponseDto.getApproved_at());
	    
	    OrderDto savedOrder = null;
	    
	    try {
	        // 주문 정보 저장 (OrderService 사용)
	        if (sessionOrderData != null && orderNumber != null && memberId != null) {
	            int shopNo = Integer.parseInt(sessionOrderData.getOrder_detail_address()); // 임시로 상품번호 저장용
	            // 수량 정보를 직접 세션에서 가져오기
	            int quantity = 1; // 기본값 설정
	            // 이전 페이지에서 넘어온 파라미터에서 정확한 수량 확인
	            try {
	                // 1. 직접 order_total_amount 값을 사용
	                quantity = sessionOrderData.getOrder_total_amount();
	                // 2. 값이 이상하면 로그 확인
	                System.out.println("Order total amount: " + sessionOrderData.getOrder_total_amount());
	                System.out.println("Product price: " + sessionOrderData.getOrder_product_price());
	                // 3. 값이 0이면 세션에서 별도로 저장된 수량 확인
	                if (quantity <= 0 && session.getAttribute("orderQuantity") != null) {
	                    quantity = (Integer) session.getAttribute("orderQuantity");
	                }
	            } catch (Exception e) {
	                System.out.println("수량 계산 중 오류 발생: " + e.getMessage());
	            }
	            // 주문 저장 호출
	            savedOrder = orderService.saveOrder(
	                memberId,              // 회원 ID
	                shopNo,                // 상품 번호
	                quantity,              // 수량
	                orderNumber,           // 주문번호
	                sessionOrderData.getOrder_address(),       // 주소
	                sessionOrderData.getOrder_zipcode(),       // 우편번호
	                sessionOrderData.getTotalPrice(),          // 총 금액
	                sessionOrderData.getOrder_shipping_fee(),  // 배송비
	                sessionOrderData.getOrder_used_reward()    // 사용한 적립금
	            );
	            
	            // 주문 상태 업데이트 (결제 완료)
	            if (savedOrder != null) {
	                orderService.updateOrderStatus(orderNumber, tid, "PAID");
	                
	                // 적립금 계산
	                Optional<ShopDto> shop = shopRepository.findById(shopNo);
	                if (shop.isPresent()) {
	                    // 상품 가격 × 수량 = 총 상품 가격 (배송비 제외)
	                    int productPrice = shop.get().getShop_price() * quantity;
	                    
	                    // 적립금 계산 (상품 가격의 1%)
	                    int rewardPoints = (int)(productPrice * 0.01);
	                    
	                    // OrderDto의 order_save_reward에 적립금 업데이트
	                    orderService.updateOrderSaveReward(orderNumber, rewardPoints);
	                    
	                    // 회원 총 적립금도 함께 업데이트
	                    memberService.addMemberPoints(memberId, rewardPoints);
	                    
	                    // 모델에 적립 정보 추가 (결과 페이지에 표시용)
	                    model.addAttribute("addedPoints", rewardPoints);
	                }
	            }
	            
	            // 주문 완료 페이지에 전달할 정보 설정
	            model.addAttribute("orderNumber", orderNumber);
	            model.addAttribute("orderName", sessionOrderData.getName());
	            model.addAttribute("orderDate", new java.util.Date());
	            model.addAttribute("totalAmount", sessionOrderData.getTotalPrice());
	            model.addAttribute("address", sessionOrderData.getOrder_address());
	            model.addAttribute("zipCode", sessionOrderData.getOrder_zipcode());
	            model.addAttribute("paymentMethod", "카카오페이");
	            model.addAttribute("approved_at", approveResponseDto.getApproved_at());
	            // 상품 정보도 추가
	            Optional<ShopDto> shop = shopRepository.findById(shopNo);
	            if (shop.isPresent()) {
	                model.addAttribute("productName", shop.get().getShop_title());
	                model.addAttribute("quantity", quantity); // 계산된 수량 추가
	                model.addAttribute("unitPrice", shop.get().getShop_price());
	            }
	            // 세션에서 주문 정보 제거
	            session.removeAttribute("orderData");
	            session.removeAttribute("orderNumber");
	            session.removeAttribute("orderQuantity");
	        } else {
	            System.out.println("세션에 주문 정보가 없습니다.");
	            // 세션에 정보가 없는 경우에도 기본 정보 설정
	            model.addAttribute("orderNumber", "주문번호 없음");
	            model.addAttribute("orderName", "상품명 없음");
	            model.addAttribute("totalAmount", 0);
	            model.addAttribute("quantity", 0);
	        }
	    } catch (Exception e) {
	        System.out.println("주문 처리 중 오류 발생: " + e.getMessage());
	        e.printStackTrace();
	        // 오류 발생시에도 기본 정보 설정
	        model.addAttribute("orderNumber", "처리 중 오류 발생");
	        model.addAttribute("errorMessage", "주문 처리 중 오류가 발생했습니다.");
	    }
	    return "shop/sptdone"; // 리다이렉트가 아닌 바로 뷰 이름 반환
	}
	
	//카카오페이성공
	@GetMapping("/success")
	public String success() {
		return "success";
	}
	
	@GetMapping("/sptdone")
	public String sptdone() {
		return "shop/sptdone";
	}
	
	// 문의사항 페이지
	@GetMapping("/squestion")
	public String squestion() {
		return "shop/squestion";
	}
	
	
}