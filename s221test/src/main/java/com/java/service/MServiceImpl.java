package com.java.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.java.dto.MemberDto;
import com.java.repository.MRepository;

@Service
public class MServiceImpl implements MService{

//	@Autowired MRepository mRepository;
//	
//	@Override
//	public void save(MemberDto mdto) {
//		mRepository.save(mdto); // 자동저장, mapper.xml 필요X
//	}
//
//	@Override
//	public List<MemberDto> findAll() {
//		List<MemberDto> list = mRepository.findAll(); // findById : 한개 가져올떄
//		return list;
//	}
//
//	@Override
//	public MemberDto findById(String id) {
//		
//		// findById > 검색이 없을 경우 에러처리를 해야함
//		// findById : select * from memberdto where id=#{id}
//		// findByIdAndPw : select * from memberdto where id=#{id} and pw=#{pw}
//		MemberDto memberDto = mRepository.findById(id)
//				.orElseThrow(() -> {
//					return new IllegalArgumentException("데이터 처리시 에러");
//				}); // 에러처리
//		return memberDto;
//	}
//
//	@Override
//	public void deleteById(String id) {
//		
//		mRepository.deleteById(id);
//	}
//
//	@Override
//	public MemberDto findByIdAndPw(String id, String pw) {
//		
//		MemberDto memberDto = mRepository.findByIdAndPw(id,pw);
//		return memberDto;
//	}
	
	

}
