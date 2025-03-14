package com.java.dto;

import org.hibernate.annotations.DynamicInsert;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
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
	private String artist_group_image;
	@Column(length = 100)	
	private String artist_group_logo;
		
}
