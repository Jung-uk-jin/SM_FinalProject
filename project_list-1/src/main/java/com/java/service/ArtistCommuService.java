package com.java.service;

import java.util.List;

import com.java.dto.ArtistCommunityDto;

public interface ArtistCommuService {

	void acwrite(ArtistCommunityDto acdto);

	List<ArtistCommunityDto> findAll();

	void deleteByCommunity(int communityNo);

}
