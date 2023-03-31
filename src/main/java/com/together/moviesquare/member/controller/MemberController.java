package com.together.moviesquare.member.controller;

import java.io.PrintWriter;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
	public void idcheckFunc(@RequestParam("m_email") String mail, HttpServletResponse response) throws Exception {
		int result = service.mailcheck(mail);
		String returnValue = "";
		logger.info("결과 : " + result);
		if(result==0) {
			returnValue = mailService.mailMessage(mail);//"아이디 생성이 가능합니다.";
			logger.info("코드 : " + returnValue);
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
		member = setAgecode(member);
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
	
	
	
	
	//연령대
	private Member setAgecode(Member member) {
		int year = Integer.parseInt(member.getM_birthday().substring(0,4));
		Calendar current = Calendar.getInstance();
        int currentYear  = current.get(Calendar.YEAR);
        int age = currentYear-year+1;
        if(age<=9)
        	member.setAgecode("A0");
        else if(age<=19)
        	member.setAgecode("A1");
        else if(age<=29)
        	member.setAgecode("A2");
        else if(age<=39)
        	member.setAgecode("A3");
        else if(age<=49)
        	member.setAgecode("A4");
        else if(age<=59)
        	member.setAgecode("A5");
        else if(age<=69)
        	member.setAgecode("A6");
        else if(age<=79)
        	member.setAgecode("A7");
        else if(age<=89)
        	member.setAgecode("A8");
        else if(age<=99)
        	member.setAgecode("A9");
		return member;
	}
}
