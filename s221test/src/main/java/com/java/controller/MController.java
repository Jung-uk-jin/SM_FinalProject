package com.java.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.java.dto.ArtistMemberDto;
import com.java.dto.MemberDto;
import com.java.service.ArtistMemberService;
import com.java.service.MService;

import jakarta.servlet.http.HttpSession;

@Controller
public class MController {
	
	@Autowired MService mService;
	@Autowired ArtistMemberService amService;
	@Autowired HttpSession session;
	
	// 로그인페이지 호출
	@GetMapping("/login")
	public String login() {
		return "/member/login";
	}
	
	// 로그인 확인
	@PostMapping("/login")
	public String login(@RequestParam("id") String id,@RequestParam("pw") String pw) {

	    MemberDto memberDto = mService.findByIdAndPw(id, pw);
	    if (memberDto != null) {
	        session.setAttribute("session_id", id);
	        session.setAttribute("memberType", "Fan"); // 필요에 따라 회원 유형 저장
	        return "redirect:/login?chkLogin=1";
	    }
	    
	    // 아티스트 회원(ArtistMemberDto) 조회
	    ArtistMemberDto artistMemberDto = amService.findByIdAndPw(id, pw);
	    if (artistMemberDto != null) {
	        session.setAttribute("session_id", id);
	        session.setAttribute("memberType", "artist"); // 아티스트 회원임을 표시
	        return "redirect:/login?chkLogin=1";
	    }

	    
		return "redirect:/login?chkLogin=2";
		
	}
	
	// 로그아웃
	@GetMapping("/logout")
	public String logout() {
		session.invalidate();
		return "redirect:/?chkLogin=0";
	}
	
	// 약관동의
	@GetMapping("/memberTerms")
	public String memberTerms() {
		return "/member/memberTerms";
	}
	
	// 회원가입 페이지
	@GetMapping("/member")
	public String member() {
		return "/member/member";
	}
	
	// 아이디 중복확인
	@PostMapping("/checkMemberId")
	@ResponseBody
	public Map<String, Object> checkMemberId(@RequestParam("memberId") String memberId) {
	    boolean exists = mService.existsMemberId(memberId); // DB에 존재하는지 확인
	    Map<String, Object> response = new HashMap<>();
	    response.put("exists", exists);
	    return response;
	}
	
	// 닉네임 중복확인
	@PostMapping("/checkMemberNickname")
	@ResponseBody
	public Map<String, Object> checkMemberNickname(@RequestParam("memberNickname") String memberNickname) { 
	    boolean exists = mService.existsMemberNickname(memberNickname); // DB에 존재하는지 확인 
	    Map<String, Object> response = new HashMap<>();
	    response.put("exists", exists);
	    return response;
	}
	
	// 회원가입
	@PostMapping("/memberInput")
	public String memberInput(@ModelAttribute MemberDto mdto) {
		
		mService.save(mdto);
		return "redirect:/login?chkInput=1";
	}
	
	// mypage 호출
	@GetMapping("/mypage")
	public String mypage() {
		return "/member/mypage";
	}
	
	// 장바구니
	@GetMapping("/cart")
	public String cart() {
		return "/member/cart";
	}
}
