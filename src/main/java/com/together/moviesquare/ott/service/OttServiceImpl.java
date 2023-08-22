package com.together.moviesquare.ott.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.together.moviesquare.ott.dao.OttDao;
import com.together.moviesquare.ott.vo.Ott;

@Service("ottService")
public class OttServiceImpl implements OttService{
	
	@Autowired
	private OttDao ottDao;
	
	@Override
	public ArrayList<Ott> selectAll() {
		return ottDao.selectList();	
	}
}
