package com.together.moviesquare.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.together.moviesquare.admin.dao.AdminDao;
import com.together.moviesquare.member.vo.Member;
import com.together.moviesquare.movie.vo.Movie;

@Service("adminService")
public class AdminServiceImpl implements AdminService {
	@Autowired
	private AdminDao dao;
	
	@Override
	public List<Member> selAllMember() {
		List<Member> mem = dao.selAllMember();
		return mem;
	}

	@Override
	public int updateLoginok(Member member) {
		return dao.updateLoginok(member);
	}

	@Override
	public int updateCost(Movie movie) {
		return dao.updateCost(movie);
	}

}
