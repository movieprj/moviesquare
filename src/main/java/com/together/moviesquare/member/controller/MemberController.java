package com.together.moviesquare.member.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;

import com.together.moviesquare.member.service.MemberService;
import com.together.moviesquare.member.vo.Member;

@Controller
public class MemberController {
	private Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private MemberService service;
	
	@Autowired
	private MailSendService mailService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@RequestMapping("enrollPage.do")
	public String enrollPageMove() {
		return "member/enroll";
	}
	//이메일 중복 확인 ajax
	@RequestMapping(value = "emailcheck.do", method=RequestMethod.POST)
	public void idcheckFunc(@RequestParam("m_email") String email, HttpServletResponse response) throws Exception {
		int result = service.emailcheck(email);
		String returnValue = "";
		if(result==0) {
			returnValue = mailService.mailMessage(email);//"아이디 생성이 가능합니다.";
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
	//회원가입 실행
	@RequestMapping(value = "memenroll.do", method=RequestMethod.POST)
	public String memberEnroll(Member member) {
		member.setM_pw(this.bcryptPasswordEncoder.encode(member.getM_pw()));
		if(service.enroll(member)>0) {
			logger.info("회원가입 성공");
		}else {
			logger.info("회원가입 실패");
		}
		return "common/main";
	}
	//로그인
	@RequestMapping(value="loginPage.do")
	public String loginPage() {
		return "member/login"; 
	}
	@RequestMapping(value="login.do", method=RequestMethod.POST)
	public String memberLogin(Member member, HttpSession loginSession, SessionStatus status) {
		Member loginMember = service.selectMember(member.getM_email());
		logger.info("login정보 : "+ loginMember);
		if(loginMember!=null && this.bcryptPasswordEncoder.matches(member.getM_pw(), loginMember.getM_pw())) {
			loginSession.setAttribute("loginMember", loginMember);
			status.setComplete();
		}
		return "../../index";
	}
	//로그아웃
	@RequestMapping("logout.do")
	public String memberlogout(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
		
		if(session != null) {
			session.invalidate();
		}
		return "../../index";
	}
}
