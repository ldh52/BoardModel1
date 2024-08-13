<%@ page language="java" contentType="application/json; charset=UTF-8" 
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

<%
    // 세션 무효화
    session.invalidate();

    // JSON 응답 직접 생성
    out.print("{\"ok\": true}"); 
%>