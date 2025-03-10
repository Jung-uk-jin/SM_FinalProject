package com.java.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.java.dto.ArtistMemberDto;

public interface ArtistMemberRepository extends JpaRepository<ArtistMemberDto, Integer> {

	@Query(value = "select * from artistmemberdto where artist_no=?", nativeQuery = true)
	List<ArtistMemberDto> findByArtistDto_ArtistNo(int artist_no);

}
