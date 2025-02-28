package com.java.service;

import java.util.List;

import com.java.dto.CommunityDto;

public interface CService {

	List<CommunityDto> findByNickname(String nickname);

	void deleteByCommunityNo(int community_no);

}
