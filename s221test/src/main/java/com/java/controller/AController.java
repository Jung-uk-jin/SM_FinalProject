package com.java.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.java.dto.CommentDto;
import com.java.dto.CommunityDto;
import com.java.dto.MemberDto;
import com.java.service.CMService;
import com.java.service.CService;
import com.java.service.MService;

import jakarta.servlet.http.HttpSession;

@Controller
public class AController {
	
	@Autowired MService mService;
	@Autowired CService cService;
	@Autowired CMService cmService;
	
	// 회원 관리
	@GetMapping("/admin")
	public String admin(Model model) {
		
		List<MemberDto> list = mService.findAll();
		model.addAttribute("list",list);
		return "admin";
	}
	
	// 회원정보
	@GetMapping("/memInfo")
	public String memInfo(@RequestParam("nickname") String nickname,Model model) {
		
		MemberDto memberDto = mService.findByNickname(nickname);
		model.addAttribute("mdto",memberDto);
		return "memInfo";
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
		
		List<CommunityDto> list = cService.findByNickname(nickname);
		model.addAttribute("list",list);
		return "communityInfo";
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
		return "commentInfo";
	}
	
	// 댓글 삭제
	@ResponseBody
	@PostMapping("/commentdelete")
	public String commentdelete(@RequestParam("comment_no") int comment_no) {
		//회원정보삭제
		System.out.println("comment_no: "+comment_no);
		cmService.deleteByCommentNo(comment_no);
		return "1";
	}
	
}
