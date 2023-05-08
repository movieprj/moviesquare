package com.together.moviesquare.member.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class NaverUser {
	private String id;
	private String nickname;
	private String name;
	private String email;
	private String gender;
	private String age;
	private String birthday;
	private String profile_image;
	private String birthyear;
	private String mobile;
}
