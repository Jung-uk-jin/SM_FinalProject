package com.java.dto;

import org.hibernate.annotations.DynamicInsert;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
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
public class ArtistMemberDto {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int artistmember_no;
	@Column(length = 30)
	private String artistmember_name;
	@Column(length = 100)
	private String artistmember_image;
	
	@ManyToOne
	@JoinColumn(name="artist_no")
	private ArtistDto artistDto;
}
