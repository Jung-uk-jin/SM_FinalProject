package com.java.dto;

import java.sql.Timestamp;

import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
public class BoardDto {
	@Id
	private int bno;
	@Column(length=30)
	private String btitle;
	@Column(length=3000)
	private String bcontent;
	@Column(length=30)
	private String id;
	@ColumnDefault("0")
	private int bgroup; //답변달기 그룹핑
	@ColumnDefault("0")
	private int bstep;	//답변달기 순서
	@ColumnDefault("0")
	private int bindent; // 답변달기 들여쓰기
	@ColumnDefault("0")
	private int bhit;
	@UpdateTimestamp
	private Timestamp bdate;
	@Column(nullable=true,length=100)
	private String bfile;
}
