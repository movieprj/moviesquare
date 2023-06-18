package com.together.moviesquare.views.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("viewsDao")
public class ViewsDao {
	@Autowired
	private SqlSessionTemplate session;

	public int insertKeyword(String keyword) {
		return session.insert("viewsMapper.insertKeyword", keyword);
	}

	public int insertMovieNonMemViews(String keyword) {
		return session.insert("viewsMapper.insertMovieNonMemViews", keyword);
	}

	public int insertMovieMemViews(Map<String, String> map) {
		return session.insert("viewsMapper.insertMovieMemViews", map);
	}
}
