package com.together.moviesquare.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.together.moviesquare.member.dao.MemberDao;
import com.together.moviesquare.member.vo.Member;

@Service("memberService")
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDao dao;
	
	@Override
	public int idcheck(String id) {
		return dao.idcheck(id);
	}

	@Override
	public int nickcheck(String nickname) {
		return dao.nickcheck(nickname);
	}

	@Override
	public int enroll(Member member) {
		return dao.enroll(member);
	}

	@Override
	public Member selectMember(String m_id) {
		return dao.selectMember(m_id);
	}

}
