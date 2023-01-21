package com.together.moviesquare.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.together.moviesquare.member.dao.MemberDao;

@Service("memberService")
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDao dao;
	
	@Override
	public int idcheck(String id) {
		return dao.idcheck(id);
	}

}
