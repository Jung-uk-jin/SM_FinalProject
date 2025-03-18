package com.java.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.java.dto.ArtistMemberDto;
import com.java.repository.ArtistMemberRepository;
import com.java.repository.MRepository;

@Service
public class ArtistMemberServiceimpl implements ArtistMemberService {
	
	@Autowired MRepository mRepository;
	@Autowired ArtistMemberRepository artistMemberRepository;
	
	@Override
	public List<ArtistMemberDto> findByArtistNo(int artist_no) {
		List<ArtistMemberDto> list = artistMemberRepository.findByArtistDto_ArtistNo(artist_no);
		return list;
	}

	// 아티스트 멤버 리스트
	@Override
	public List<ArtistMemberDto> findAll() {
		List<ArtistMemberDto> amlist = artistMemberRepository.findAll();
		return amlist;
	}
	// 아티스트 멤버등록
	@Override
	public void amwrite(ArtistMemberDto amdto) {
		artistMemberRepository.save(amdto);
		
	}
	// 아티스트 아이디 중복확인
	@Override
	public boolean existsArtistMemberId(String artistmemberId) {
		return mRepository.existsByMemberId(artistmemberId) ||
	           artistMemberRepository.existsArtistMemberId(artistmemberId);
	}
	// 아티스트 닉네임 중복확인
	@Override
	public boolean existsArtistMemberNickname(String artistmemberNickname) {
		return mRepository.existsByMemberNickname(artistmemberNickname) ||
				artistMemberRepository.existsArtistMemberNickname(artistmemberNickname);
	}
	// 아티스트 멤버 상세보기
	@Override
	public ArtistMemberDto findByNickname(String nickname) {
		ArtistMemberDto artistmemberdto = artistMemberRepository.findByNickname(nickname);
		return artistmemberdto;
	}
}
