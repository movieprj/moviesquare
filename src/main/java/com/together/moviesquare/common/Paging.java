package com.together.moviesquare.common;

public class Paging {
	private int startRow;
	private int endRow;
	private String m_id;
	private int group_no;
	
	
	public int getStartRow() {
		return startRow;
	}


	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}


	public int getEndRow() {
		return endRow;
	}


	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}


	public String getM_id() {
		return m_id;
	}


	public void setM_id(String m_id) {
		this.m_id = m_id;
	}


	public int getGroup_no() {
		return group_no;
	}


	public void setGroup_no(int group_no) {
		this.group_no = group_no;
	}


	@Override
	public String toString() {
		return "Paging [startRow=" + startRow + ", endRow=" + endRow + ", m_id=" + m_id + ", group_no=" + group_no
				+ "]";
	}


	public Paging(int startRow, int endRow, int group_no) {
		super();
		this.startRow = startRow;
		this.endRow = endRow;
		this.group_no = group_no;
	}


	public Paging(int startRow, int endRow, String m_id) {
		super();
		this.startRow = startRow;
		this.endRow = endRow;
		this.m_id = m_id;
	}


	public Paging(int startRow, int endRow) {
		super();
		this.startRow = startRow;
		this.endRow = endRow;
	}


	public Paging(int startRow, int endRow, String m_id, int group_no) {
		super();
		this.startRow = startRow;
		this.endRow = endRow;
		this.m_id = m_id;
		this.group_no = group_no;
	}


	public Paging() {}

	
}
