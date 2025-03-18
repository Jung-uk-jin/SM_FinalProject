package com.java.service;

import java.util.List;

import com.java.dto.ConcertScheduleDto;
import com.java.dto.SeatDto;

public interface SeatService {

	// 선택한 날짜에 해당하는 좌석 정보를 가져오는 API
	List<SeatDto> getSeatsBySchedule(Integer scheduleNo);

	// 콘서트 일정 목록 가져오기
	List<ConcertScheduleDto> getAllSchedules();

	// 선택한 seatNo 리스트에 해당하는 좌석만 가져옴
//	List<SeatDto> getSeatsByIds(List<Integer> selectedSeatNos);


//	List<SeatDto> getSeatsByIds(Integer integer, Integer integer2);


}