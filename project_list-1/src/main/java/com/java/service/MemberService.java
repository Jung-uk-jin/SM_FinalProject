package com.java.service;

import com.java.dto.MemberDto;

public interface MemberService {

	MemberDto findByNickName(String memberNickname);
	
	// WebSocket OTP 인증
	MemberDto findByPhone(String phone);

}
