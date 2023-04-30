package com.together.moviesquare.ott.vo;

import java.io.Serializable;

public class Ott implements Serializable{
	private static final long serialVersionUID = -3972513095462105173L;
	
	private int ott_number; // 기본키생성
	private String ott_name; // OTT카테고리(netflix, watcha, tving, wavve)
	private String ott_movierank; // 영화순위(1~10)
	private String ott_moviename; // 영화명
	private String ott_date; // 크롤링된 날짜
	public Ott() {
		super();
	}
	public Ott(int ott_number, String ott_name, String ott_movierank, String ott_moviename, String ott_date) {
		super();
		this.ott_number = ott_number;
		this.ott_name = ott_name;
		this.ott_movierank = ott_movierank;
		this.ott_moviename = ott_moviename;
		this.ott_date = ott_date;
	}
	public int getOtt_number() {
		return ott_number;
	}
	public void setOtt_number(int ott_number) {
		this.ott_number = ott_number;
	}
	public String getOtt_name() {
		return ott_name;
	}
	public void setOtt_name(String ott_name) {
		this.ott_name = ott_name;
	}
	public String getOtt_movierank() {
		return ott_movierank;
	}
	public void setOtt_movierank(String ott_movierank) {
		this.ott_movierank = ott_movierank;
	}
	public String getOtt_moviename() {
		return ott_moviename;
	}
	public void setOtt_moviename(String ott_moviename) {
		this.ott_moviename = ott_moviename;
	}
	public String getOtt_date() {
		return ott_date;
	}
	public void setOtt_date(String ott_date) {
		this.ott_date = ott_date;
	}
	@Override
	public String toString() {
		return "Ott [ott_number=" + ott_number + ", ott_name=" + ott_name + ", ott_movierank=" + ott_movierank
				+ ", ott_moviename=" + ott_moviename + ", ott_date=" + ott_date + "]";
	}
}
