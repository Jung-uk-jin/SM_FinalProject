package com.java.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.java.dto.AddressDto;

public interface AddressRepository extends JpaRepository<AddressDto, Integer> {
	// 계정 하나 찾기(list)
	@Query("SELECT a FROM AddressDto a WHERE a.member.member_id = :id ORDER BY a.address_isDefault DESC")
	List<AddressDto> findByMemberId(@Param("id") String id);
}
