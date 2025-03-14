package com.java.dto;

import java.sql.Timestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder

@Entity
public class OrderDto {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int order_id; // 주문 고유번호

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id", nullable = false)
    private MemberDto member;  // 🚀 회원 테이블과 연결 (외래키)
    
    @Column(nullable = false, unique = true, length = 20)
    private String orderNumber; // 주문번호 (YYYYMMDD-랜덤숫자)
    
    @Column
    private Timestamp order_date; // 주문 날짜

    @Column(length=50)
    private String order_status; // 주문 상태

    @Column
    private int order_total_amount; // 총 금액

    @Column(length=500)
    private String order_address; // 배송지 주소
}
