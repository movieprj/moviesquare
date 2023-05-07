package com.together.moviesquare.member.controller;

import java.io.IOException;
import java.net.URI;
import java.security.GeneralSecurityException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.services.people.v1.PeopleService;
import com.google.api.services.people.v1.PeopleService.People;
import com.google.api.services.people.v1.PeopleServiceScopes;
import com.together.moviesquare.member.vo.GoogleLoginResponse;
import com.together.moviesquare.member.vo.GoogleOAuthRequest;

import lombok.extern.java.Log;

@Log
@Controller
public class GoogleController {
	
	private String googleRedirectUrl="http://localhost:8080/moviesquare/googleLoginCallback.do";
	private String googleClientId="250001111890-4s4nv1eg36lpffobc25lpfrnntvel0c5.apps.googleusercontent.com";
	private String googleClientSecret="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";
	private String googleAuthUrl="https://oauth2.googleapis.com";
	private String googleLoginUrl="https://accounts.google.com";
	
	private String reqUrl3 = "https://accounts.google.com/o/oauth2/v2/auth?client_id=250001111890-4s4nv1eg36lpffobc25lpfrnntvel0c5.apps.googleusercontent.com&redirect_uri=http://localhost:8080/moviesquare/googleLoginCallback.do&response_type=code&scope=openid%20profile%20email%20https://www.googleapis.com/auth/user.birthday.read%20https://www.googleapis.com/auth/user.gender.read";
	
	private String api="AIzaSyDATQSrG3fV8ocsFVvU086gu9ssiWVIjwM";
	
	
	
	
	@ResponseBody
	@GetMapping("googleLogin.do")
	public ResponseEntity<?> getGoogleAuthUrl(HttpServletRequest request) throws Exception {

		String reqUrl = "https://accounts.google.com/o/oauth2/v2/auth?client_id=250001111890-4s4nv1eg36lpffobc25lpfrnntvel0c5.apps.googleusercontent.com&redirect_uri=http://localhost:8080/moviesquare/googleLoginCallback.do&response_type=code&scope=openid%20profile%20email%20https://www.googleapis.com/auth/user.birthday.read%20https://www.googleapis.com/auth/user.gender.read";
		
		log.info("myLog-LoginUrl : {}");
		log.info("myLog-ClientId : {}");
		log.info("myLog-RedirectUrl : {}");
		
		HttpHeaders headers = new HttpHeaders();
		headers.setLocation(URI.create(reqUrl));

		// 1.reqUrl 구글로그인 창을 띄우고, 로그인 후 /login/oauth_google_check 으로 리다이렉션하게 한다.
		return new ResponseEntity<>(headers, HttpStatus.MOVED_PERMANENTLY);
	}
	
	@ResponseBody
	@GetMapping("googleLogin2.do")
	public ResponseEntity<?> getGoogleAuthUrl2(HttpServletRequest request) throws Exception {

		String reqUrl = "https://accounts.google.com/o/oauth2/v2/auth?client_id=250001111890-4s4nv1eg36lpffobc25lpfrnntvel0c5.apps.googleusercontent.com&redirect_uri=http://localhost:8080/moviesquare/googleLoginCallback.do&response_type=code&scope=openid%20profile%20email%20https://www.googleapis.com/auth/user.birthday.read%20https://www.googleapis.com/auth/user.gender.read";
		
		log.info("myLog-LoginUrl : {}");
		log.info("myLog-ClientId : {}");
		log.info("myLog-RedirectUrl : {}");
		
		HttpHeaders headers = new HttpHeaders();
		headers.setLocation(URI.create(reqUrl));

		// 1.reqUrl 구글로그인 창을 띄우고, 로그인 후 /login/oauth_google_check 으로 리다이렉션하게 한다.
		return new ResponseEntity<>(headers, HttpStatus.MOVED_PERMANENTLY);
	}
    // 구글에서 리다이렉션
	
	private static final JsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance();
	private static final List<String> SCOPES = Arrays.asList(PeopleServiceScopes.CONTACTS_READONLY);
    
	@ResponseBody
    @GetMapping(value = "googleLoginCallback.do")
    public String oauth_google_check(HttpServletRequest request,
                                     @RequestParam(value = "code") String authCode,
                                     HttpServletResponse response) throws Exception{

        //2.구글에 등록된 레드망고 설정정보를 보내어 약속된 토큰을 받위한 객체 생성
        GoogleOAuthRequest googleOAuthRequest = GoogleOAuthRequest
                .builder()
                .clientId(googleClientId)
                .clientSecret(googleClientSecret)
                .code(authCode)
                .redirectUri(googleRedirectUrl)
                .grantType("authorization_code")
                .build();

        RestTemplate restTemplate = new RestTemplate();

        //3.토큰요청을 한다.
        ResponseEntity<GoogleLoginResponse> apiResponse = restTemplate.postForEntity(googleAuthUrl + "/token", googleOAuthRequest, GoogleLoginResponse.class);
        //4.받은 토큰을 토큰객체에 저장
        GoogleLoginResponse googleLoginResponse = apiResponse.getBody();

        log.info("responseBody {}"+googleLoginResponse.toString());


        String googleToken = googleLoginResponse.getId_token();

        //5.받은 토큰을 구글에 보내 유저정보를 얻는다.
        String requestUrl = UriComponentsBuilder.fromHttpUrl(googleAuthUrl + "/tokeninfo").queryParam("id_token",googleToken).toUriString();

        String requestUrl2 = UriComponentsBuilder.fromHttpUrl("https://people.googleapis.com/v1/people/me").queryParam("personFields", "birthdays,genders").queryParam("key",api).toUriString();
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "Bearer "+googleLoginResponse.getAccess_token());
        
        
        //6.허가된 토큰의 유저정보를 결과로 받는다.
        String resultJson = restTemplate.getForObject(requestUrl, String.class);
        ResponseEntity<String> resultJson2 = restTemplate.exchange(requestUrl2, HttpMethod.GET, new HttpEntity<>(headers) , String.class);

 
        return resultJson+googleLoginResponse.toString()+ resultJson2;
    }
	
	

    
    
}
