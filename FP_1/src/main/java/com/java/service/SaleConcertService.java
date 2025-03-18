package com.java.service;

import java.util.List;

import com.java.dto.SaleConcertDto;

public interface SaleConcertService {
	
	// 현재 날짜가 rsvOpenDate 이후인 판매 콘서트 조회 (메인 페이지에 출력)
	List<SaleConcertDto> getOpenSaleConcerts();
	
	// 특정 concertNo에 해당하는 판매 콘서트 정보 조회 - 오프라인용
//	List<SaleConcertDto> getSaleConcertBySaleConcertNo(Integer concertNo);

	// 특정 saleConcertNo에 해당하는 판매 콘서트 정보 (단일 객체) 조회 - 온라인용
//	SaleConcertDto getSingleSaleConcertBySaleConcertNo(Integer saleConcertNo);
	SaleConcertDto getSaleConcertBySaleConcertNo(Integer saleConcertNo);

	

}