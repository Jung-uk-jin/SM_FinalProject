package com.java.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.java.dto.ShopDto;
import com.java.service.SService;

@Controller
public class SController {

	@Autowired SService sService;
	
	// 상품 관리
	@GetMapping("/shop")
	public String shop(Model model) {
		
		List<ShopDto> list = sService.findAll();
		model.addAttribute("list",list);
		return "/admin/shop";
	}
}
