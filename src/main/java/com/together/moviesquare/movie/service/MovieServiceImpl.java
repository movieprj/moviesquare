package com.together.moviesquare.movie.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.together.moviesquare.common.Paging;
import com.together.moviesquare.common.SearchPaging;
import com.together.moviesquare.movie.dao.MovieDao;
import com.together.moviesquare.movie.vo.Movie;
import com.together.moviesquare.movie.vo.MovieResult;

@Service("movieService")
public class MovieServiceImpl implements MovieService{
	@Autowired
	private MovieDao dao;

	@Override
	public int selectListCount() {
		return dao.selectListCount();
	}

	@Override
	public ArrayList<Movie> selectList(Paging paging) {
		return dao.selectList(paging);
	}

	@Override
	public int selectSearchListCount(String keyword) {
		return dao.selectSearchListCount(keyword);
	}

	@Override
	public ArrayList<Movie> selectSearchList(SearchPaging searchpaging) {
		return dao.selectSearchList(searchpaging);
	}

	@Override
	public int mergeIntoMovieList(List<MovieResult> mList) {
		return dao.mergeIntoMovieList(mList);
	}

	
}
