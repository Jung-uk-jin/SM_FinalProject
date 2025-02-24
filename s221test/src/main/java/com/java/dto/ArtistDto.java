package com.java.dto;
import java.util.List;

import org.hibernate.annotations.DynamicInsert;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
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
	@Column(nullable = false, length=30)
	private String artist_group_name;
	@Column(nullable = false, length=30)
	private String artist_member_name;
	@Column(nullable = false, length=100)
	private String artist_group_image;
	@Column(nullable = false, length=100)
	private String artist_member_image;
	
	// shop의 그룹명과 연결
	@OneToMany(mappedBy = "shop_group_name")  
	private List<ShopDto> shop; 
}
