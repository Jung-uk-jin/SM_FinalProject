package com.java.dto;

import org.hibernate.annotations.DynamicInsert;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Lob;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@DynamicInsert
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
public class ArtistDto {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int artist_no;
	@Column(length = 30)
	private String artist_group_name;
	@Column(length = 100)	
	private String artist_cover_image;
	@Column(length = 100)	
	private String artist_logo_image;
	@Column(length = 100)	
	private String artist_group_image;
	@Lob  // 대용량 데이터
	private String artist_desc;
	
	private boolean display; // 관리자페이지 토글
		
}
