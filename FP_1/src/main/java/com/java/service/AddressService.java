package com.java.service;

import java.util.List;

import com.java.dto.AddressDto;

public interface AddressService {
	// 주소목록 갖고오기
	List<AddressDto> findByMemberId(String id);
}
