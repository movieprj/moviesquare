package com.together.moviesquare.member.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.together.moviesquare.member.dao.MemberDao;
import com.together.moviesquare.member.vo.Member;

@Service("memberService")
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDao dao;
	
	@Override
	public int mailcheck(String id) {
		return dao.mailcheck(id);
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

	@Override
	public ArrayList<Member> selectByMail(Member mem) {
		return dao.selectByMail(mem);
	}

	@Override
	public Member findInfo(Member mem) {
		return dao.findInfo(mem);
	}

	@Override
	public int changPwd(Member mem) {
		return dao.changePwd(mem);
	}

}
