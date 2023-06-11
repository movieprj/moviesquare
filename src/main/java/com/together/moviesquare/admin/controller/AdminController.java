package com.together.moviesquare.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.together.moviesquare.admin.service.AdminService;
import com.together.moviesquare.member.service.MemberService;
import com.together.moviesquare.member.vo.Member;

import lombok.extern.java.Log;

@Log
@Controller
public class AdminController {
	
	@Autowired
	private AdminService service;
	
	@Autowired
	private MemberService memberservice;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	//관리자 페이지 입장시 로그인 화면으로
	@RequestMapping("admin")
	public String adminLoginView(Model model) {
		model.addAttribute("admin", "admin");
		return "member/login";
	}
	
	//관리자 로그아웃
	@RequestMapping("adminlogout.do")
	public String adminLogout(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
		if(session != null) {
			session.invalidate();
		}
		model.addAttribute("admin", "admin");
		return "member/login";
	}
	
	//관리자 로그인 성공하면 관리자 메인 페이지로 이동
	@RequestMapping("adminLogin.do")
	public String adminMainView(Member member, HttpSession loginSession, SessionStatus status, RedirectAttributes redirectAttributes) {
		Member loginMember = memberservice.selectMember(member.getM_email());
		log.info("login정보 : "+ loginMember);
		if(loginMember!=null && this.bcryptPasswordEncoder.matches(member.getM_pw(), loginMember.getM_pw())) {
			loginSession.setAttribute("loginMember", loginMember);
			status.setComplete();
			return "common/adminMain";
		}else {
			redirectAttributes.addFlashAttribute("admin", "admin");
			redirectAttributes.addFlashAttribute("adminFail","잘못된 비밀번호입니다. 다시 확인해주세요");
			return "redirect:admin";
		}
	}
	
	@RequestMapping("adminMem.do")
	public String memberManagement(Model model) {
		List<Member> member = service.selAllMember();
		if(member!=null) {
			model.addAttribute("member", member);
			log.info(member.toString());
		}
		return "admin/managerment";
	}
	
	//로그인 제한/가능 변경 처리용
	@RequestMapping(value="loginok.do", method=RequestMethod.POST)
	public ResponseEntity<String> changeLoginOKMethod(@RequestBody String param)  {
		try {
			JSONParser jparser = new JSONParser();
			JSONObject json = (JSONObject)jparser.parse(param);
			Member member =new Member();
			member.setM_nickname((String)json.get("m_id"));
			member.setLogin_ok((String)json.get("login_ok"));
			log.info("내용 : " + member);
			if(service.updateLoginok(member) > 0) {
				return new ResponseEntity<String>("success", HttpStatus.OK);
			} else {
				return new ResponseEntity<String>("failed", HttpStatus.REQUEST_TIMEOUT);
			}
		}catch(Exception e) {
			log.info(e.toString());
		}
		return new ResponseEntity<String>("failed", HttpStatus.REQUEST_TIMEOUT);
	}
}
