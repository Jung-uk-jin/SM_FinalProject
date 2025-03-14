package com.java.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.java.dto.CartDto;

public interface CartRepository extends JpaRepository<CartDto, Integer>  {
		// 계정 하나 찾기(list)
		@Query("SELECT a FROM CartDto a WHERE a.member.member_id = :id")
		List<CartDto> findByMemberId(@Param("id") String id);
		
		@Modifying
		@Query("DELETE FROM CartDto c WHERE c.cart_no = :cartNo")
		void deleteByCartNo(@Param("cartNo") int cartNo);

}
