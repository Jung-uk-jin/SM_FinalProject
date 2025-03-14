package com.java.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.java.dto.ArtistDto;
import com.java.repository.ARepository;

@RestController
@RequestMapping("/search")
public class SearchController {

    @Autowired
    private ARepository artistRepository;

    @GetMapping
    public List<Map<String, String>> searchArtists(@RequestParam String query) {
        List<ArtistDto> artists = artistRepository.searchArtists(query);
        
	     // 검색어가 없거나 null이면 빈 리스트 반환
	        if (query == null || query.trim().isEmpty()) {
	            return Collections.emptyList();
	        }

        return artists.stream()
            .map(artist -> {
                Map<String, String> map = new HashMap<>();
                map.put("name", artist.getArtist_group_name()); // ✅ 아티스트 이름
                map.put("imageUrl", artist.getArtist_group_image()); // ✅ 아티스트 이미지 URL 수정
                return map;
            })
            .collect(Collectors.toList());
    }

}
