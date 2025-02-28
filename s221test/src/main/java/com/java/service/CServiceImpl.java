package com.java.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.java.dto.CommentDto;
import com.java.dto.CommunityDto;
import com.java.repository.CMRepository;
import com.java.repository.CRepository;

@Service
public class CServiceImpl implements CService {
	
	@Autowired CRepository cRepository;
	@Autowired CMRepository cmRepository;

	@Override
	public List<CommunityDto> findByNickname(String nickname) {
		
		List<CommunityDto> list = cRepository.findByNickname(nickname);
		return list;
	}

	// 게시글 삭제
	@Override
	public void deleteByCommunityNo(int community_no) {
//		cRepository.deleteByCommunityNo(community_no);
	    // 1. 해당 커뮤니티 글을 먼저 조회
	    CommunityDto community = cRepository.findByCommunityNo(community_no);

	    if (community != null) {
	        // 2. 해당 커뮤니티 글과 연관된 댓글 삭제
	        List<CommentDto> comments = cmRepository.findByCommunityNo(community_no);
	        cmRepository.deleteAll(comments);

	        // 3. 커뮤니티 글 삭제
	        cRepository.delete(community);
	    } else {
	        throw new RuntimeException("해당 게시글을 찾을 수 없습니다.");
	    }
		
	}

}
