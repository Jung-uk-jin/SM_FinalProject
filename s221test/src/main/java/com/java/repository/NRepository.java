package com.java.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.java.dto.NoticeDto;

public interface NRepository extends JpaRepository<NoticeDto, Integer>{

	@Query(value="select * from noticedto where notice_no=?", nativeQuery=true)
	NoticeDto findByNoticeNo(int notice_no);
	
}
