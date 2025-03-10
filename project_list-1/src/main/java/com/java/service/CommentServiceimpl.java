package com.java.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.java.dto.CommentDto;
import com.java.dto.FanCommunityDto;
import com.java.repository.CommentRepository;

@Service
public class CommentServiceimpl implements CommentService {

	@Autowired CommentRepository commentRepository;
	
	@Override
	public void saveComment(CommentDto commentDto) {
		
		commentRepository.save(commentDto);
		
	}

	@Override
	public List<CommentDto> findByCommunityNo(int communityNo) {
		List<CommentDto> clist = commentRepository.findByCommunityNo(communityNo);
		return clist;
	}

	@Override
	public void deleteByComment(int commentNo) {
		CommentDto cmdto = commentRepository.findBycommentNo(commentNo);
		commentRepository.delete(cmdto);
		
	}

	@Override
	public long countByCommunity(FanCommunityDto communityDto) {
		return commentRepository.countByCommunityDto(communityDto);
	}



}
