package com.java.service;

import java.util.List;

import com.java.dto.CommentDto;
import com.java.dto.FanCommunityDto;

public interface CommentService {

	void saveComment(CommentDto commentDto);

	List<CommentDto> findByCommunityNo(int communityNo);

	void deleteByComment(int commentNo);

	long countByCommunity(FanCommunityDto post);


}
