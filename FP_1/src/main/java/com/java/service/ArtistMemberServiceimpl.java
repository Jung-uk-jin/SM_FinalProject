package com.java.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.java.dto.ArtistMemberDto;
import com.java.repository.ArtistMemberRepository;

@Service
public class ArtistMemberServiceimpl implements ArtistMemberService {
	
	@Autowired ArtistMemberRepository artistMemberRepository;
	
	@Override
	public List<ArtistMemberDto> findByArtistNo(int artist_no) {
		List<ArtistMemberDto> list = artistMemberRepository.findByArtistDto_ArtistNo(artist_no);
		return list;
	}

}
