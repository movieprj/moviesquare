package com.together.moviesquare.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.together.moviesquare.admin.dao.AdminDao;
import com.together.moviesquare.member.vo.Member;

@Service("adminService")
public class AdminServiceImpl implements AdminService {
	@Autowired
	private AdminDao dao;
	
	@Override
	public List<Member> selAllMember() {
		List<Member> mem = dao.selAllMember();
		return mem;
	}

}
