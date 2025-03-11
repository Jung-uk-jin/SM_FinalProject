package com.java.dto;

import java.sql.Timestamp;
import java.util.List;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
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
public class CommunityDto {
	
	@Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "community_seq")
    @SequenceGenerator(name = "community_seq", sequenceName = "community_seq", allocationSize = 1)
	private int community_no;				// 글 번호
	
	@Column(nullable = false, length=1000)
	private String community_content; 		// 내용
	@UpdateTimestamp
	private Timestamp community_date; 		// 등록일
	@Column(length=100)
	private String community_file; 			// 이미지
	
	@OneToMany(mappedBy = "community_no")  
	private List<CommentDto> comment;  
	
    @ManyToOne
    @JoinColumn(name = "member_nickname")  // 외래키로 Member와 연결
    private MemberDto community_name;
}