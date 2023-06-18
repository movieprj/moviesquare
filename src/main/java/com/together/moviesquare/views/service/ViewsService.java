package com.together.moviesquare.views.service;

import java.util.Map;

public interface ViewsService {

	int insertKeyword(String keyword);

	int insertMovieNonMemViews(String keyword);

	int insertMovieMemViews(Map<String, String> map);

}
