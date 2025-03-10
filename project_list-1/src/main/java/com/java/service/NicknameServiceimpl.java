package com.java.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.java.dto.NicknameDto;
import com.java.repository.NicknameRepository;

@Service
public class NicknameServiceimpl implements NicknameService {

	@Autowired NicknameRepository nicknameRepository;
	
	@Override
	public void save(NicknameDto ndto) {
		nicknameRepository.save(ndto);
	}

	@Override
	public NicknameDto findByNickName(String memberNickname) {
		NicknameDto ndto = nicknameRepository.findByNickName(memberNickname);
		return ndto;
	}

}
