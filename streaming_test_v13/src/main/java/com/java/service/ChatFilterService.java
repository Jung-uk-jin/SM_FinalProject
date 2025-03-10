package com.java.service;

import org.springframework.stereotype.Service;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ChatFilterService {

    private List<String> badWords;

    public ChatFilterService() {
        loadBadWords();
    }

    private void loadBadWords() {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(
                getClass().getClassLoader().getResourceAsStream("bad_words.txt"), StandardCharsets.UTF_8))) {
            if (reader == null) {
                throw new RuntimeException("금지어 파일을 찾을 수 없습니다.");
            }
            badWords = reader.lines().collect(Collectors.toList());
        } catch (Exception e) {
            throw new RuntimeException("금지어 파일을 불러오는 데 실패했습니다.", e);
        }
    }

    public String filterMessage(String message) {
        for (String badWord : badWords) {
            if (message.contains(badWord)) {
                return "금지어가 포함된 문장입니다."; // 금지어 포함 시 전체 문장 차단
            }
        }
        return message;
    }
}
