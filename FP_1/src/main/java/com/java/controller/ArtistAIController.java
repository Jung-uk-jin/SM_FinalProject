package com.java.controller;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.java.dto.ArtistDto;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;

import java.util.List;
import java.util.Map;

@Controller
public class ArtistAIController {

    @Autowired
    private RestTemplate restTemplate;

    @PostMapping("/")
    public String recommendArtists(@RequestParam String artistName, Model model) {
        String url = "http://localhost:5001/recommend";  // Flask API URL (포트 5001)

        // Prepare the request body with the artist name
        String jsonBody = "{\"artist_name\":\"" + artistName + "\"}";

        // Set the headers to indicate the request body format is JSON
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(org.springframework.http.MediaType.APPLICATION_JSON);

        // Create HttpEntity with the request body and headers
        HttpEntity<String> entity = new HttpEntity<>(jsonBody, headers);

        // Send POST request with RestTemplate to Flask API
        ResponseEntity<String> response = restTemplate.postForEntity(url, entity, String.class);

        // Parse the response to get the recommendations
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            objectMapper.enable(JsonParser.Feature.ALLOW_NON_NUMERIC_NUMBERS);

            // Parse the response into a Map and extract "recommendations"
            Map<String, Object> responseMap = objectMapper.readValue(response.getBody(), new TypeReference<Map<String, Object>>() {});
            List<ArtistDto> recommendations = (List<ArtistDto>) responseMap.get("recommendations");

            // Add the recommendations to the model
            model.addAttribute("recommendations", recommendations);

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Flask API 응답 처리 중 오류가 발생했습니다.");
        }

        // Return to the same index.jsp page to display results
        return "index";  // results will be shown on the index.jsp page
    }
}

// Flask API에 전송할 데이터 객체
class ArtistRequest {
    private String artistName;

    public ArtistRequest(String artistName) {
        this.artistName = artistName;
    }

    public String getArtistName() {
        return artistName;
    }

    public void setArtistName(String artistName) {
        this.artistName = artistName;
    }
}
