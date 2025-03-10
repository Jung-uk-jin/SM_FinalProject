package com.java.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.java.dto.ArtistDto;
import com.java.repository.ARepository;

@Service
public class AServiceImpl implements AService {

	@Autowired ARepository aRepository;
	
	@Override
	public List<ArtistDto> findAll() {
		
		List<ArtistDto> list = aRepository.findAll();
		return list;
	}

	@Override
	public ArtistDto findById(int artistNo) {
		
		return aRepository.findById(artistNo).orElse(null);
	}

}
