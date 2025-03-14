package com.java.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.java.dto.ShopDto;
import com.java.repository.SRepository;

@Service
public class SServiceImpl implements SService{

	@Autowired SRepository sRepository;
	
	@Override
	public List<ShopDto> findAll() {
		
		List<ShopDto> list = sRepository.findAll();
		return list;
	}
	
}
