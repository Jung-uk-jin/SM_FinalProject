package com.java.controller;

import org.springframework.web.bind.annotation.*;

import com.java.service.SpotifyService;

import java.util.List;

@RestController
@RequestMapping("/spotify")
public class SpotifyController {

    private final SpotifyService spotifyService;

    public SpotifyController(SpotifyService spotifyService) {
        this.spotifyService = spotifyService;
    }

    // ✅ 아티스트 이름으로 관련 아티스트 추천
    @GetMapping("/search")
    public List<String> searchRelatedArtists(@RequestParam String artistName) {
        String accessToken = spotifyService.getAccessToken();
        String artistId = spotifyService.getArtistId(artistName, accessToken);
        return spotifyService.getRelatedArtists(artistId, accessToken);
    }
    @GetMapping("/token")
    public String getAccessToken() {
        return spotifyService.getAccessToken();
    }

}