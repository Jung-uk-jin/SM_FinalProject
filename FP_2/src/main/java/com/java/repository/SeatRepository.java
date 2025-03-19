package com.java.repository;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.java.dto.ConcertScheduleDto;
import com.java.dto.SeatDto;

public interface SeatRepository extends JpaRepository<SeatDto, Integer> {

	
	List<SeatDto> findByConcertScheduleDto_ScheduleNo(Integer scheduleNo);

//	List<ConcertScheduleDto> findDistinctSchedules();
	// 좌석 정보에서 ConcertScheduleDto 리스트 가져오기
    @Query("SELECT DISTINCT s.concertScheduleDto FROM SeatDto s")
    List<com.java.dto.ConcertScheduleDto> findDistinctSchedules();

    
    // 선택한 좌석 정보를 데이터베이스에서 다시 조회 - 지금 제대로 안됨
	List<SeatDto> findBySeatNoIn(List<Integer> selectedSeatNos);
	
	
	
	

}