package com.together.moviesquare.movie.dao;

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
@Repository("movieDao")
public class MovieDao {
	@Autowired
	private SqlSessionTemplate session;

	public int selectListCount() {
		return session.selectOne("movieMapper.selectListCount");
	}

	public ArrayList<Movie> selectList(Paging paging) {
		List<Movie> list = null;
		try {
			list = session.selectList("movieMapper.selectList", paging);
		}catch(Exception e) {
			log.info(e.toString());
			return null;
		}
		return (ArrayList<Movie>)list;
	}

	public int selectSearchListCount(String keyword) {
		return session.selectOne("movieMapper.selectSearchListCount",keyword);
	}

	public ArrayList<Movie> selectSearchList(SearchPaging searchpaging) {
		List<Movie> list = null;
		try {
			list = session.selectList("movieMapper.selectSearchList", searchpaging);
		}catch(Exception e) {
			log.info(e.toString());
			return null;
		}
		return (ArrayList<Movie>)list;
	} 
	
}
