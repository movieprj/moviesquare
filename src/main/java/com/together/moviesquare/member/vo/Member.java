package com.together.moviesquare.member.vo;

import java.io.Serializable;

public class Member implements Serializable{
	private static final long serialVersionUID = -9221403764215912626L;
	
	private String m_pw;
	private String m_name;
	private String m_nickname;
	private String m_email;
	private String m_gender;
	private String m_birthday;
	private String admin;
	private String login_ok;
	private String agecode;
	private String socal_id;
	public Member(String m_pw, String m_name, String m_nickname, String m_email, String m_gender,
			String m_birthday, String admin, String login_ok, String agecode, String socal_id) {
		super();
		this.m_pw = m_pw;
		this.m_name = m_name;
		this.m_nickname = m_nickname;
		this.m_email = m_email;
		this.m_gender = m_gender;
		this.m_birthday = m_birthday;
		this.admin = admin;
		this.login_ok = login_ok;
		this.agecode = agecode;
		this.socal_id = socal_id;
	}
	public Member() {
		super();
	}
	
	public String getSocal_id() {
		return socal_id;
	}
	public void setSocal_id(String socal_id) {
		this.socal_id = socal_id;
	}
	public String getM_pw() {
		return m_pw;
	}
	public void setM_pw(String m_pw) {
		this.m_pw = m_pw;
	}
	public String getM_name() {
		return m_name;
	}
	public void setM_name(String m_name) {
		this.m_name = m_name;
	}
	public String getM_nickname() {
		return m_nickname;
	}
	public void setM_nickname(String m_nickname) {
		this.m_nickname = m_nickname;
	}
	public String getM_email() {
		return m_email;
	}
	public void setM_email(String m_email) {
		this.m_email = m_email;
	}
	public String getM_gender() {
		return m_gender;
	}
	public void setM_gender(String m_gender) {
		this.m_gender = m_gender;
	}
	public String getM_birthday() {
		return m_birthday;
	}
	public void setM_birthday(String m_birthday) {
		this.m_birthday = m_birthday;
	}
	public String getAdmin() {
		return admin;
	}
	public void setAdmin(String admin) {
		this.admin = admin;
	}
	public String getLogin_ok() {
		return login_ok;
	}
	public void setLogin_ok(String login_ok) {
		this.login_ok = login_ok;
	}
	
	public String getAgecode() {
		return agecode;
	}
	public void setAgecode(String agecode) {
		this.agecode = agecode;
	}
	@Override
	public String toString() {
		return "Member [m_pw=" + m_pw + ", m_name=" + m_name + ", m_nickname=" + m_nickname + ", m_email=" + m_email
				+ ", m_gender=" + m_gender + ", m_birthday=" + m_birthday + ", admin=" + admin + ", login_ok="
				+ login_ok + ", agecode=" + agecode + ", socal_id=" + socal_id + "]";
	}
	
}
