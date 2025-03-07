package com.java.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.java.dto.MemberDto;
import com.java.service.MService;

import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class FController {
	@Autowired MService mService;
	@Autowired HttpSession session;
	
	// 메인화면
	@GetMapping("/")
	public String index(Model model) {
		
	    String sessionId = (String) session.getAttribute("session_id");

	    if (sessionId != null) {
	        MemberDto memberDto = mService.findByMemberId(sessionId);
	        model.addAttribute("mdto", memberDto);
	    }
	    
		return "index";
	}

	// 로그인페이지 호출
	@GetMapping("/login")
	public String login() {
		return "/login";
	}
	
	// 로그인 확인
	@PostMapping("/login")
	public String login(@RequestParam("id") String id,@RequestParam("pw") String pw) {
		MemberDto memberDto = mService.findByIdAndPw(id,pw);
		if(memberDto!=null) {
			session.setAttribute("session_id",id);
			return "redirect:/login?chkLogin=1";
		}else {
			return "redirect:/login?chkLogin=0";
		}
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
		return "/memberTerms";
	}
	
	// 회원가입 페이지
	@GetMapping("/member")
	public String member() {
		return "/member";
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
	
	// 회원가입
	@PostMapping("/memberInput")
	public String memberInput(@ModelAttribute MemberDto mdto) {
		
		mService.save(mdto);
		return "redirect:/login";
	}
	
	// mypage 호출
	@GetMapping("/mypage")
	public String mypage() {
		return "/mypage";
	}
	
	// 환경설정 호출
	@GetMapping("/user_setting")
	public String user_setting() {
		return "/user_setting";
	}
	
	// 공지사항
	@GetMapping("/noticelist")
	public String noticelist() {
		return "/noticelist";
	}
	
	// 장바구니
	@GetMapping("/cart")
	public String cart() {
		return "/cart";
	}
	
	// 확인용
	@GetMapping("/nothing")
	public String nothing() {
		return "/nothing";
	}
	
}
