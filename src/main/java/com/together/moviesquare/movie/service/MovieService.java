package com.together.moviesquare.movie.service;

import java.util.ArrayList;
import java.util.List;

import com.together.moviesquare.common.Paging;
import com.together.moviesquare.common.SearchPaging;
import com.together.moviesquare.movie.vo.Movie;
import com.together.moviesquare.movie.vo.MovieResult;

public interface MovieService {
	//영화 제작비 입력 페이징 전체 개수
	public int selectListCount();
	//영화 제작비 입력 페이징 처리
	public ArrayList<Movie> selectList(Paging paging);

	//영화 제작비 페이지 검색 기능
	public int selectSearchListCount(String keyword);
	public ArrayList<Movie> selectSearchList(SearchPaging searchpaging);
	public int mergeIntoMovieList(List<MovieResult> mList);

}
