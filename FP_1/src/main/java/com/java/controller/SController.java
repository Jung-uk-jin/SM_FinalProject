package com.java.controller;

import java.io.File;
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
import com.java.dto.NoticeDto;
import com.java.dto.ShopDto;
import com.java.service.AService;
import com.java.service.ArtistMemberService;
import com.java.service.SService;

@Controller
public class SController {

	@Autowired SService sService;
	@Autowired AService aService;
	
	// 관리자페이지 상품 관리
	@GetMapping("/shop")
	public String shop(Model model) {
		
		
		List<ShopDto> list = sService.findAll();
		model.addAttribute("list",list);
		return "/admin/shop";
	}
	
	// 관리자페이지 상품 등록
	@GetMapping("/shopwrite")
	public String shopwrite(Model model) {
		
		List<ArtistDto> list = aService.findAll();
		model.addAttribute("list",list);
		return "/admin/shopwrite";
	}
	
	// 관리자페이지 상품 등록
	@PostMapping("/shopwrite")
	public String shopwrite(ShopDto sdto, 
			@RequestPart("files") MultipartFile files,
			@RequestPart("files2") MultipartFile files2,
			@RequestPart("files3") MultipartFile files3,
			@RequestPart("files4") MultipartFile files4,
			@RequestPart("files5") MultipartFile files5) throws Exception {
		
		System.out.println("notice_file: " + files); // ✅ 파일 값 확인
		
		String realName = ""; 
		sdto.setShop_content(""); // 파일첨부가 되지 않았을 경우
		if(files != null && !files.isEmpty()) {
			String origin = files.getOriginalFilename();
			long time = System.currentTimeMillis();
			realName = String.format("%d_%s", time, origin);
			
			String url = "c:/upload/test/";
			File f = new File(url+realName);
			files.transferTo(f);
			
			sdto.setShop_content(realName);
		}
		
		// 로고 이미지
	    String realName2 = "";
	    sdto.setShop_spinfo("");
	    if(files2 != null && !files2.isEmpty()) {
	        String origin2 = files2.getOriginalFilename();
	        long time2 = System.currentTimeMillis();
	        realName2 = String.format("%d_%s", time2, origin2);
	        
	        String url = "c:/upload/test/";
	        File f2 = new File(url + realName2);
	        files2.transferTo(f2);
	        
	        // DTO의 두 번째 파일 관련 필드에 저장
	        sdto.setShop_spinfo(realName2);
	    }
	    
		// 커버 이미지
	    String realName3 = "";
	    sdto.setShop_image1("");
	    if(files3 != null && !files3.isEmpty()) {
	        String origin3 = files3.getOriginalFilename();
	        long time3 = System.currentTimeMillis();
	        realName3 = String.format("%d_%s", time3, origin3);
	        
	        String url = "c:/upload/test/";
	        File f3 = new File(url + realName3);
	        files3.transferTo(f3);
	        
	        // DTO의 두 번째 파일 관련 필드에 저장
	        sdto.setShop_image1(realName3);
	    }
	    
	    // 커버 이미지
	    String realName4 = "";
	    sdto.setShop_image2("");
	    if(files4 != null && !files4.isEmpty()) {
	    	String origin4 = files4.getOriginalFilename();
	    	long time4 = System.currentTimeMillis();
	    	realName4 = String.format("%d_%s", time4, origin4);
	    	
	    	String url = "c:/upload/test/";
	    	File f4 = new File(url + realName3);
	    	files4.transferTo(f4);
	    	
	    	// DTO의 두 번째 파일 관련 필드에 저장
	    	sdto.setShop_image2(realName3);
	    }
	    
	    // 커버 이미지
	    String realName5 = "";
	    sdto.setShop_image3("");
	    if(files5 != null && !files5.isEmpty()) {
	    	String origin5 = files5.getOriginalFilename();
	    	long time5 = System.currentTimeMillis();
	    	realName5 = String.format("%d_%s", time5, origin5);
	    	
	    	String url = "c:/upload/test/";
	    	File f5 = new File(url + realName5);
	    	files5.transferTo(f5);
	    	
	    	// DTO의 두 번째 파일 관련 필드에 저장
	    	sdto.setShop_image3(realName5);
	    }
		
	    sService.shopwrite(sdto);
		
		return "redirect:/shop";
	}
	
	// 상품 상세보기
	@GetMapping("/shopInfo")
	public String shopInfo(@RequestParam("shop_no") int shop_no,Model model) {
		
		List<ArtistDto> list = aService.findAll(); // ArtistDto 목록 조회
		ShopDto shopDto = sService.findByshopNo(shop_no);
		model.addAttribute("alist", list);
		model.addAttribute("sdto",shopDto);
		return "/admin/shopInfo";
	}
	
	// 상품정보 삭제
	@ResponseBody
	@PostMapping("/shopdelete")
	public String shopdelete(@RequestParam("shop_no") int shop_no) {
		//공지정보삭제
		System.out.println("shop_no: "+shop_no);
		sService.deleteByShopNo(shop_no);
		return "1";
	}
}
