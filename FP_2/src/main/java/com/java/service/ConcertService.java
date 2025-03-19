package com.java.service;


import java.util.List;

import com.java.dto.ConcertDto;
import com.java.dto.ConcertScheduleDto;
import com.java.dto.SaleConcertDto;

public interface ConcertService {

	// 콘서트 정보 조회
	ConcertDto getConcertByConcertNo(Integer concertNo);
	
	
	// 예약된 좌석 개수 가져오기
	Integer getBookedTickets(Integer saleConcertNo);


	// 해당 콘서트의 일정 리스트 조회
	List<ConcertScheduleDto> getConcertSchedulesBySaleConcertNo(Integer saleConcertNo);



}