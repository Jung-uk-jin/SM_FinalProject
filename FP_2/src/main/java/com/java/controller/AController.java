package com.java.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.java.dto.ArtistDto;
import com.java.dto.ArtistMemberDto;
import com.java.dto.CommentDto;
import com.java.dto.FanCommunityDto;
import com.java.dto.MemberDto;
import com.java.dto.NoticeDto;
import com.java.service.AService;
import com.java.service.ArtistMemberService;
import com.java.service.CMService;
import com.java.service.CService;
import com.java.service.MService;

@Controller
public class AController {
	
	@Autowired MService mService;
	@Autowired CService cService;
	@Autowired CMService cmService;
	@Autowired AService aService;
	@Autowired ArtistMemberService artistMemberService;
	
	// 회원 관리
	@GetMapping("/admin")
	public String admin(Model model) {
		
		List<MemberDto> list = mService.findAll();
		model.addAttribute("list",list);
		return "/admin/admin";
	}
	
	// 회원정보
	@GetMapping("/memInfo")
	public String memInfo(@RequestParam("nickname") String nickname,Model model) {
		
		MemberDto memberDto = mService.findByNickname(nickname);
		model.addAttribute("mdto",memberDto);
		return "/admin/memInfo";
	}
	
	// 회원정보 수정
	@PostMapping("/memupdate")
	public String memupdate(MemberDto mdto) {
		MemberDto memberDto = mService.findByNickname(mdto.getMember_nickname());
		System.out.println("MemberDto: " + memberDto);
		if (memberDto == null) {
		    System.out.println("Member not found with nickname: " + mdto.getMember_nickname());
		}
		
		// 변경되지 않는 값
	    mdto.setMember_id(memberDto.getMember_id());
	    mdto.setMember_birth(memberDto.getMember_birth());
	    mdto.setMember_phone(memberDto.getMember_phone());
	    mdto.setMember_date(memberDto.getMember_date());
		
		memberDto.setMember_pw(mdto.getMember_pw());
		memberDto.setMember_name(mdto.getMember_name());
		memberDto.setMember_email(mdto.getMember_email());
		memberDto.setMember_address(mdto.getMember_address());
		memberDto.setMember_country(mdto.getMember_country());
		memberDto.setMember_membership(mdto.getMember_membership());
		memberDto.setMember_usertype(mdto.getMember_usertype());
		mService.save(mdto);
		return "redirect:/admin";
	}
	
	// 회원정보 삭제
	@ResponseBody
	@PostMapping("/memdelete")
	public String memDelete(@RequestParam("member_nickname") String member_nickname) {
		//회원정보삭제
		System.out.println("nickname: "+member_nickname);
		mService.deleteByMemberNickname(member_nickname);
		return "1";
	}
	
	// 커뮤니티 글정보
	@GetMapping("/communityInfo")
	public String communityInfo(@RequestParam("nickname") String nickname,Model model) {
		
		List<FanCommunityDto> list = cService.findByNickname(nickname);
		model.addAttribute("list",list);
		return "/admin/communityInfo";
	}
	
	// 게시판글 삭제
	@ResponseBody
	@PostMapping("/commudelete")
	public String commudelete(@RequestParam("community_no") int community_no) {
		//회원정보삭제
		System.out.println("community_no: "+community_no);
		cService.deleteByCommunityNo(community_no);
		return "1";
	}
	
	// 댓글정보
	@GetMapping("/commentInfo")
	public String commentInfo(@RequestParam("nickname") String nickname,Model model) {
		
		List<CommentDto> list = cmService.findByNickname(nickname);
		model.addAttribute("list",list);
		return "/admin/commentInfo";
	}
	
//	// 댓글 삭제
//	@ResponseBody
//	@PostMapping("/commentdelete")
//	public String commentdelete(@RequestParam("comment_no") int comment_no) {
//		//회원정보삭제
//		System.out.println("comment_no: "+comment_no);
//		cmService.deleteByCommentNo(comment_no);
//		return "1";
//	}
	
	// 아티스트 리스트
	@GetMapping("/aartistlist")
	public String aartistlist(Model model) {
		
		List<ArtistDto> list = aService.findAll();
		model.addAttribute("list",list);
		return "/admin/aartistlist";
	}
	
