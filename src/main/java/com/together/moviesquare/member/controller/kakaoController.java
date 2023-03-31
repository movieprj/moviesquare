package com.together.moviesquare.member.controller;

import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonNode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.together.moviesquare.member.service.KakaologinService;
import com.together.moviesquare.member.service.MemberService;
import com.together.moviesquare.member.vo.KaKao;
import com.together.moviesquare.member.vo.Member;



@Controller
public class kakaoController {
	private static final Logger logger = 
			LoggerFactory.getLogger(kakaoController.class);
	
	@Autowired
	private KakaologinService service;
	
	// 1번 카카오톡에 사용자 코드 받기(jsp의 a태그 href에 경로 있음)
	@RequestMapping(value = "kakaoLogin.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String kakaoLogin(@RequestParam(value = "code", required = false) String code, HttpSession loginSession, SessionStatus status) throws Throwable {
		// 1번
		System.out.println("code:"+code);
		
		JsonNode node = service.getAccessToken(code); // accessToken에 사용자의 로그인한 모든 정보가 들어있음
		JsonNode accessToken = node.get("access_token"); // 사용자의 정보
		JsonNode userInfo = service.getKakaoUserInfo(accessToken);

		// 회원가입시 사용
		//logger.info(node+"노드");
		//logger.info(accessToken+"토큰");
		logger.info(userInfo+"userInfo");
		logger.info(userInfo.get("properties").get("nickname").toString());
		logger.info(userInfo.get("kakao_account").get("gender").toString());
		logger.info(userInfo.get("id").toString());
		logger.info(userInfo.get("kakao_account").get("age_range").toString());
		String nn = userInfo.get("properties").get("nickname").toString();
		String gender = userInfo.get("kakao_account").get("gender").toString();
		String agecode = userInfo.get("kakao_account").get("age_range").toString();
		
		String nick ="";
		for(int i=1;i<nn.length()-1;i++) {
			nick+=nn.charAt(i);
		}
		if(gender.replaceAll("\"", "").equals("male")){
			gender = "M";
		}else {
			gender = "F";
		}
		String age ="";
		for(int i=1;i<agecode.length()-1;i++) {
			age+=agecode.charAt(i);
		}
		
		logger.info(nick+", " + gender + ", " + agecode );
		KaKao member = new KaKao(nick, gender, "N", "Y", userInfo.get("id").toString(), age);
		KaKao loginMember = service.selectMember(member.getKakaoid());
		logger.info("login정보 : "+ loginMember);
		if(loginMember ==null && service.enroll(member)>0) {
			logger.info("회원가입 성공");
			loginMember = service.selectMember(member.getKakaoid());
		}else {
			logger.info("회원가입 실패");
		}
		
		logger.info("login정보 : "+ loginMember);
		loginSession.setAttribute("loginMember", loginMember);
		status.setComplete();
		return "../../index";
	}
}
