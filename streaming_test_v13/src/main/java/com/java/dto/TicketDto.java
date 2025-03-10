package com.java.dto;

import java.sql.Timestamp;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.DynamicInsert;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.SequenceGenerator;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@DynamicInsert
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
@Entity
public class TicketDto {
	
	@Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "shop_seq")
    @SequenceGenerator(name = "shop_seq", sequenceName = "shop_seq", allocationSize = 1)
	private int ticket_no; 					// 티켓고유번호
	@Column(nullable = false, length=30)
	private String ticket_title; 			// 티켓명
	@Column(length=1000)
	private String ticket_content; 			// 티켓설명
	@Column(length=100)
	private String ticket_image; 			// 티켓이미지
	@Column(nullable = false, length=10)
	private int ticket_price; 				// 가격
	@Column(length=10)
	private int ticket_quantity; 			// 재고수량
	@CreationTimestamp
	private Timestamp ticket_date; 			// 등록일
	
    @ManyToOne
    @JoinColumn(name = "artist_group_name")  // 외래키로 artist와 연결
    private ArtistDto ticket_group_name;
}
