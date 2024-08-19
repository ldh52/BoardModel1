<%@ page language="java" contentType="application/json; charset=UTF-8" 
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page import="org.json.simple.JSONObject"%>

<%
    JSONObject jsonObject = new JSONObject(); // JSON 객체 생성

    try {
        // 세션 무효화
        session.invalidate();

        jsonObject.put("ok", true); // 로그아웃 성공

    } catch (Exception e) {
        // 예외 처리 (오류 메시지 표시 또는 오류 페이지로 리디렉션)
        jsonObject.put("ok", false);
        jsonObject.put("message", "오류가 발생했습니다.");
    }

    // JSON 응답 전송
    out.print(jsonObject.toJSONString());
    out.flush();
%>