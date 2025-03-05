package com.java.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.java.dto.EventDto;
import com.java.service.EService;

@Controller
public class EController {

	@Autowired EService eService;
	
	@GetMapping("/event")
	public String event(Model model) {
		
		List<EventDto> list = eService.findAll();
		model.addAttribute("list",list);
		return "event";
	} 
}