	// 아티스트 등록
	@GetMapping("/awrite")
	public String awrite(Model model) {
		return "/admin/awrite";
	}
	
	// 아티스트 등록
	@PostMapping("/awrite")
	public String awrite(ArtistDto adto, 
			@RequestPart("files") MultipartFile files) throws Exception {
		
		System.out.println("notice_file: " + files); // ✅ 파일 값 확인
		
		String realName = ""; 
		adto.setArtist_group_image(""); // 파일첨부가 되지 않았을 경우
		if(files != null && !files.isEmpty()) {
			String origin = files.getOriginalFilename();
			long time = System.currentTimeMillis();
			realName = String.format("%d_%s", time, origin);
			
			String url = "c:/upload/test/";
			File f = new File(url+realName);
			files.transferTo(f);
			
			adto.setArtist_group_image(realName);
		}
		
		aService.awrite(adto);
		
		return "redirect:/aartistlist";
	}
	
	// 아티스트 등록 토글
	@PostMapping("/toggleArtistDisplay")
	@ResponseBody
	public ResponseEntity<?> toggleArtistDisplay(@RequestBody Map<String, Object> payload) {
	    int artistNo = Integer.parseInt((String) payload.get("artist_no"));
	    boolean display = (Boolean) payload.get("display");
	    
	    // 서비스 계층에서 DB 업데이트 수행 (예: updateDisplayStatus)
	    aService.updateDisplayStatus(artistNo, display);
	    
	    return ResponseEntity.ok().build();
	}
		
	// 아티스트 멤버리스트
	@GetMapping("/aartist")
	public String aartist(Model model) {
		
		List<ArtistMemberDto> list = artistMemberService.findAll();
		model.addAttribute("list",list);
		return "/admin/aartist";
	}
	
	// 아티스트 멤버등록
	@GetMapping("/amwrite")
	public String amwrite(Model model) {
		List<ArtistDto> list = aService.findAll(); // ArtistDto 목록 조회
	    model.addAttribute("alist", list);
		return "/admin/amwrite";
	}
	
	// 아티스트 멤버등록
	@PostMapping("/amwrite")
	public String amwrite(ArtistMemberDto amdto, 
			@RequestPart("files") MultipartFile files) throws Exception {
		
		System.out.println("notice_file: " + files); // ✅ 파일 값 확인
		
		String realName = ""; 
		amdto.setArtistmember_image(""); // 파일첨부가 되지 않았을 경우
		if(files != null && !files.isEmpty()) {
			String origin = files.getOriginalFilename();
			long time = System.currentTimeMillis();
			realName = String.format("%d_%s", time, origin);
			
			String url = "c:/upload/test/";
			File f = new File(url+realName);
			files.transferTo(f);
			
			amdto.setArtistmember_image(realName);
		}
		
		artistMemberService.amwrite(amdto);
		
		return "redirect:/aartist";
	}
	
	// 아티스트 멤버 아이디 중복확인
	@PostMapping("/checkartistmemberId")
	@ResponseBody
	public Map<String, Object> checkartistmemberId(@RequestParam("artistmemberId") String artistmemberId) {
	    boolean exists = artistMemberService.existsArtistMemberId(artistmemberId); // DB에 존재하는지 확인
	    Map<String, Object> response = new HashMap<>();
	    response.put("exists", exists);
	    return response;
	}
	
	// 아티스트 멤버 닉네임 중복확인
	@PostMapping("/checkartistmemberNickname")
	@ResponseBody
	public Map<String, Object> checkartistmemberNickname(@RequestParam("artistmemberNickname") String artistmemberNickname) { 
	    boolean exists = artistMemberService.existsArtistMemberNickname(artistmemberNickname); // DB에 존재하는지 확인 
	    Map<String, Object> response = new HashMap<>();
	    response.put("exists", exists);
	    return response;
	}
	
	// 아티스트 상세정보
	@GetMapping("/artistmemberInfo")
	public String artistmemberInfo(@RequestParam("nickname") String nickname,Model model) {
		
		ArtistMemberDto artistmemberDto = artistMemberService.findByNickname(nickname);
		model.addAttribute("amdto",artistmemberDto);
		return "/admin/artistmemberInfo";
	}
}
