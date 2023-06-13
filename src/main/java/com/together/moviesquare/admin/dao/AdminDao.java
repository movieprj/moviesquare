package com.together.moviesquare.admin.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.together.moviesquare.member.vo.Member;
import com.together.moviesquare.movie.vo.Movie;

import lombok.extern.java.Log;

@Log
@Repository("adminDao")
public class AdminDao {
	@Autowired
	private SqlSessionTemplate session;

	public List<Member> selAllMember() {
		List<Member> mem = null;
		try {
			mem = session.selectList("adminMapper.memAll");
		}catch(Exception e) {
			log.info(e.toString());
			return null;
		}
		return mem;
	}

	public int updateLoginok(Member member) {
		int result = 0;
		try {
			result = session.update("adminMapper.updateLoginOK", member);
		}catch(Exception e) {
			return -1;
		}finally {
			return result;
		}
	}

	public int updateCost(Movie movie) {
		int result = 0;
		try {
			result = session.update("adminMapper.updateCost", movie);
		}catch(Exception e) {
			return -1;
		}finally {
			return result;
		}
	} 
}
