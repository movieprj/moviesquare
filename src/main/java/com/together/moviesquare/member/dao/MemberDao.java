package com.together.moviesquare.member.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.together.moviesquare.member.vo.KaKao;
import com.together.moviesquare.member.vo.Member;

@Repository("memberDao")
public class MemberDao {
	@Autowired
	private SqlSessionTemplate session; 
	public int mailcheck(String email) {
		return session.selectOne("memberMapper.mailcheck" ,email);
	}
	public int nickcheck(String nickname) {
		return session.selectOne("memberMapper.nickcheck" ,nickname);
	}
	public int enroll(Member member) {
		try {
		return session.insert("memberMapper.enroll" ,member);
		}catch(Exception e) {
			return -1;
		}
	}
	public Member selectMember(String m_id) {
		return session.selectOne("memberMapper.selectMember", m_id);
	}
	//kakaoid는 소셜아이디이므로 멤버 테이블의 SOCAL_ID 컬럼에 넣어줌
	public int enroll(KaKao member) {
		try {
			return session.insert("memberMapper.enrollKaKao" ,member);
		}catch(Exception e) {
			System.out.println("카카오 회원가입 오류 : "+e.toString());
			return -1;
		}
	}
	//kakaoid는 소셜아이디이므로 멤버 테이블의 SOCAL_ID 컬럼에 넣어줌
	public KaKao selectKakaoMember(String kakaoid) {
		try {
			return session.selectOne("memberMapper.selectKakaoMember", kakaoid);
		}catch(Exception e) {
			System.out.println("카카오 회원 정보 호출 오류 : "+e.toString());
			return null;
		}
	}
	//google
	public int enrollGoogle(KaKao member) {
		try {
			return session.insert("memberMapper.enrollGoogle" ,member);
		}catch(Exception e) {
			System.out.println("구글 회원가입 오류 : "+e.toString());
			return -1;
		}
	}
	public KaKao selectGoogleMember(String googleid) {
		try {
			return session.selectOne("memberMapper.selectKakaoMember", googleid);
		}catch(Exception e) {
			System.out.println("구글 회원 정보 호출 오류 : "+e.toString());
			return null;
		}
	}
	public int enrollNaver(KaKao member) {
		try {
			return session.insert("memberMapper.enrollKaKao" ,member);
		}catch(Exception e) {
			System.out.println("네이버 회원가입 오류 : "+e.toString());
			return -1;
		}
	}
	
	public KaKao selectNaverMember(String googleid) {
		try {
			return session.selectOne("memberMapper.selectKakaoMember", googleid);
		}catch(Exception e) {
			System.out.println("네이버 회원 정보 호출 오류 : "+e.toString());
			return null;
		}
	}
}
