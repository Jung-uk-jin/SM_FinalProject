package com.java.service;

import com.java.dto.NicknameDto;

public interface NicknameService {

	void save(NicknameDto ndto);

	NicknameDto findByNickName(String memberNickname);

}
