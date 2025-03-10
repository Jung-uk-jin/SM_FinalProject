package com.java.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.java.dto.ArtistDto;
import com.java.dto.BoardDto;
import com.java.dto.CommentDto;
import com.java.dto.FanCommunityDto;
import com.java.dto.LikeDto;
import com.java.dto.MemberDto;
import com.java.dto.NicknameDto;
import com.java.service.CommentService;
import com.java.service.FanCommuService;
import com.java.service.MemberService;
import com.java.service.NicknameService;

import jakarta.servlet.http.HttpSession;


@Controller
public class FanCommuController {
	@Autowired CommentService commentService;
	@Autowired FanCommuService fanCommuService;
	@Autowired MemberService memberService;
	@Autowired NicknameService nicknameService;
	@Autowired HttpSession session;
	
	@GetMapping("/fancommunity")
	public String fancommunity(@RequestParam("artist_no") int artist_no, Model model) {
		
		ArrayList<FanCommunityDto> list = fanCommuService.findAll(); // List인데...흠..
		model.addAttribute("list",list);
		return "fancommunity";
	}
	
	@GetMapping("/fancommunity/detail")
	@ResponseBody
	public List<CommentDto> fancommunityview(@RequestParam("communityNo") int communityNo) {
		List<CommentDto> clist = commentService.findByCommunityNo(communityNo);
		
		return clist;
	}
	
	

	
	// public String fcwrite(FanCommunityDto fcdto,@RequestPart MultipartFile files) throws Exception 
	@PostMapping("/fcwrite")//글쓰기 저장
	public String fcwrite(@RequestParam("artist_no") int artistNo,
			@RequestParam(value="imageFile", required=false) MultipartFile files, FanCommunityDto fcdto) throws Exception {
		
		System.out.println("artistNo  : "+artistNo);
		
	    ArtistDto artistDto = new ArtistDto();
	    artistDto.setArtist_no(artistNo);
	    
	    // FanCommunityDto에 artistDto 설정
	    fcdto.setArtistDto(artistDto);
	    
	    // 세션에서 nickname 바로 가져오기
	    String nickname = (String) session.getAttribute("nickname");
	    NicknameDto ndto = new NicknameDto();
	    ndto.setNickname_name(nickname);
	    fcdto.setNicknameDto(ndto);
	    
	    //  이미지 출력
	    fcdto.setF_community_image("");
	    if(!files.isEmpty()) {
	    	String origin = files.getOriginalFilename();
	    	long time = System.currentTimeMillis();
	    	String realFileName = String.format("%d_%s", time, origin) ;
	    	String url= "c:/upload/artist/";
	    	File f = new File(url+realFileName);
	    	files.transferTo(f);
	    	fcdto.setF_community_image(realFileName);
	    }
	    
	    System.out.println("파일 크기: " + files.getSize());
	    

		fanCommuService.fcwrite(fcdto);
		return "redirect:/fancommunity?artist_no="+artistNo;
		}
	
	
	//댓글 저장
	@PostMapping("/comments/add")
	@ResponseBody
	public CommentDto addComment(
	        @ModelAttribute CommentDto commentDto,
	        @RequestParam("communityNo") int communityNo,
	        @RequestParam("memberNickname") String memberNickname) {
	    
	    // 게시글(FanCommunityDto) 설정
	    FanCommunityDto addfcdto = fanCommuService.findByCommunityNo(communityNo);
	    commentDto.setCommunityDto(addfcdto);
	    
	    // 댓글 작성자(MemberDto) 설정 (여기서는 member_nickname을 사용)
	    NicknameDto addmdto = nicknameService.findByNickName(memberNickname);
	    commentDto.setNicknameDto(addmdto);
	    
	    
	    // commentDto의 comment_date는 @CreationTimestamp로 자동 세팅됨
	    commentService.saveComment(commentDto);
	    
	    
	    return commentDto;
	}
	
	
	//댓글 수
	@GetMapping("/comments/count")
	@ResponseBody
	public long getCommentCount(@RequestParam("communityNo") int communityNo) {
	    FanCommunityDto post = fanCommuService.findByCommunityNo(communityNo);
	    if(post == null) {
	        return 0;
	    }
	    return commentService.countByCommunity(post);
	}
	
	
	//게시글 삭제하기
	@ResponseBody
	@PostMapping("/fancommunity/delete")
	public String deletePost(@RequestParam("communityNo") int communityNo) {
	    // 게시글 삭제 처리 (삭제 후 결과에 따라 "success" 반환)
	    fanCommuService.deleteByCommunity(communityNo);
	    return "1";
	}
	
	//게시글 수정
	@GetMapping("/fancommunity/getPost")
	@ResponseBody
	public FanCommunityDto getPost(@RequestParam("communityNo") int communityNo) {
	    return fanCommuService.findByCommunityNo(communityNo);
	}
	
	@PostMapping("/fcupdate")
	public String fcupdate(@ModelAttribute FanCommunityDto fcdto, 
	        @RequestParam("artist_no") int artistNo,
	        @RequestParam("f_community_no") int communityNo,
	        @RequestParam(value="imageFile1", required=false) MultipartFile file) throws Exception{
	
		// 기존 게시글을 DB에서 조회
	    FanCommunityDto existingPost = fanCommuService.findByCommunityNo(communityNo);
	    
	    // 수정할 내용 업데이트 (예: 게시글 내용)
	    existingPost.setF_community_content(fcdto.getF_community_content());
	    
	    // 만약 새 이미지가 업로드 되었다면, 파일 처리 후 이미지 파일명 업데이트
	    if (file != null && !file.isEmpty()) {
	    	
	        String originalFilename = file.getOriginalFilename();
	        long time = System.currentTimeMillis();
	        String newFileName = time + "_" + originalFilename;
	        // 실제 이미지 저장 경로 (서버 환경에 맞게 수정)
	        String uploadPath = "c:/upload/artist/";  
	        File dest = new File(uploadPath + newFileName);
	        file.transferTo(dest);
	        existingPost.setF_community_image(newFileName);
	    }
	    
	    
	    
	    // 게시글 업데이트 (업데이트 로직이 fanCommuService.updateCommunity()에 구현되어 있다고 가정)
	    fanCommuService.updateCommunity(existingPost);
		
		return "redirect:/fancommunity?artist_no="+artistNo;
	}
	
	//삭제하기
	@ResponseBody
	@PostMapping("/fancomment/delete")
	public String deleteComment(@RequestParam("commentNo") int commentNo) {
	    // 게시글 삭제 처리 (삭제 후 결과에 따라 "success" 반환)
		commentService.deleteByComment(commentNo);
	    return "1";
	}
	
	
}

