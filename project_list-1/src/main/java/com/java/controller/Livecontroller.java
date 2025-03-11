package com.java.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.java.dto.ArtistDto;
import com.java.service.ArtistService;

@Controller
public class Livecontroller {

	@Autowired ArtistService artistService;
	
	
	@GetMapping("/live")
	public String live(@RequestParam("artist_no") int artistNo, Model model) {
		ArtistDto artistDto = artistService.findByArtistNo(artistNo);
		
		model.addAttribute("adto",artistDto);
		return "live";
	}
	
    @GetMapping("/mobile")
    public String mobile() {
        return "mobile";
    }
	
    @GetMapping("/OTP")
    public String OTP() {
    	return "OTP"; // /WEB-INF/views/desktopOTP.jsp
    }
	
}
