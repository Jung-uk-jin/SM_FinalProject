package com.java.service;

import com.java.dto.NicknameDto;

public interface NicknameService {

	void save(NicknameDto ndto);

	NicknameDto findByNickName(String memberNickname);

	// 닉네임 중복확인
	boolean isNicknameExists(String nickname_name);

}
