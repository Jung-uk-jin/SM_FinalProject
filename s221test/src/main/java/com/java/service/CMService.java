package com.java.service;

import java.util.List;

import com.java.dto.CommentDto;

public interface CMService {

	List<CommentDto> findByNickname(String nickname);

	void deleteByCommentNo(int comment_no);

}
