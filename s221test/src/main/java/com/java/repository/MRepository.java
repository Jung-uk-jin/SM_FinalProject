package com.java.repository;

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

}
