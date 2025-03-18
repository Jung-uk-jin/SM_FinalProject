package com.java.service;

import java.util.List;

import com.java.dto.MemberDto;

public interface MService {

	List<MemberDto> findAll();

	MemberDto findByNickname(String nickname);

	void save(MemberDto mdto);

	void deleteByMemberNickname(String member_nickname);

	MemberDto findByIdAndPw(String id, String pw);

	MemberDto findByMemberId(String sessionId);

	// 아이디 중복확인
	boolean existsMemberId(String memberId);

	// 닉네임 중복확인
	boolean existsMemberNickname(String memberNickname);

}
