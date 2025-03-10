package com.java.repository;

import com.java.dto.AiArtistDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AiArtistRepository extends JpaRepository<AiArtistDto, Long> {
    // 기본적인 CRUD 메소드들은 JpaRepository에 이미 구현되어 있습니다.
    // 추가적인 쿼리가 필요하면 여기에 커스텀 메소드를 추가할 수 있습니다.
}
