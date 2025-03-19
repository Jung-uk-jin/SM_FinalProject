package com.java.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.java.dto.SaleConcertDto;
import com.java.repository.SaleConcertRepository;

@Service
public class SaleConcertServiceImpl implements SaleConcertService {

	
	@Autowired
    private SaleConcertRepository saleConcertRepository;
	
	// rsvOpenDate 이후인 판매 콘서트 리스트 조회 (메인 페이지에서 출력)
	@Override
	public List<SaleConcertDto> getOpenSaleConcerts() {
		LocalDate today = LocalDate.now();
        return saleConcertRepository.findByRsvOpenDateLessThanEqual(today);
	}

	// 특정 saleConcertNo에 해당하는 콘서트 판매 정보 조회 - 오프라인용
//	@Override
//	public List<SaleConcertDto> getSaleConcertBySaleConcertNo(Integer saleConcertNo) {
//		return saleConcertRepository.findBySaleConcertDto(saleConcertNo);
//	}

	// 특정 saleConcertNo에 해당하는 콘서트 판매 정보 조회
	@Override
	public SaleConcertDto getSaleConcertBySaleConcertNo(Integer saleConcertNo) {
		
		System.out.println("데이터베이스에서 조회할 saleConcertNo: " + saleConcertNo);
		
		
		return saleConcertRepository.findBySaleConcertNo(saleConcertNo);
	}

}