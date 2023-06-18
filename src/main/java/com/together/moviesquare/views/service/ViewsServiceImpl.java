package com.together.moviesquare.views.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.together.moviesquare.views.dao.ViewsDao;

@Service("viewsService")
public class ViewsServiceImpl implements ViewsService {

	@Autowired
	ViewsDao viewsDao;
	
	@Override
	public int insertKeyword(String keyword) {
		return viewsDao.insertKeyword(keyword);
	}

	@Override
	public int insertMovieNonMemViews(String keyword) {
		return viewsDao.insertMovieNonMemViews(keyword);
		
	}

	@Override
	public int insertMovieMemViews(Map<String, String> map) {
		return viewsDao.insertMovieMemViews(map);
	}

}
