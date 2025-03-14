package com.java.service;

import java.util.List;

import com.java.dto.ArtistCommunityDto;

public interface ArtistCommuService {

	void acwrite(ArtistCommunityDto acdto);

	List<ArtistCommunityDto> findAll();
	//삭제
	void deleteByCommunity(int communityNo);
	
	//게시글 수정
	ArtistCommunityDto findByACommunityNo(int communityNo);
	void updateCommunity(ArtistCommunityDto existingPost);

}
