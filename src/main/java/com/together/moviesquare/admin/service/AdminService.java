package com.together.moviesquare.admin.service;

import java.util.List;

import com.together.moviesquare.member.vo.Member;

public interface AdminService {

	public List<Member> selAllMember();

	public int updateLoginok(Member member);

}
