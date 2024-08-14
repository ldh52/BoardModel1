<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${not empty sessionScope.userId}">
    <c:redirect url="list.jsp"/> 
</c:if>

<%
    // 1. 사용자 입력 받기
    String userId = request.getParameter("userId");
    String password = request.getParameter("password");

    // 2. 입력값 검증 (필요에 따라 추가)
    if (userId == null || userId.isEmpty() || password == null || password.isEmpty()) {
        // ... 입력값 오류 처리
        return;
    }

    // 3. 데이터베이스 조회 및 로그인 처리
    try {
        boolean isLoginSuccess = UserDAO.login(userId, password);

        if (isLoginSuccess) {
            // 4. 로그인 성공 처리
            session.setAttribute("userId", userId);
            response.sendRedirect("list.jsp"); // 게시판 목록 페이지로 이동
        } else {
            // 4. 로그인 실패 처리
            out.println("<script>alert('로그인 실패'); history.back();</script>"); 
        }
    } catch (Exception e) {
        // 예외 처리 (데이터베이스 오류 등)
        e.printStackTrace(); 
    }
%>
