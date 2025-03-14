package com.java.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;


import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class FController {
	
	//daddadfa1111111
//		@Autowired MemberService memberService;
		@Autowired HttpSession session;
	
		@GetMapping("/logout")
		public String logout() {
			session.invalidate();
			return "redirect:/";
		}
		
	   @GetMapping("/chatting")
	    public String chatting() {
	        return "chatting"; // chat.jsp 파일을 반환
	    }
	   @GetMapping("/idol_detail")
	   public String idol_detail() {
		   return "idol_detail"; // chat.jsp 파일을 반환
	   }
	   @GetMapping("/login")
		public String login(HttpServletResponse response,
				HttpServletRequest request) {
			//쿠키생성
			Cookie cookie = new Cookie("cook_id", "aaa");
			cookie.setMaxAge(60*10);
			response.addCookie(cookie);
			return "/login";
		}
		
//		@PostMapping("/login")
//		public String login(String id, String pw, Model model) {
//			MemberDto memberDto = memberService.findByIdAndPw(id,pw);
//			if(memberDto!=null) {
//				session.setAttribute("session_id", memberDto.getMember_id());
//				return "redirect:/?loginChk=1";
//			}else {
//				model.addAttribute("loginChk",0);
//				return "/login";
//			}
//		}
//	   
	   @GetMapping("/")
	   public String index() {
		   return "index"; // chat.jsp 파일을 반환
	   }
}
