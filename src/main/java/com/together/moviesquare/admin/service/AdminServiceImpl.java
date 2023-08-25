package com.together.moviesquare.admin.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.together.moviesquare.admin.dao.AdminDao;
import com.together.moviesquare.common.Paging;
import com.together.moviesquare.common.SearchPaging;
import com.together.moviesquare.member.vo.Member;
import com.together.moviesquare.movie.vo.MovieOld;

@Service("adminService")
public class AdminServiceImpl implements AdminService {
	@Autowired
	private AdminDao dao;
	
	@Override
	public int updateLoginok(Member member) {
		return dao.updateLoginok(member);
	}

	@Override
	public int updateCost(MovieOld movie) {
		return dao.updateCost(movie);
	}
	
	@Override
	public int selectListCount() {
		return dao.selectListCount();
	}

	@Override
	public ArrayList<Member> selectList(Paging paging) {
		return dao.selectList(paging);
	}

	@Override
	public int userIDSearchCount(String keyword) {
		return dao.userIDSearchCount(keyword);
	}

	@Override
	public ArrayList<Member> userIDSearch(SearchPaging searchpaging) {
		return dao.userIDSearch(searchpaging);
	}

}
