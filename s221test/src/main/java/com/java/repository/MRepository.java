package com.java.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.java.dto.MemberDto;

import jakarta.transaction.Transactional;

// JpaRepository<MemberDto, String> : <리턴타입,primary key타입>
public interface MRepository extends JpaRepository<MemberDto, String>{

	@Query(value="select * from memberdto where member_nickname=?", nativeQuery=true)
	MemberDto findByNickname(String nickname);

	@Modifying
    @Transactional
    @Query(value = "DELETE FROM memberdto WHERE member_nickname=?", nativeQuery = true)
    void deleteByMemberNickname(String member_nickname);
	
	// 로그인
	@Query(value = "select * from memberdto where member_id=? and member_pw=?", nativeQuery = true)
	Optional<MemberDto> findByIdAndPw(String id, String pw);

	@Query(value = "select * from memberdto where member_id=?", nativeQuery = true)
	Optional<MemberDto> findById(String sessionId);
}
