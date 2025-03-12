package com.java.repository; 

import java.util.ArrayList;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.java.dto.FanCommunityDto;

import jakarta.transaction.Transactional;

public interface FancommuRepository extends JpaRepository<FanCommunityDto, Integer> {
	@Query(value="select * from fancommunitydto order by f_community_no desc", nativeQuery = true)
	ArrayList<FanCommunityDto> findAll();
	
	@Query(value="select * from fancommunitydto where f_community_no=?",nativeQuery = true)
	FanCommunityDto findByCommunityNo(int communityNo);
	
	@Modifying
    @Transactional
    @Query(value = "DELETE FROM fancommunitydto WHERE f_community_no=?", nativeQuery = true)
    void deleteByCommunityNo(int communityNo);
	
	
		
}
