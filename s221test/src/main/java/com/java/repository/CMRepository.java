package com.java.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.java.dto.CommentDto;

import jakarta.transaction.Transactional;

public interface CMRepository extends JpaRepository<CommentDto, Integer>{

	@Query(value="SELECT c FROM CommentDto c WHERE c.memberDto.member_nickname = :nickname")
	List<CommentDto> findByNickname(@Param("nickname") String nickname);

	@Modifying
    @Transactional
    @Query(value = "DELETE FROM commentdto WHERE comment_no=?", nativeQuery = true)
	void deleteByCommunityNo(int comment_no);

	// 댓글 수
	@Query("SELECT COUNT(c) FROM CommentDto c WHERE c.memberDto.member_nickname = :nickname")
	long countCommentByMemberNickname(@Param("nickname") String nickname);

	@Query("SELECT cm FROM CommentDto cm WHERE cm.communityDto.community_no = :community_no")
	List<CommentDto> findByCommunityNo(@Param("community_no") int community_no);

//	@Modifying
//	@Query("DELETE FROM CommentDto c WHERE c.memberDto.member_nickname = :nickname")
//	void deleteByMemberNickname(@Param("nickname") String member_nickname);

}
