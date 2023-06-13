package com.together.moviesquare.admin.service;

import java.util.List;

import com.together.moviesquare.member.vo.Member;
import com.together.moviesquare.movie.vo.Movie;

public interface AdminService {
	
	// 멤버관리 전체 목록
	public List<Member> selAllMember();
	
	// 로그인 ok 수정
	public int updateLoginok(Member member);
	
	// 제작비 수정(update)
	public int updateCost(Movie movie);

}
