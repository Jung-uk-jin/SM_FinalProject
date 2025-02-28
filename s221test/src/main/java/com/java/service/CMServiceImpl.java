package com.java.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.java.dto.CommentDto;
import com.java.repository.CMRepository;

@Service
public class CMServiceImpl implements CMService {

	@Autowired CMRepository cmRepository;
	
	@Override
	public List<CommentDto> findByNickname(String nickname) {
		List<CommentDto> list = cmRepository.findByNickname(nickname);
		return list;
	}

	@Override
	public void deleteByCommentNo(int comment_no) {
		cmRepository.deleteByCommunityNo(comment_no);
	}

}
