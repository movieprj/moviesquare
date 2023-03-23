package com.together.moviesquare.member.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.together.moviesquare.member.dao.MemberDao;
import com.together.moviesquare.member.vo.KaKao;

@Service
public class KakaologinServiceImpl implements KakaologinService{
	
	@Autowired
	public MemberDao dao;
	
	@Override
	//접근토큰
		public JsonNode getAccessToken(String autorize_code) {

			final String RequestUrl = "https://kauth.kakao.com/oauth/token";
			final List<NameValuePair> postParams = new ArrayList<NameValuePair>();

			postParams.add(new BasicNameValuePair("grant_type", "authorization_code"));
			postParams.add(new BasicNameValuePair("client_id", "5cb3fc356b2936bfab1a6ac9666cccfa"));
			postParams.add(new BasicNameValuePair("redirect_uri", "http://127.0.0.1:8080/moviesquare/kakaoLogin.do"));
			postParams.add(new BasicNameValuePair("code", autorize_code));

			final HttpClient client = HttpClientBuilder.create().build();
			final HttpPost post = new HttpPost(RequestUrl);

			JsonNode returnNode = null;

			try {

				post.setEntity(new UrlEncodedFormEntity(postParams));
				final HttpResponse response = client.execute(post);
				ObjectMapper mapper = new ObjectMapper();
				returnNode = mapper.readTree(response.getEntity().getContent());

			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();

			} catch (ClientProtocolException e) {
				e.printStackTrace();

			} catch (IOException e) {
				e.printStackTrace();

			} finally {

			}

			return returnNode;

		}
	
	@Override
	//사용자 정보 가져오기
		public JsonNode getKakaoUserInfo(JsonNode accessToken) {
			//url 버전 변경됨 v2로
			final String RequestUrl = "https://kapi.kakao.com/v2/user/me";
			final HttpClient client = HttpClientBuilder.create().build();
			final HttpPost post = new HttpPost(RequestUrl);
			
			// add header
			//**주의 accessToken 값은 JsonNode형이어야 함, Bearer뒤에 스페이스바 
			post.addHeader("Authorization", "Bearer " + accessToken);
			JsonNode returnNode = null;
			
			try {
				final HttpResponse response = client.execute(post); 
				ObjectMapper mapper = new ObjectMapper();
				returnNode = mapper.readTree(response.getEntity().getContent());

			} catch (ClientProtocolException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} finally { 
			}
			return returnNode;
			
		}

	@Override
	public int enroll(KaKao member) {
		return dao.enroll(member);
	}

	@Override
	public KaKao selectMember(String kakaoid) {
		return dao.selectKakaoMember(kakaoid);
	}
}
