package com.together.moviesquare.member.vo;

import java.io.Serializable;

public class KaKao implements Serializable {
	private static final long serialVersionUID = 3656163374550046489L;
	
	private String m_nickname;
	private String m_gender;
	private String admin;
	private String login_ok;
	private String kakaoid;
	private String agecode;
	public KaKao() {
		super();
	}
	public KaKao(String m_nickname, String m_gender, String admin, String login_ok, String kakaoid, String agecode) {
		super();
		this.m_nickname = m_nickname;
		this.m_gender = m_gender;
		this.admin = admin;
		this.login_ok = login_ok;
		this.kakaoid = kakaoid;
		this.agecode = agecode;
	}
	public String getM_nickname() {
		return m_nickname;
	}
	public void setM_nickname(String m_nickname) {
		this.m_nickname = m_nickname;
	}
	public String getM_gender() {
		return m_gender;
	}
	public void setM_gender(String m_gender) {
		this.m_gender = m_gender;
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
	public String getKakaoid() {
		return kakaoid;
	}
	public void setKakaoid(String kakaoid) {
		this.kakaoid = kakaoid;
	}
	public String getAgecode() {
		return agecode;
	}
	public void setAgecode(String agecode) {
		this.agecode = agecode;
	}
	@Override
	public String toString() {
		return "KaKao [m_nickname=" + m_nickname + ", m_gender=" + m_gender + ", admin=" + admin + ", login_ok="
				+ login_ok + ", kakaoid=" + kakaoid + ", agecode=" + agecode + "]";
	}
	
	
}
