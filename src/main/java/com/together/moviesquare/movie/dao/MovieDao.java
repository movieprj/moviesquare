package com.together.moviesquare.movie.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.together.moviesquare.movie.vo.Movie;

import lombok.extern.java.Log;

@Log
@Repository("movieDao")
public class MovieDao {
	@Autowired
	private SqlSessionTemplate session; 
	
	//영화 목록 전체 조회
	public List<Movie> selAllMovie() {
		return session.selectList("movieMapper.selAllMovie");
	}
}
