package com.java.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.java.dto.ArtistDto;
import com.java.service.ArtistService;

@Controller
public class FController {
	
	@Autowired ArtistService artistService;
	
	// 메인페이지 아티스트 리스트
	@GetMapping("/")
	public String index(Model model) {
		List<ArtistDto> list = artistService.findAll();
		model.addAttribute("list",list);
//		System.out.println("리스트 : "+list);
		return "index";
	}
	
	@GetMapping("/index2")
	public String index2() {

		return "index2";
	}
	
	
}
