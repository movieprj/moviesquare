package com.together.moviesquare.common;

import java.sql.Date;

public class SearchPaging {
	private String keyword;
	private int startRow;
	private int endRow;
	private Date begin;
	private Date end;
	private int group_no;
	
	public SearchPaging() {}

	public SearchPaging(String keyword, int startRow, int endRow) {
		super();
		this.keyword = keyword;
		this.startRow = startRow;
		this.endRow = endRow;
	}

	public SearchPaging (Date begin, Date end, int startRow, int endRow) {
		super();
		this.startRow = startRow;
		this.endRow = endRow;
		this.begin = begin;
		this.end = end;
	}

	
	public SearchPaging(String keyword, int startRow, int endRow, int group_no) {
		super();
		this.keyword = keyword;
		this.startRow = startRow;
		this.endRow = endRow;
		this.group_no = group_no;
	}

	public int getGroup_no() {
		return group_no;
	}

	public void setGroup_no(int group_no) {
		this.group_no = group_no;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

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

	public Date getBegin() {
		return begin;
	}

	public void setBegin(Date begin) {
		this.begin = begin;
	}

	public Date getEnd() {
		return end;
	}

	public void setEnd(Date end) {
		this.end = end;
	}

	@Override
	public String toString() {
		return "SearchPaging [keyword=" + keyword + ", startRow=" + startRow + ", endRow=" + endRow + ", begin=" + begin
				+ ", end=" + end + ", group_no=" + group_no + "]";
	}
}