package com.java.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.java.dto.MemberDto;

public interface MemberRepository extends JpaRepository<MemberDto, String>{

	@Query(value="select * from memberdto where member_nickname=?",nativeQuery = true)
	MemberDto findByNickName(String memberNickname);

	// 
	@Query(value="select * from memberdto where member_phone=?",nativeQuery = true)
	MemberDto findByPhone(String phone);

}
