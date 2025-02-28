package com.java.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.java.dto.CommunityDto;

import jakarta.transaction.Transactional;


public interface CRepository extends JpaRepository<CommunityDto, Integer>{

	@Query(value="SELECT c FROM CommunityDto c JOIN c.memberDto m WHERE m.member_nickname = :nickname")
	List<CommunityDto> findByNickname(@Param("nickname") String nickname);

	@Modifying
    @Transactional
    @Query(value = "DELETE FROM communitydto WHERE community_no=?", nativeQuery = true)
	void deleteByCommunityNo(int community_no);

	// 게시글 수
	@Query("SELECT COUNT(c) FROM CommunityDto c WHERE c.memberDto.member_nickname = :nickname")
	long countCommunityByMemberNickname(@Param("nickname") String nickname);

	@Query("SELECT c FROM CommunityDto c WHERE c.community_no = :community_no")
	CommunityDto findByCommunityNo(@Param("community_no") int community_no);

//	@Modifying
//	@Query("DELETE FROM CommunityDto c WHERE c.memberDto.member_nickname = :nickname")
//	void deleteByMemberNickname(@Param("nickname") String member_nickname);


}
