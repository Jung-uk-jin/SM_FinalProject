package com.java.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.java.dto.ArtistDto;
import com.java.dto.BoardDto;
import com.java.dto.CommentDto;
import com.java.dto.FanCommunityDto;
import com.java.repository.CommentRepository;
import com.java.repository.FancommuRepository;

@Service
public class FanCommuServiceimpl implements FanCommuService {

	@Autowired FancommuRepository fancommuRepository;
	@Autowired CommentRepository commentRepository;
	
	@Override
	public ArrayList<FanCommunityDto> findAll() {
		ArrayList<FanCommunityDto> list = fancommuRepository.findAll();
		return list;
	}
	
//	@Override //글쓰기
//	public void fcwrite(BoardDto bdto) {
//		int result = boardMapper.insertBoard(bdto);
//		System.out.println("결과값: "+result);
//		
//	}

	@Override //글쓰기
	public void fcwrite(FanCommunityDto fcdto) {
		fancommuRepository.save(fcdto);
	}

	@Override
	public FanCommunityDto findByCommunityNo(int communityNo) {
		FanCommunityDto fcdto = fancommuRepository.findByCommunityNo(communityNo);
		return fcdto;
	}

	//게시글 삭제하기
	@Override
	public void deleteByCommunity(int communityNo) {
		FanCommunityDto fcdto = fancommuRepository.findByCommunityNo(communityNo);
		
		if(fcdto != null) {
			//게시글 댓글 삭제
			List<CommentDto> comments = commentRepository.findByCommunityNo(communityNo);
			commentRepository.deleteAll(comments);
			
			//게시글 삭제
			fancommuRepository.delete(fcdto);
		} else {
	        throw new RuntimeException("해당 게시글을 찾을 수 없습니다.");
	    }
	}
	
	
	
	//게시글 수정
	@Override
	public void updateCommunity(FanCommunityDto existingPost) {
		fancommuRepository.save(existingPost);
	}
	
	
	

	
}
