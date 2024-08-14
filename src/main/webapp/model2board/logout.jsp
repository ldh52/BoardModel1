<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page import="org.json.simple.JSONObject"%>

<%
    // 세션 무효화
    session.invalidate();

    // JSON 응답 생성
    JSONObject jsonObject = new JSONObject();
    jsonObject.put("ok", true); // 로그아웃 성공 여부
    // 필요하다면 추가적인 정보를 JSON에 담을 수 있습니다.

    // JSON 응답 출력
    out.print(jsonObject.toJSONString());
    out.flush();
%>