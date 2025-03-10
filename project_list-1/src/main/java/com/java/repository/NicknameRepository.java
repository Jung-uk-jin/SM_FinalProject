package com.java.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.java.dto.ArtistMemberDto;
import com.java.dto.NicknameDto;

public interface NicknameRepository extends JpaRepository<NicknameDto, String>{

	@Query(value="select * from nicknamedto where nickname_name=?", nativeQuery = true)
	NicknameDto findByNickName(String memberNickname);

}
