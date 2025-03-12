package com.java.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.java.dto.ArtistCommunityDto;
import com.java.dto.ArtistDto;
import com.java.dto.FanCommunityDto;
import com.java.dto.NicknameDto;
import com.java.service.ArtistCommuService;
import com.java.service.ArtistService;
import com.java.service.CommentService;
import com.java.service.FanCommuService;
import com.java.service.MediaService;
import com.java.service.MemberService;
import com.java.service.NicknameService;

import jakarta.servlet.http.HttpSession;

@Controller
public class ArtistCommuController {
	@Autowired ArtistService artistService;
	@Autowired CommentService commentService;
	@Autowired ArtistCommuService artistCommuService;
	@Autowired MemberService memberService;
	@Autowired NicknameService nicknameService;
	@Autowired HttpSession session;
	@Autowired MediaService mediaService;
	
	// 게시글 출력
	@GetMapping("/artistcommunity")
	public String artistCommunity(@RequestParam("artist_no") int artist_no, Model model) {
		List<ArtistCommunityDto> list = artistCommuService.findAll();
		ArtistDto artistDto = artistService.findByArtistNo(artist_no);
		model.addAttribute("list",list);
		model.addAttribute("adto", artistDto);
		return "artistcommunity";
	}
	
	//글쓰기 저장
	@PostMapping("/acwrite")
	public String acwrite(@RequestParam("artist_no") int artistNo,
			@RequestParam(value="imageFile", required=false) MultipartFile files, ArtistCommunityDto acdto) throws Exception {
		
		System.out.println("artistNo  : "+artistNo);
		
	    ArtistDto artistDto = new ArtistDto();
	    artistDto.setArtist_no(artistNo);
	    
	    // ArtistDto에 artistDto 설정
	    acdto.setArtistDto(artistDto);
	    
	    // 세션에서 nickname 바로 가져오기
	    String nickname = (String) session.getAttribute("nickname");
	    NicknameDto ndto = new NicknameDto();
	    ndto.setNickname_name(nickname);
	    acdto.setNicknameDto(ndto);
	    
	    //  이미지 출력
	    acdto.setA_community_image("");
	    if(!files.isEmpty()) {
	    	String origin = files.getOriginalFilename();
	    	long time = System.currentTimeMillis();
	    	String realFileName = String.format("%d_%s", time, origin) ;
	    	String url= "c:/upload/artist/";
	    	File f = new File(url+realFileName);
	    	files.transferTo(f);
	    	acdto.setA_community_image(realFileName);
	    }
		artistCommuService.acwrite(acdto);
		return "redirect:/artistcommunity?artist_no="+artistNo;
	}
	
	//게시글 삭제하기
	@ResponseBody
	@PostMapping("/artistcommunity/delete")
	public String deletePost(@RequestParam("communityNo") int communityNo) {
	    // 게시글 삭제 처리 (삭제 후 결과에 따라 "success" 반환)
	    artistCommuService.deleteByCommunity(communityNo);
	    return "1";
	}
	
}




