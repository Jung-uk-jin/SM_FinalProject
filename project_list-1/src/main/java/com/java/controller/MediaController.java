package com.java.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.java.dto.ArtistDto;
import com.java.dto.MediaDto;
import com.java.service.ArtistService;
import com.java.service.MediaService;

@Controller
public class MediaController {
	
	@Autowired MediaService mediaService;
	@Autowired ArtistService artistService;
	
	@GetMapping("/media")
	public String media(@RequestParam("artist_no") int artistNo,Model model) {
		List<MediaDto> mediaList = mediaService.findByArtistNo(artistNo);
		ArtistDto artistDto = artistService.findByArtistNo(artistNo);
		
		model.addAttribute("mediaList", mediaList);
		model.addAttribute("adto", artistDto);
		System.out.println(mediaList);
		return "media";
	}
	
}
