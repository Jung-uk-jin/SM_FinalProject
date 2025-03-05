package com.java.dto;

import java.sql.Timestamp;
import java.time.LocalDateTime;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.DynamicInsert;

import com.fasterxml.jackson.annotation.JsonFormat;

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
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ticket_seq")
    @SequenceGenerator(name = "ticket_seq", sequenceName = "ticket_seq", allocationSize = 1)
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
	@Column(length=10)
	private String ticket_type;				// 티켓 유형
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime ticket_valid_from;// 티켓 유효일
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime ticket_valid_to;	// 티켓 만료일
    @Column(nullable=false, unique=true,length=50)
	private String ticket_redeem_code; 		// 티켓리딤코드
    @Column(nullable=false)
    private Boolean ticket_is_restreaming_allowed; // 
    
    
    @ManyToOne
    @JoinColumn(name = "artist_no")  // 외래키로 artist와 연결
    private ArtistDto artistDto;
}
