package com.java.service;

import java.util.List;

import com.java.dto.ArtistDto;

public interface AService {

	List<ArtistDto> findAll();

	ArtistDto findById(int artistNo);

	ArtistDto findByArtistNo(int artist_no);

}
