package com.java.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.java.dto.MemberDto;
import com.java.repository.MemberRepository;

@Service
public class MemberSerivceImpl implements MemberService {

	@Autowired MemberRepository memberRepository;
	
	@Override
	public MemberDto findByNickName(String memberNickname) {
		
		MemberDto mdto = memberRepository.findByNickName(memberNickname);
		return mdto;
	}

	// WebSocket OTP 인증
	@Override
	public MemberDto findByPhone(String phone) {
		MemberDto mdto = memberRepository.findByPhone(phone);
		return mdto;
	}

}
