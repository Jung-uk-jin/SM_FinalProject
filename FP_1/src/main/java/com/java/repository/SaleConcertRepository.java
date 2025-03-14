package com.java.repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.java.dto.SaleConcertDto;

public interface SaleConcertRepository extends JpaRepository<SaleConcertDto, Integer>{

	
	// rsvOpenDate 이후인 콘서트 리스트 조회 (메인 페이지에서 출력)
	@Query("SELECT scd FROM SaleConcertDto scd WHERE scd.rsvOpenDate <= :today")
	List<SaleConcertDto> findByRsvOpenDateLessThanEqual(LocalDate today);

	
	// 특정 concertNo에 해당하는 판매 콘서트 정보 조회
	List<SaleConcertDto> findByConcertDto_ConcertNo(Integer concertNo);



}
