package com.java.service;

import java.util.ArrayList;

import com.java.dto.ArtistDto;
import com.java.dto.FanCommunityDto;

public interface FanCommuService {

	ArrayList<FanCommunityDto> findAll();

	void fcwrite(FanCommunityDto fcdto);

	FanCommunityDto findByCommunityNo(int communityNo);

	
	//게시글 삭제
	void deleteByCommunity(int communityNo);
	
	//게시글 수정
	void updateCommunity(FanCommunityDto existingPost);

}
