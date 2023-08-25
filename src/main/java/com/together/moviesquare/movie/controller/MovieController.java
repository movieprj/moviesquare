package com.together.moviesquare.movie.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.together.moviesquare.movie.service.MovieService;
import com.together.moviesquare.movie.vo.Movie;

@Controller
public class MovieController {
	@Autowired
	MovieService movieService;
	
	
	
	@GetMapping(value = "getMovieData.do/{Id}", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String getMovieDataMethod(@PathVariable("Id") String Id) {
		Gson gson = new Gson();
		
		Movie movie = movieService.selectMovieById(Id);

		return gson.toJson(movie);
	}
}
