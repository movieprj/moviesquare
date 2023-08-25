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
import com.together.moviesquare.movie.vo.MovieOld;
import com.together.moviesquare.movie.vo.MovieResult;

import lombok.extern.java.Log;

@Log
@Repository("movieDao")
public class MovieDao {
	@Autowired
	private SqlSessionTemplate session;

	public int selectListCount() {
		return session.selectOne("movieMapper.selectListCount");
	}

	public ArrayList<MovieOld> selectList(Paging paging) {
		List<MovieOld> list = null;
		try {
			list = session.selectList("movieMapper.selectList", paging);
		}catch(Exception e) {
			log.info(e.toString());
			return null;
		}
		return (ArrayList<MovieOld>)list;
	}

	public int selectSearchListCount(String keyword) {
		return session.selectOne("movieMapper.selectSearchListCount",keyword);
	}

	public ArrayList<MovieOld> selectSearchList(SearchPaging searchpaging) {
		List<MovieOld> list = null;
		try {
			list = session.selectList("movieMapper.selectSearchList", searchpaging);
		}catch(Exception e) {
			log.info(e.toString());
			return null;
		}
		return (ArrayList<MovieOld>)list;
	} 
	
	public int mergeIntoMovieList(List<MovieResult> mList) {
		return session.insert("movieMapper.mergeIntoMovieList",mList);
	}

	public Movie selectMovieById(String movieId) {
		return session.selectOne("movieMapper.selectMovieById",movieId);
	}
	
	
}
