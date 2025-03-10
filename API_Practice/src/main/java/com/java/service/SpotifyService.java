package com.java.service;

import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.core.ParameterizedTypeReference;

import java.util.*;

@Service
public class SpotifyService {

    private static final String CLIENT_ID = "bfbf406264c04260a8e8e4eb7edf866b";
    private static final String CLIENT_SECRET = "9b7f1fcb2ec144f6a0e79bec238a36a9";

    // ✅ 1. Access Token 발급
    public String getAccessToken() {
        String url = "https://accounts.spotify.com/api/token";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        headers.setBasicAuth(CLIENT_ID, CLIENT_SECRET); 

        MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
        body.add("grant_type", "client_credentials");

        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(body, headers);
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Map<String, Object>> response = restTemplate.exchange(
            url, HttpMethod.POST, request, new ParameterizedTypeReference<Map<String, Object>>() {}
        );

        return response.getBody().get("access_token").toString();
    }

    // ✅ 2. 아티스트 ID 가져오기
    public String getArtistId(String artistName, String accessToken) {
        String url = "https://api.spotify.com/v1/search?q=" + artistName + "&type=artist&limit=1";

        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + accessToken);
        HttpEntity<String> request = new HttpEntity<>(headers);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Map<String, Object>> response = restTemplate.exchange(
            url, HttpMethod.GET, request, new ParameterizedTypeReference<Map<String, Object>>() {}
        );

        Map<String, Object> body = response.getBody();
        Map<String, Object> artists = (Map<String, Object>) body.get("artists");
        List<Map<String, Object>> items = (List<Map<String, Object>>) artists.get("items");

        if (items.isEmpty()) {
            throw new RuntimeException("아티스트를 찾을 수 없습니다: " + artistName);
        }

        return (String) items.get(0).get("id");
    }

    // ✅ 3. 관련 아티스트 추천
    public List<String> getRelatedArtists(String artistId, String accessToken) {
        String url = "https://api.spotify.com/v1/artists/" + artistId + "/related-artists";

        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + accessToken);
        HttpEntity<String> request = new HttpEntity<>(headers);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Map<String, Object>> response = restTemplate.exchange(
            url, HttpMethod.GET, request, new ParameterizedTypeReference<Map<String, Object>>() {}
        );

        Map<String, Object> body = response.getBody();
        List<Map<String, Object>> artists = (List<Map<String, Object>>) body.get("artists");

        List<String> relatedArtistNames = new ArrayList<>();
        for (Map<String, Object> artist : artists) {
            relatedArtistNames.add((String) artist.get("name"));
        }

        return relatedArtistNames;
    }
}
