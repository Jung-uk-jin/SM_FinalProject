package com.java.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.java.dto.NoticeDto;
import com.java.repository.NRepository;

@Service
public class NServiceImpl implements NService {

	@Autowired NRepository nRepository;
	
	@Override
	public List<NoticeDto> findAll() {
		
		List<NoticeDto> list = nRepository.findAll();
		return list;
	}

}
