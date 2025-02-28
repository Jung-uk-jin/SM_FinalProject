package com.java.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.java.dto.CommentDto;
import com.java.dto.CommunityDto;
import com.java.dto.MemberDto;
import com.java.repository.CMRepository;
import com.java.repository.CRepository;
import com.java.repository.MRepository;

import jakarta.transaction.Transactional;

@Service
public class MServiceImpl implements MService{

	@Autowired MRepository mRepository;
	@Autowired CRepository cRepository;
	@Autowired CMRepository cmRepository;

//
//	@Override
//	public MemberDto findByIdAndPw(String id, String pw) {
//		
//		MemberDto memberDto = mRepository.findByIdAndPw(id,pw);
//		return memberDto;
//	}

	// 전체 회원정보 출력
	@Override
	public List<MemberDto> findAll() {
		List<MemberDto> list = mRepository.findAll(); // findById : 한개 가져올떄
		
	    for (MemberDto member : list) {
	        long communityCount = cRepository.countCommunityByMemberNickname(member.getMember_nickname());
	        long commentCount = cmRepository.countCommentByMemberNickname(member.getMember_nickname());

	        member.setCommunityCnt((int) communityCount);
	        member.setCommentCnt((int) commentCount);
	    }
		return list;
	}

	// 회원정보 열기
	@Override
	public MemberDto findByNickname(String nickname) {
		
		MemberDto memberDto = mRepository.findByNickname(nickname);
		return memberDto;
	}
	
	// 회원정보 수정
	@Transactional
	@Override
	public void save(MemberDto mdto) {
		mRepository.save(mdto);
	}
	
	// 회원정보 삭제
	@Override
	public void deleteByMemberNickname(String member_nickname) {
//		mRepository.deleteByMemberNickname(member_nickname);
	    // 1. 해당 멤버를 먼저 조회
	    MemberDto member = mRepository.findByNickname(member_nickname);
		
	    if (member != null) {
	        // 1. 멤버가 작성한 댓글 삭제
	        List<CommentDto> comments = cmRepository.findByNickname(member_nickname);
	        cmRepository.deleteAll(comments);

	        // 2. 멤버가 작성한 커뮤니티 삭제
	        List<CommunityDto> communities = cRepository.findByNickname(member_nickname);
	        cRepository.deleteAll(communities);

	        // 3. 멤버 삭제
	        mRepository.delete(member);
	    } else {
	        throw new RuntimeException("해당 멤버를 찾을 수 없습니다.");
	    }    
	}

}
