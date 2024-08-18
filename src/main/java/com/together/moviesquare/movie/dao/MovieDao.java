package com.together.moviesquare.movie.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.together.moviesquare.common.Paging;
import com.together.moviesquare.common.SearchPaging;
import com.together.moviesquare.movie.vo.Movie;
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
	
	public int mergeIntoMovieList(List<MovieResult> mList) {
		return session.insert("movieMapper.mergeIntoMovieList",mList);
	}
	
	public int mergeIntoMovieListOne(MovieResult m) {
		return session.insert("movieMapper.mergeIntoMovieListOne",m);
	}

	public Movie selectMovieById(String movieId) {
		return session.selectOne("movieMapper.selectMovieById",movieId);
	}
}
