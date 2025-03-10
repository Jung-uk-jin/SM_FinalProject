package com.java.service;

import java.util.List;

import com.java.dto.ArtistDto;


public interface ArtistService {
	
	// 메인페이지 아티스트리스트
	List<ArtistDto> findAll();

	ArtistDto findByArtistNo(int artistNo);


}
