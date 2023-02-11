package com.together.moviesquare.member.service;

import com.together.moviesquare.member.vo.Member;


public interface MemberService {
	//아이디 중복 체크
	public int emailcheck(String email);
	//닉네임 중복 체크
	public int nickcheck(String nickname);
	//회원가입 실행
	public int enroll(Member member);
	//로그인시 아이디 체크
	public Member selectMember(String m_id);
}
