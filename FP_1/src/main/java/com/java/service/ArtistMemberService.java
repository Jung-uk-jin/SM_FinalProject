package com.java.service;

import java.util.List;

import com.java.dto.ArtistMemberDto;

public interface ArtistMemberService {

	List<ArtistMemberDto> findByArtistNo(int artist_no);
	
}
