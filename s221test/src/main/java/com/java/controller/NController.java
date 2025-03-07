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
import com.java.dto.NoticeDto;
import com.java.service.AService;
import com.java.service.NService;

@Controller
public class NController {

	@Autowired NService nService;
	@Autowired AService aService;
	
	// 공지 관리
	@GetMapping("/notice")
	public String notice(Model model) {
		
		List<NoticeDto> list = nService.findAll();
		model.addAttribute("list",list);
		return "notice";
	}
	
	// 공지 작성
	@GetMapping("/nwrite")
	public String nwrite(Model model) {
		List<ArtistDto> list = aService.findAll(); // ArtistDto 목록 조회
	    model.addAttribute("alist", list);
		return "nwrite";
	}
	
	// 공지 작성등록
	@PostMapping("/nwrite")
	public String nwrite(NoticeDto ndto, 
			@RequestPart("files") MultipartFile files) throws Exception {
		
		System.out.println("notice_file: " + files); // ✅ 파일 값 확인
		
		String realName = ""; 
		ndto.setNotice_file(""); // 파일첨부가 되지 않았을 경우
		if(files != null && !files.isEmpty()) {
			String origin = files.getOriginalFilename();
			long time = System.currentTimeMillis();
			realName = String.format("%d_%s", time, origin);
			
			String url = "c:/upload/test/";
			File f = new File(url+realName);
			files.transferTo(f);
			
			ndto.setNotice_file(realName);
		}
		
		System.out.println("새로운 notice_file: " + ndto.getNotice_file());
		nService.nwrite(ndto);
		
		return "redirect:/notice";
	}
	
	
	// 공지 상세보기
	@GetMapping("/noticeInfo")
	public String noticeInfo(@RequestParam("notice_no") int notice_no,Model model) {
		
		List<ArtistDto> list = aService.findAll(); // ArtistDto 목록 조회
		NoticeDto noticeDto = nService.findByNoticeNo(notice_no);
		model.addAttribute("alist", list);
		model.addAttribute("ndto",noticeDto);
		return "noticeInfo";
	}
	
	// 공지 수정
	@PostMapping("/noticeupdate")
	public String noticeupdate(NoticeDto ndto,
			@RequestPart(value = "files", required = false) MultipartFile files) throws Exception {
		
		NoticeDto noticeDto = nService.findByNoticeNo(ndto.getNotice_no());
		System.out.println("noticeDto: " + noticeDto);
		if (noticeDto == null) {
		    System.out.println("Notice not found with no: " + ndto.getNotice_no());
		}
		
	    int artistNo = ndto.getArtistDto().getArtist_no();
	    ArtistDto adto = aService.findById(artistNo); // DB에서 전체 객체 조회
	    ndto.setArtistDto(adto);
		
		noticeDto.setNotice_title(ndto.getNotice_title());
		noticeDto.setNotice_type(ndto.getNotice_type());
		noticeDto.setNotice_content(ndto.getNotice_content());
		// 파일 수정
		if(files != null && !files.isEmpty()) {
			String origin = files.getOriginalFilename();
			long time = System.currentTimeMillis();
			String realName = String.format("%d_%s", time, origin);
			
			String url = "c:/upload/test/";
			File f = new File(url+realName);
			files.transferTo(f);
			
			ndto.setNotice_file(realName);
		}
		
		nService.save(ndto);
		return "redirect:/notice";
	}
	
	// 회원정보 삭제
	@ResponseBody
	@PostMapping("/noticedelete")
	public String noticedelete(@RequestParam("notice_no") int notice_no) {
		//회원정보삭제
		System.out.println("notice_no: "+notice_no);
		nService.deleteByNoticeNo(notice_no);
		return "1";
	}
	
	
}
