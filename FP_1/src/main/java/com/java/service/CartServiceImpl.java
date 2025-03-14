package com.java.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.java.dto.AddressDto;
import com.java.dto.CartDto;
import com.java.dto.MemberDto;
import com.java.repository.AddressRepository;
import com.java.repository.CartRepository;

@Service
public class CartServiceImpl implements CartService {
	@Autowired CartRepository sRepository;

	// 장바구니 리스트
	@Override
	public List<CartDto> findByMemberId(String id) {
		List<CartDto> cList = sRepository.findByMemberId(id);
		return cList;
	}

	// 장바구니 삭제
	@Override
	public boolean deleteCartItem(int cartNo) {
	    try {
	        if (sRepository.existsById(cartNo)) {  // 해당 cartNo가 존재하는지 확인
	            sRepository.deleteById(cartNo);   // 장바구니에서 삭제
	            return true; // 삭제 성공
	        } else {
	            return false; // 해당 cartNo가 없음
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false; // 삭제 중 오류 발생
	    }
	}

	
	

}
