package com.java.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.java.dto.EventDto;

public interface ERepository extends JpaRepository<EventDto, Integer>{
	
}
