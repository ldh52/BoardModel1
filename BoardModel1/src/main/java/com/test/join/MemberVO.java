package com.test.join;

import java.text.ParseException;
import java.text.SimpleDateFormat;

public class MemberVO 
{
	private String uid;
	private String pwd;
	private String gender;
	private String[] hobby;
	private int history;
	private int age;
	private java.sql.Date birth;
	private String intro;
	
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String[] getHobby() {
		return hobby;
	}
	public void setHobby(String[] hobby) {
		this.hobby = hobby;
	}
	public int getHistory() {
		return history;
	}
	public void setHistory(int history) {
		this.history = history;
	}
	public void setHistory(String  sHistory) {
		this.history = Integer.parseInt(sHistory);
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public void setAge(String sAge) {
		this.age = Integer.parseInt(sAge);
	}
	public java.sql.Date getBirth() {
		return birth;
	}
	public void setBirth(java.sql.Date birth) {
		this.birth = birth;
	}
	public void setBirth(String birth) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date uDate;
		try {
			uDate = sdf.parse(birth);
			java.sql.Date sDate = new java.sql.Date(uDate.getTime());
			this.birth = sDate;
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
}
