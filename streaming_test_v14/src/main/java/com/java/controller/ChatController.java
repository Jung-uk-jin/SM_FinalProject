package com.java.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.java.dto.ChatMessage;
import com.java.service.ChatFilterService;

@Controller
public class ChatController {

    private static final String FIXED_ROOM_ID = "1234";  // 고정된 방 번호

    @Autowired
    private ChatFilterService chatFilterService;
    
    @Autowired
    private WebSocketUserTracker userTracker;

    // 클라이언트가 접속할 때마다 고정된 방 번호로 채팅을 시작
    @MessageMapping("/joinRoom")
    @SendTo("/topic/roomDetails")
    public String joinRoom() {
        return FIXED_ROOM_ID;  // 고정된 방 번호를 반환
    }

    @MessageMapping("/chat/{roomId}")
    @SendTo("/topic/rooms/{roomId}")
    public ChatMessage send(ChatMessage message) {
        // 메시지 필터링 적용
        String filteredContent = chatFilterService.filterMessage(message.getContent());
        message.setContent(filteredContent);
        return message;
    }
 // 신고된 욕설을 필터링 목록에 추가
    @PostMapping("/reportBadWord")
    public ResponseEntity<?> reportBadWord(@RequestBody Map<String, String> body) {
        String badWord = body.get("word"); // 클라이언트에서 전송한 badWord 추출

        // 디버깅: 받은 badWord 출력
        System.out.println("Received bad word: " + badWord);

        if (badWord != null && !badWord.trim().isEmpty()) {
            chatFilterService.addBadWord(badWord); // 필터링 목록에 추가
            return ResponseEntity.ok(Map.of("message", "단어가 신고되었습니다.")); // JSON 형식으로 응답
        }

        return ResponseEntity.badRequest().body(Map.of("message", "잘못된 요청입니다.")); // JSON 형식으로 잘못된 요청 응답
    }
    
//    @RequestMapping("/chatting")
//    public String chatPage(Model model) {
//    	int userCountValue = userTracker.getUserCount();
//    	 System.out.println("현재 사용자 수: " + userCountValue);  // 사용자 수 출력
//
//        model.addAttribute("userCount", userTracker.getUserCount()); // 현재 접속한 사용자 수를 모델에 추가
//        return "chatting"; // JSP 페이지 이름
//    }
}
