package com.java.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.java.dto.MemberDto;
import com.java.service.MemberService;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.util.ArrayList;
import java.util.List;

@Controller
public class FController {

    @Autowired
    MemberService memberService;
    @Autowired
    HttpSession session;
    @Autowired
    WebSocketUserTracker userTracker;

    // 로그아웃 처리
    @GetMapping("/logout")
    public String logout() {
        session.invalidate(); // 세션 무효화
        return "redirect:/";
    }

    // 채팅 페이지 로딩
    @GetMapping("/chatting")
    public String chatting(Model model) {
        // 사용자 수 가져오기
        int userCountValue = userTracker.getUserCount();
        System.out.println("chatPage 호출됨");  // 메서드 호출 여부 확인
        model.addAttribute("userCount", userCountValue); // 사용자 수 전달
        System.out.println("현재 사용자 수: " + userCountValue);  // 사용자 수 출력
        
        // 채팅 기록 가져오기
        List<String> chatHistory = getChatHistory();
        model.addAttribute("chatHistory", chatHistory); // 기존 채팅 메시지 전달
        
        return "chatting"; // chat.jsp 파일을 반환
    }

    // 채팅 기록을 세션에서 가져오거나 빈 리스트 반환
    private List<String> getChatHistory() {
        List<String> chatHistory = (List<String>) session.getAttribute("chatHistory");
        if (chatHistory == null) {
            chatHistory = new ArrayList<>();
        }
        return chatHistory;
    }

    // 아이돌 상세 페이지
    @GetMapping("/idol_detail")
    public String idol_detail() {
        return "idol_detail"; // idol_detail.jsp 반환
    }

    // 로그인 페이지 접속
    @GetMapping("/login")
    public String login(HttpServletResponse response, HttpServletRequest request) {
        // 쿠키 생성
        Cookie cookie = new Cookie("cook_id", "aaa");
        cookie.setMaxAge(60 * 10);
        response.addCookie(cookie);
        return "/login";
    }

    // 로그인 처리
    @PostMapping("/login")
    public String login(String id, String pw, Model model) {
        MemberDto memberDto = memberService.findByIdAndPw(id, pw);
        if (memberDto != null) {
            session.setAttribute("session_id", memberDto.getMember_id());
            return "redirect:/?loginChk=1"; // 로그인 성공 시 리다이렉트
        } else {
            model.addAttribute("loginChk", 0); // 로그인 실패 시 처리
            return "/login";
        }
    }

    // 홈페이지 접속
    @GetMapping("/")
    public String index() {
        return "index"; // index.jsp 파일을 반환
    }

    // 채팅 메시지 보내기 (WebSocket을 통해 메시지 전송)
    @PostMapping("/sendChatMessage")
    public String sendChatMessage(String message) {
        List<String> chatHistory = getChatHistory();
        chatHistory.add(message); // 채팅 메시지를 세션에 추가
        session.setAttribute("chatHistory", chatHistory); // 세션에 채팅 기록 저장
        return "redirect:/chatting"; // 채팅 페이지로 리다이렉트
    }
}
