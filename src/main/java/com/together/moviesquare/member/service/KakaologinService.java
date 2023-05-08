package com.together.moviesquare.member.service;

import org.codehaus.jackson.JsonNode;

import com.together.moviesquare.member.vo.KaKao;

public interface KakaologinService {
	JsonNode getAccessToken(String authorize_code) throws Throwable;

	JsonNode getKakaoUserInfo(JsonNode accessToken) ;

	int enroll(KaKao member);

	KaKao selectMember(String kakaoid);
	
	//google
	int enrollGoogle(KaKao member);

	int enrollNaver(KaKao member);

	KaKao selectGoogleMember(String kakaoid);

	KaKao selectNaverMember(String kakaoid);
	
}
