package com.test.model2board;

public class User {

	private String userId; // 사용자 아이디
	private String password; // 비밀번호
    // 필요에 따라 다른 사용자 정보 필드 추가 (예: 이름, 이메일, 가입일 등)

    public User() {} // 기본 생성자

	public User(String userId, String password) {
		this.userId = userId;
		this.password = password;
	}

    // userId getter/setter
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    // password getter/setter
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    // 필요에 따라 다른 사용자 정보 필드의 getter/setter 추가
}