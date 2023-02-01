package com.together.moviesquare.member.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.together.moviesquare.member.service.MemberService;
import com.together.moviesquare.member.vo.Member;

@Controller
public class MemberController {
	private Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private MemberService service;
	
	@RequestMapping("enrollPage.do")
	public String enrollPageMove() {
		return "member/enroll";
	}
	//id 중복 확인 ajax
	@RequestMapping(value = "idcheck.do", method=RequestMethod.POST)
	public void idcheckFunc(@RequestParam("m_id") String id, HttpServletResponse response) throws Exception {
		int result = service.idcheck(id);
		String returnValue = "";
		if(result==0) {
			returnValue = "ok";//"아이디 생성이 가능합니다.";
		}else {
			returnValue = "no";//"아이디가 중복 되었습니다.";
		}
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.append(returnValue);
		out.flush();
		out.close();
	}
	//닉네임 중복 확인 ajax
	@RequestMapping(value = "nickcheck.do", method=RequestMethod.POST)
	public void nickcheck(@RequestParam("m_nickname") String nickname, HttpServletResponse response) throws Exception {
		int result = service.nickcheck(nickname);
		String returnValue = "";
		if(result==0) {
			returnValue = "ok";//"닉네임 생성이 가능합니다.";
		}else {
			returnValue = "no";//"닉네임이 중복 되었습니다.";
		}
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.append(returnValue);
		out.flush();
		out.close();
	}
	//회원가입 성공
	@RequestMapping(value = "memenroll.do", method=RequestMethod.POST)
	public String memberEnroll(Member member) {
		if(service.enroll(member)>0) {
			logger.info("회원가입 성공");
		}else {
			logger.info("회원가입 실패");
		}
		return "common/main";
	}
	
}
