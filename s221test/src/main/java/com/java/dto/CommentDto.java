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
public class CommentDto {
		
		@Id
	    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "comment_seq")
	    @SequenceGenerator(name = "comment_seq", sequenceName = "comment_seq", allocationSize = 1)
		private int comment_no;
		@Column(length=1000)
		private String comment_content;
		@CreationTimestamp
		private Timestamp comment_date;
		@Column(length=100)
		private String comment_file; 			// 이미지		
		
	    @ManyToOne
	    @JoinColumn(name = "community_no")  // 외래키로 community와 연결
	    private CommunityDto communityDto;
	    
	    @ManyToOne
	    @JoinColumn(name = "member_nickname")  // 외래키로 Member와 연결
	    private MemberDto memberDto;
	    

}
