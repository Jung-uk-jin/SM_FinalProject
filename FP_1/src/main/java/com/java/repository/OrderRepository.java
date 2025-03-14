package com.java.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.java.dto.OrderDto;

public interface OrderRepository extends JpaRepository<OrderDto, Integer>{

}
