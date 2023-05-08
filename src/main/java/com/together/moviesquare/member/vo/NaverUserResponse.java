package com.together.moviesquare.member.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class NaverUserResponse {
	private String resultcode;
	private String message;
	private NaverUser response;
}
