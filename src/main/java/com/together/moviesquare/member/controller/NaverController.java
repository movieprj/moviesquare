package com.together.moviesquare.member.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.together.moviesquare.member.service.KakaologinService;
import com.together.moviesquare.member.vo.KaKao;
import com.together.moviesquare.member.vo.NaverLoginResponse;
import com.together.moviesquare.member.vo.NaverUserResponse;

import lombok.extern.java.Log;

@Log
@Controller
public class NaverController {
	
	@Autowired
	private KakaologinService service;
	
	
	private String clientId = "U2cRDMBIt9eQltvclVWy";
	private String clientSecret="SF3dH9ItEb";
	@GetMapping("naverLogin.do")
	public void getNaverAuthUrl(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String url = "https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=U2cRDMBIt9eQltvclVWy&state=STATE_STRING&redirect_uri=http://localhost:8080/moviesquare/naverLoginCallback.do";
		try {
            response.sendRedirect(url);
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	
	
	@GetMapping("naverLoginCallback.do")
	public String naverCallback(HttpServletRequest request,
            @RequestParam(value = "code") String authCode, @RequestParam(value = "state") String state,
            HttpServletResponse response,HttpSession loginSession, SessionStatus status) throws Exception{
		
		UriComponents uriComponents = UriComponentsBuilder
                .fromUriString("https://nid.naver.com/oauth2.0/token")
                .queryParam("grant_type", "authorization_code")
                .queryParam("client_id", clientId)
                .queryParam("client_secret", clientSecret)
                .queryParam("code", authCode)
                .queryParam("state", URLEncoder.encode(state, "UTF-8"))
                .build();
		//엑세스 토큰 가져오기
		StringBuffer res = new StringBuffer();
		try {
			URL url = uriComponents.toUri().toURL();
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			
			int responseCode = con.getResponseCode();
			BufferedReader br;

            if(responseCode==200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }

            String inputLine;
            
            while ((inputLine = br.readLine()) != null) {
                res.append(inputLine);
            }

            br.close();
			
		} catch (Exception e) {
            e.printStackTrace();
            log.info("토큰 획득중 오류발생");
            return null;
        }
        	
		ObjectMapper mapper = new ObjectMapper();
		NaverLoginResponse token = mapper.readValue(res.toString(), NaverLoginResponse.class);
		
		//엑세스 토큰으로 유저정보 가져오기
		StringBuffer res2 = new StringBuffer();
		try {
            String accessToken = token.getAccess_token();
            String tokenType = token.getToken_type();

            URL url = new URI("https://openapi.naver.com/v1/nid/me").toURL();
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("Authorization", tokenType + " " + accessToken);

            int responseCode = con.getResponseCode();
            BufferedReader br;

            if(responseCode==200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }

            String inputLine;
            while ((inputLine = br.readLine()) != null) {
                res2.append(inputLine);
            }

            br.close();
        } catch (Exception e) {
            e.printStackTrace();
            log.info("유저정보 획득중 에러발생");
            return null;
        }

		NaverUserResponse naverUser = mapper.readValue(res2.toString(), NaverUserResponse.class);
		
		KaKao member = new KaKao(naverUser.getResponse().getNickname(), naverUser.getResponse().getGender(), "N", "Y", naverUser.getResponse().getId(), naverUser.getResponse().getAge().replace("-", "~"));
        KaKao loginMember = service.selectNaverMember(member.getKakaoid());
		log.info("login정보 : "+ loginMember);
		if(loginMember ==null && service.enrollNaver(member)>0) {
			log.info("회원가입 성공");
			loginMember = service.selectNaverMember(member.getKakaoid());
		}else {
			log.info("회원가입 실패");
		}
		
		log.info("login정보 : "+ loginMember);
		loginSession.setAttribute("loginMember", loginMember);
		status.setComplete();
		
		return "../../index";
	}
}
