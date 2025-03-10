package com.java.dto;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
@Entity
public class AiArtistDto {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)  // 기본 키가 자동 증가하도록 설정
    @Column(name = "artist_id")  // 컬럼명 지정
    private Long id;

    @Column(name = "name", nullable = false)  // null을 허용하지 않음
    private String name;

    @Column(name = "korean_name")
    private String korean_name;

    @Column(name = "score")
    private double score;

    @Column(name = "debut")
    private String debut;

    @Column(name = "gender")
    private String gender;

    @Column(name = "company")
    private String company;
    
    @Column(name = "imagePath")  // 컬럼 이름이 정확히 맞는지 확인
    private String imagePath;

}
