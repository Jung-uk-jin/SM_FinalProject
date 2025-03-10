package com.java.service;

import java.util.List;

import com.java.dto.NoticeDto;

public interface NService {

	List<NoticeDto> findAll();

	void nwrite(NoticeDto ndto);

	NoticeDto findByNoticeNo(int notice_no);

	void save(NoticeDto ndto);

	void deleteByNoticeNo(int notice_no);

}
