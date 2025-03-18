package com.java.dto;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
@Entity
public class NicknameDto {
	
	@Id
	private String nickname_name;
	
	@ManyToOne
	@JoinColumn(name = "member_nickname")
	private MemberDto memberDto;
	
	@ManyToOne
	@JoinColumn(name = "artist_no")
	private ArtistDto artistDto;
	
}