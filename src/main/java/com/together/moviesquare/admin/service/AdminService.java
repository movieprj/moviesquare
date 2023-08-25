package com.together.moviesquare.admin.service;

import java.util.ArrayList;
import java.util.List;

import com.together.moviesquare.common.Paging;
import com.together.moviesquare.common.SearchPaging;
import com.together.moviesquare.member.vo.Member;
import com.together.moviesquare.movie.vo.MovieOld;

public interface AdminService {
	
	// 로그인 ok 수정
	public int updateLoginok(Member member);
	
	// 제작비 수정(update)
	public int updateCost(MovieOld movie);
	
	//기본 회원관리 페이징 처리용 count
	public int selectListCount();
	//기본 회원관리 페이징 처리
	public ArrayList<Member> selectList(Paging paging);
	//닉네임 검색 회원관리 페이징 처리용 count
	public int userIDSearchCount(String keyword);
	//닉네임 검색 회원관리 페이징 처리
	public ArrayList<Member> userIDSearch(SearchPaging searchpaging);

}
