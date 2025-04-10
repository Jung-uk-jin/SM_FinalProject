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

}
