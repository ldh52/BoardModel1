package com.test.join;

public class User
{
	private String uid;
	private String pwd;
	
	User() {}
	User(String uid, String pwd) {
		this.uid = uid;
		this.pwd = pwd;
	}
	
	@Override
	public String toString()
	{
		return "[아이디/암호] " + uid + "/" + pwd + ", " ;
	}
	public String getUid()
	{
		return uid;
	}
	public String getPwd()
	{
		return pwd;
	}
	public void setUid(String uid)
	{
		this.uid = uid;
	}
	public void setPwd(String pwd)
	{
		this.pwd = pwd;
	}
}
