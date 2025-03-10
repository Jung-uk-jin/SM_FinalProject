package com.java.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.java.dto.ArtistDto;
import com.java.repository.ArtistRepository;

@Service
public class ArtistServiceimpl implements ArtistService {
	@Autowired ArtistRepository artistRepository;
	
	// 메인페이지 아티스트 리스트
	@Override
	public List<ArtistDto> findAll() {
		List<ArtistDto> list = artistRepository.findAll();
		return list;
	}
	
	// 
	@Override
	public ArtistDto findByArtistNo(int artistNo) {
		ArtistDto artistDto = artistRepository.findByArtistNo(artistNo);
		return artistDto;
	}

	
	

}
