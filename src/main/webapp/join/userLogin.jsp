<%@ page language="java" contentType="application/json; charset=UTF-8" 
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page import="com.test.join.User" %>
<%@ page import="com.test.join.UserDAO" %>
<%@ page import="org.json.simple.JSONObject"%>

<%
    // JSON 응답 객체 생성
    JSONObject jsonObject = new JSONObject();

    try {
        // 1. 사용자 정보 가져오기
        User user = new User();
        user.setUid(request.getParameter("uid"));
        user.setPwd(request.getParameter("pwd")); // 실제 운영 환경에서는 비밀번호 암호화 필요

        // 2. 로그인 처리
        UserDAO dao = new UserDAO();
        boolean ok = dao.login(user);

        // 3. 로그인 성공 시 세션에 사용자 정보 저장
        if (ok) {
            session.setAttribute("uid", user.getUid()); 
            // 필요에 따라 다른 사용자 정보도 세션에 저장할 수 있습니다. (예: 이름, 권한 등)
        }

        // 4. JSON 응답에 결과 저장
        jsonObject.put("ok", ok);

    } catch (Exception e) {
        // 예외 처리 (오류 메시지 표시 또는 오류 페이지로 리디렉션)
        jsonObject.put("ok", false);
        jsonObject.put("message", "오류가 발생했습니다.");
    }

    // 5. JSON 응답 전송
    out.print(jsonObject.toJSONString());
    out.flush();
%>