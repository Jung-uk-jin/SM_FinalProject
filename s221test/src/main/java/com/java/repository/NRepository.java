package com.java.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.java.dto.NoticeDto;

public interface NRepository extends JpaRepository<NoticeDto, Integer>{
	
}
