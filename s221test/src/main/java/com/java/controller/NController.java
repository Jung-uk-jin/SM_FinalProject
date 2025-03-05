package com.java.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.java.dto.NoticeDto;
import com.java.service.NService;

@Controller
public class NController {

	@Autowired NService nService;
	
	@GetMapping("/notice")
	public String notice(Model model) {
		
		List<NoticeDto> list = nService.findAll();
		model.addAttribute("list",list);
		return "notice";
	}
}
