package com.java.repository;

import com.java.dto.CommentDto;
import com.java.dto.FanCommunityDto;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface CommentRepository extends JpaRepository<CommentDto, Integer> {
    @Query("select c from CommentDto c where c.communityDto.f_community_no = ?1")
    List<CommentDto> findByCommunityNo(int communityNo);

    @Query(value="select * from CommentDto where comment_no=?",nativeQuery = true)
	CommentDto findBycommentNo(int commentNo);

	long countByCommunityDto(FanCommunityDto communityDto);
   
}

