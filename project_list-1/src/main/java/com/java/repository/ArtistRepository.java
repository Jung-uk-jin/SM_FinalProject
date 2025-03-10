package com.java.repository;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.java.dto.ArtistDto;


public interface ArtistRepository extends JpaRepository<ArtistDto, Integer>{

	@Query(value = "select * from artistDto where artist_no=?", nativeQuery = true)
	ArtistDto findByArtistNo(int artistNo);
	
}
