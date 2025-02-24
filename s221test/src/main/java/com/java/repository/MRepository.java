package com.java.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.java.dto.MemberDto;

// JpaRepository<MemberDto, String> : <리턴타입,primary key타입>
public interface MRepository extends JpaRepository<MemberDto, String>{

//	MemberDto findByIdAndPw(String id, String pw);

}
