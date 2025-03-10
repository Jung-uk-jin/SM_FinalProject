package com.java.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.java.dto.ArtistMemberDto;
import com.java.dto.NicknameDto;

public interface NicknameRepository extends JpaRepository<NicknameDto, String>{

	@Query(value="select * from nicknamedto where nickname_name=?", nativeQuery = true)
	NicknameDto findByNickName(String memberNickname);

	// 닉네임 중복체크
	@Query("SELECT COUNT(n) > 0 FROM NicknameDto n WHERE n.nickname_name = :nicknameName")
    boolean existsByNicknameName(@Param("nicknameName") String nicknameName);

}
