package com.test.model1board;

import java.sql.Date;

public class Board
{ // 글번호(시퀀스), 제목, 작성자, 내용, 작성일, 히트수
	private int bnum;
	private String title;
	private String author;
	private String contents;
	private java.sql.Date rdate;
	private int hit;
	
	public Board(){}
	
	public Board(int bnum, String title, String author, String contents, Date rdate, int hits)
	{
		super();
		this.bnum = bnum;
		this.title = title;
		this.author = author;
		this.contents = contents;
		this.rdate = rdate;
		this.hit = hits;
	}

	public int getBnum()
	{
		return bnum;
	}

	public String getTitle()
	{
		return title;
	}

	public String getAuthor()
	{
		return author;
	}

	public String getContents()
	{
		return contents;
	}

	public java.sql.Date getRdate()
	{
		return rdate;
	}

	public int getHit()
	{
		return hit;
	}

	public void setBnum(int bnum)
	{
		this.bnum = bnum;
	}

	public void setTitle(String title)
	{
		this.title = title;
	}

	public void setAuthor(String author)
	{
		this.author = author;
	}

	public void setContents(String contents)
	{
		this.contents = contents;
	}

	public void setRdate(java.sql.Date rdate)
	{
		this.rdate = rdate;
	}

	public void setHit(int hits)
	{
		this.hit = hit;
	}
}
