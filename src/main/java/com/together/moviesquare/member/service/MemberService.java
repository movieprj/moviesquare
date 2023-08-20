package com.together.moviesquare.member.service;

import java.util.ArrayList;

import com.together.moviesquare.member.vo.Member;


public interface MemberService {
	//아이디 중복 체크
	public int mailcheck(String id);
	//닉네임 중복 체크
	public int nickcheck(String nickname);
	//회원가입 실행
	public int enroll(Member member);
	//로그인시 아이디 체크
	public Member selectMember(String m_id);
	//아이디 찾기시 이름, 생년월일로 찾기
	public ArrayList<Member> selectByMail(Member mem);
	//비밀번호 찾기 시 이메일, 이름, 생년월일로 찾기
	public Member findInfo(Member mem);
	//비밀번호 변경 ajax
	public int changPwd(Member mem);
}
