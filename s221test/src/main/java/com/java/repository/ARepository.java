package com.java.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.java.dto.ArtistDto;

public interface ARepository extends JpaRepository<ArtistDto, Integer>{
	

}
