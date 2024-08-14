package com.test.join;

import jakarta.servlet.http.HttpServletRequest;

public class FormProc 
{
	public boolean saveForm(HttpServletRequest request) {
		String uid = request.getParameter("uid");
		String pwd = request.getParameter("pwd");
		String gender = request.getParameter("gender");
		String[] hobbies = request.getParameterValues("hobby");
		String sHistory = request.getParameter("history");
		String sAge = request.getParameter("age");
		String sBirth = request.getParameter("birth");
		String intro = request.getParameter("intro");
	
		//MemberVO, UserDAO, member 테이블에 저장
		//hobby 테이블 별도 생성
		MemberVO m = new MemberVO();
		m.setUid(uid);
		m.setPwd(pwd);
		m.setGender(gender);
		m.setHobby(hobbies);
		m.setHistory(sHistory);
		m.setAge(sAge);
		m.setBirth(sBirth);
		m.setIntro(intro);
		
		UserDAO dao = new UserDAO();
		boolean saved = dao.saveMember(m);
		return saved;
	}
}
