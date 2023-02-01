package com.together.moviesquare.member.service;

import com.together.moviesquare.member.vo.Member;


public interface MemberService {
	//아이디 중복 체크
	public int idcheck(String id);
	//닉네임 중복 체크
	public int nickcheck(String nickname);
	public int enroll(Member member);
}
