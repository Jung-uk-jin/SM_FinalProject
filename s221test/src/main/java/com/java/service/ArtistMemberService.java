package com.java.service;

import java.util.List;

import com.java.dto.ArtistMemberDto;

public interface ArtistMemberService {

	// 아티스트 상세보기
	List<ArtistMemberDto> findByArtistNo(int artist_no);

	// 아티스트 로그인
	ArtistMemberDto findByIdAndPw(String id, String pw);

	// 관리자페이지 - 아티스트 멤버리스트
	List<ArtistMemberDto> findAll();

	// 아티스트 상세정보
	ArtistMemberDto findByNickname(String nickname);

	// 아티스트 멤버 등록
	void amwrite(ArtistMemberDto amdto);

	// 아티스트 멤버 아이디 중복확인
	boolean existsArtistMemberId(String artistmemberId);

	// 아티스트 멤버 닉네임 중복확인
	boolean existsArtistMemberNickname(String artistmemberNickname);
	
}
