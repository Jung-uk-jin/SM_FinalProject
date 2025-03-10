package com.java.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.java.dto.ArtistDto;
import com.java.dto.ArtistMemberDto;
import com.java.dto.MemberDto;
import com.java.dto.NicknameDto;
import com.java.service.ArtistMemberService;
import com.java.service.ArtistService;
import com.java.service.MemberService;
import com.java.service.NicknameService;

import jakarta.servlet.http.HttpSession;

@Controller
public class ArtistController {

	@Autowired ArtistService artistService;
	@Autowired MemberService memberService;
	@Autowired ArtistMemberService artistMemberService;
	@Autowired NicknameService nicknameService;
	@Autowired HttpSession session;
	
	@GetMapping("/artist")
	public String Artist(@RequestParam("artist_no") int artist_no, Model model){
		ArtistDto artistDto = artistService.findByArtistNo(artist_no);
		MemberDto memberDto = memberService.findByNickName(null);
		List<ArtistMemberDto> list = artistMemberService.findByArtistNo(artist_no);
		System.out.println("멤버 list : "+ list.size());
		System.out.println("멤버 getArtist_no : "+ list);
		
		model.addAttribute("list",list);
		model.addAttribute("adto",artistDto);
		return "Artist";
		}
	
	@PostMapping("/nickname")
	public String nickname(NicknameDto ndto) {
		nicknameService.save(ndto);
		
		session.setAttribute("nickname", ndto.getNickname_name());
		int artistNo = ndto.getArtistDto().getArtist_no();
		System.out.println("뭔데"+artistNo);
		return "redirect:/fancommunity?artist_no="+artistNo;
	}
	
//	@GetMapping("/ArtistWrite")
//	public String ArtistWrite(ArtistDto adto, @RequestPart MultipartFile files) throws Exception{
//		adto.setArtist_member_image(""); //null이면 에러가 나기때문에 빈공백처리
//		if(!files.isEmpty()) {
//			String origin = files.getOriginalFilename(); //1.jpg
//			long time = System.currentTimeMillis(); //120120120120011_1.jpg
//			String realFileName = String.format("%d_%S", time, origin) ;
//			String url= "c:/upload/artist/";
//			File f = new File(url+realFileName);
//			files.transferTo(f); //폴더에 파일을 서버업로드
//			adto.setArtist_member_image(realFileName); //파일첨부가 되면 다시 이름을 저장
//		}
//	
//	    //artistService.bwrite(adto);
//		// <img src='/images/artist/1.jpg' />
//		// <img src='/upload/artist/1.jpg' />
//		
//		return "ArtistWrite";
//	}
}
