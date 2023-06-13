package com.together.moviesquare.movie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.together.moviesquare.movie.dao.MovieDao;
import com.together.moviesquare.movie.vo.Movie;

@Service("movieService")
public class MovieServiceImpl implements MovieService{
	@Autowired
	private MovieDao dao;

	@Override
	public List<Movie> selAllMovie() {
		return dao.selAllMovie();
	}
	
	
}
