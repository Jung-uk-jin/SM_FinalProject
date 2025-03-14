package com.java.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.java.dto.ArtistDto;
import com.java.dto.MemberDto;
import com.java.dto.NicknameDto;
import com.java.service.AService;
import com.java.service.MService;
import com.java.service.NicknameService;

import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class FController {
	@Autowired MService mService;
	@Autowired HttpSession session;
	@Autowired AService aService;
	@Autowired NicknameService nickService;
	
	// 메인화면
	@GetMapping("/")
	public String index(Model model, HttpSession session) {

	    // 세션에서 ID와 닉네임 가져오기
	    String sessionId = (String) session.getAttribute("session_id");
	    String sessionNick = (String) session.getAttribute("session_nickname");

	    // 아티스트 리스트 가져오기
	    List<ArtistDto> list = aService.findAll();
	    model.addAttribute("list", list);

	    // 나의 커뮤니티 리스트 가져오기 (로그인한 경우만)
	    if (sessionNick != null) {
	        List<NicknameDto> nlist = nickService.findByMemberDto_MemberNickname(sessionNick);
	        model.addAttribute("nlist", nlist);
	        
	        if (!nlist.isEmpty()) {
	            session.setAttribute("nicknameDto", nlist.get(0)); // 첫 번째 닉네임을 세션에 저장
	        }
	    }

	    // 로그인한 경우 MemberDto 정보 가져오기
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
	
}
