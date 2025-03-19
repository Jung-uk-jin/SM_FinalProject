package com.java.controller;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

import javax.net.ssl.HttpsURLConnection;

import org.apache.catalina.manager.util.SessionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.jaxb.SpringDataJaxb.OrderDto;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.java.dto.ArtistDto;
import com.java.dto.MemberDto2;
import com.java.dto.ShopDto;
import com.java.service.ArtistService;
import com.java.service.MemberService;
import com.java.service.ShopService;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class FController {

	@Autowired HttpSession session;
	@Autowired ShopService shopService;
	@Autowired ArtistService artistService;
	@Autowired MemberService memberService;
	
	//메인 화면 호출
	@GetMapping("/smain")
	public String smain(Model model) {
		List<ArtistDto> list = artistService.findAll();
		model.addAttribute("list", list);
		return "smain";
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
		return "sprods";
	}
	
	@GetMapping("/sprodview")
	public String sprodview(@RequestParam("shopNo") int shop_no, Model model) {
		Optional<ShopDto> slist = shopService.findById(shop_no);
		System.out.println("상품 하나가져오기 : " + slist);
		System.out.println("상품 하나가져오기 : " + slist.get());
		model.addAttribute("prod", slist.get());
		model.addAttribute("artist", slist.get().getArtistDto());
		
		return "sprodview";
	}
	
	// 배송설정화면
	@GetMapping("/sptwind")
	public String sptwind(@RequestParam("sprodId") int shop_no,HttpSession session, Model model) {
		// 선택한 물건 정보를 넘긴다
		Optional<ShopDto> sprod = shopService.findById(shop_no);
		System.out.println("상품하나 : " + sprod);
		model.addAttribute("sprod", sprod);
		
		//로그인한 회원 정보를 넘긴다
		String memberId = (String) session.getAttribute("session_id");
		System.out.println("세션아이디 : " + session.getAttribute("session_id"));
		Optional<MemberDto2> minfo = memberService.findByMemberId(memberId);
		System.out.println("로그인고객정보 : " + minfo);
		model.addAttribute("minfo", minfo);
		
		
		return "sptwind";
	}
	
	
	
	@GetMapping("/sptdone")
	public String sptdone() {
		return "sptdone";
	}
	
	// 문의사항 페이지
	@GetMapping("/squestion")
	public String squestion() {
		return "squestion";
	}
	
	//test서버 open
	@CrossOrigin 
	@GetMapping("/test")
	public String test(Model model) {
		List<ShopDto> list = shopService.findAll();
		model.addAttribute("list", list);
		return "test";
	}
	
	
	// 로그인 페이지
	@GetMapping("/login")
	public String login() {
		return "login";
	}
	
	//로그아웃
	@GetMapping("/member/logout")
	public String logout() {
		session.invalidate();
		return "redirect:/?loginChk=0";
	}
	
	 // 로그인 버튼클릭
	@PostMapping("/login")
	public String login(String id,String pw) {
		MemberDto2 memberDto2 = memberService.findByMember_idAndMember_pw(id,pw);
		if(memberDto2 != null) {
			System.out.println("로그인이 되었습니다.");
			session.setAttribute("session_id", id);
			System.out.println("세션아이디 : " + session.getAttribute("session_id"));
			return "redirect:/";
		}else {
			System.out.println("로그인이 되지 않았습니다.");
		}
		return "redirect:/login?loginChk=0";
	}
	
	
	
}