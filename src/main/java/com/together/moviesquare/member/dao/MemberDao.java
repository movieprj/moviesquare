package com.together.moviesquare.member.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.together.moviesquare.member.vo.KaKao;
import com.together.moviesquare.member.vo.Member;

import lombok.extern.java.Log;

@Log
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
			log.info("Member 회원가입");
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
			log.info("카카오 회원가입");
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
	public KaKao selectSocalloginOk(String id) {
		try {
			return session.selectOne("memberMapper.selectSocalloginOk", id);
		}catch(Exception e) {
			System.out.println("소셜 아이디 정보 호출 오류 : "+e.toString());
			return null;
		}
	}
	public ArrayList<Member> selectByMail(Member mem) {
		try {
			List<Member> list = session.selectList("memberMapper.selectMail", mem);
			return (ArrayList<Member>)list;
		}catch(Exception e) {
			System.out.println("이메일찾기 오류 : "+e.toString());
			return null;
		}
	}
	public Member findInfo(Member mem) {
		try {
			return session.selectOne("memberMapper.findInfo", mem);
		}catch(Exception e) {
			System.out.println("비밀번호찾기 정보 오류 : "+e.toString());
			return null;
		}
	}
	public int changePwd(Member mem) {
		return session.update("memberMapper.changePwd", mem);
	}
}
