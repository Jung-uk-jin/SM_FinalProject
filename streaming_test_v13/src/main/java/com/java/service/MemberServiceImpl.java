package com.java.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.java.dto.MemberDto;
import com.java.repository.MemberRepository;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired MemberRepository memberRepository;
	
	@Override
	public MemberDto findByIdAndPw(String id, String pw) {
		MemberDto memberDto = memberRepository.findByIdAndPw(id,pw)
				.orElseThrow(()->{
					return new IllegalArgumentException("데이터 처리시 에러!!");
				});
		return memberDto;
	}
	
}
