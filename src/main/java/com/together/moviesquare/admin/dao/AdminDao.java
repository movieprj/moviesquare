package com.together.moviesquare.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.together.moviesquare.common.Paging;
import com.together.moviesquare.common.SearchPaging;
import com.together.moviesquare.member.vo.Member;
import com.together.moviesquare.movie.vo.Movie;

import lombok.extern.java.Log;

@Log
@Repository("adminDao")
public class AdminDao {
	@Autowired
	private SqlSessionTemplate session;

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
	
	public int selectListCount() {
		return session.selectOne("adminMapper.getListCount");
	}

	public ArrayList<Member> selectList(Paging paging) {
		List<Member> list = null;
		try {
			list = session.selectList("adminMapper.selectList", paging);
		}catch(Exception e) {
			log.info(e.toString());
			return null;
		}
		return (ArrayList<Member>)list;
	}

	public int userIDSearchCount(String keyword) {
		return session.selectOne("adminMapper.userIDSearchCount",keyword);
	}

	public ArrayList<Member> userIDSearch(SearchPaging searchpaging) {
		List<Member> list = null;
		try {
			list = session.selectList("adminMapper.userIDSearch", searchpaging);
		}catch(Exception e) {
			log.info(e.toString());
			return null;
		}
		return (ArrayList<Member>)list;
	} 
}
