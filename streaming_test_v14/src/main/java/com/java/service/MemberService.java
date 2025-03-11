package com.java.service;

import com.java.dto.MemberDto;

public interface MemberService {

	MemberDto findByIdAndPw(String id, String pw);
}
