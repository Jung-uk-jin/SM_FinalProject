package com.java.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.java.dto.OrderDto;
import com.java.repository.OrderRepository;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired OrderRepository orderRepository;
	
	@Override
	public OrderDto getOrderById(int orderId) {
		return orderRepository.findById(orderId).orElse(null);
	}

}
