package com.java.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.java.dto.AddressDto;
import com.java.repository.AddressRepository;

@Service
public class AddressServiceImpl implements AddressService {
	@Autowired AddressRepository aRepository;

	@Override
	public List<AddressDto> findByMemberId(String id) {
		List<AddressDto> aList = aRepository.findByMemberId(id);
		return aList;
	}
}
