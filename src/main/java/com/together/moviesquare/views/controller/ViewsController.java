package com.together.moviesquare.views.controller;


import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.together.moviesquare.member.vo.KaKao;
import com.together.moviesquare.views.service.ViewsService;

import lombok.extern.java.Log;

@Log
@Controller
public class ViewsController {

	@Autowired
	ViewsService viewsService;
	
	@PostMapping("insertViews.do")
	@ResponseBody
	public String insertViewsMethod(HttpSession loginSession,
			@RequestParam(required = false, name = "keyword") String keyword) {
		KaKao member = (KaKao) loginSession.getAttribute("loginMember");
		
		log.info("입력한 검색 키워드" + keyword);
		if (member == null) {
			log.info("비로그인 키워드, 조회수 입력");
			viewsService.insertKeyword(keyword);
			viewsService.insertMovieNonMemViews(keyword);
			
		} else {
			log.info(member.toString() +" : 로그인 키워드, 조회수 입력");
			viewsService.insertKeyword(keyword);
			viewsService.insertMovieMemViews(new HashMap<String, String>(){{
					put("keyword", keyword);
					put("ageCd", member.getAgecode());
					put("gender", member.getM_gender());
			}});
		}
		
		return "성공";
		
	}
}
