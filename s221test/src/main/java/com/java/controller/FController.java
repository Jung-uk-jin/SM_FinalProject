package com.java.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.java.dto.ArtistDto;
import com.java.dto.MemberDto;
import com.java.service.AService;
import com.java.service.MService;

import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class FController {
	@Autowired MService mService;
	@Autowired HttpSession session;
	@Autowired AService aService;
	
	// 메인화면
	@GetMapping("/")
	public String index(Model model) {
		
	    String sessionId = (String) session.getAttribute("session_id");

	    List<ArtistDto> list = aService.findAll();
		model.addAttribute("list",list);
	    
	    if (sessionId != null) {
	        MemberDto memberDto = mService.findByMemberId(sessionId);
	        model.addAttribute("mdto", memberDto);
	    }
	    
		return "index";
	}
	
	// 환경설정 호출
	@GetMapping("/user_setting")
	public String user_setting() {
		return "/user_setting";
	}
	
	// 확인용
	@GetMapping("/nothing")
	public String nothing() {
		return "/nothing";
	}
	
}
