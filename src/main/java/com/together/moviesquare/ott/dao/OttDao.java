package com.together.moviesquare.ott.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.together.moviesquare.ott.vo.Ott;

@Repository("ottDao")
public class OttDao {
	
	@Autowired
	private SqlSessionTemplate session;

	public ArrayList<Ott> selectList(){
		List<Ott> list = session.selectList("ottMapper.selectAll");
		return (ArrayList<Ott>)list;
	}
	
}
