package com.together.moviesquare.member.dao;

import javax.websocket.Session;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.together.moviesquare.member.vo.Member;

@Repository("memberDao")
public class MemberDao {
	@Autowired
	private SqlSessionTemplate session; 
	public int idcheck(String id) {
		return session.selectOne("memberMapper.idcheck" ,id);
	}
	public int nickcheck(String nickname) {
		return session.selectOne("memberMapper.nickcheck" ,nickname);
	}
	public int enroll(Member member) {
		System.out.println(member);
		return session.insert("memberMapper.enroll" ,member);
	}

}
