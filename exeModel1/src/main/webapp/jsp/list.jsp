<%@page import="exeModel1.BoardDAO"%>
<%@page import="exeModel1.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ page import="java.util.List" %>

<%
    // 1. 로그인 처리 (폼 제출 시)
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");

        try {
            boolean isLoginSuccess = UserDAO.login(userId, password);

            if (isLoginSuccess) {
                session.setAttribute("userId", userId);
            } else {
                request.setAttribute("loginError", "로그인 실패"); 
            }
        } catch (Exception e) {
            e.printStackTrace(); 
            request.setAttribute("loginError", "로그인 처리 중 오류 발생"); 
        }
    }

    // 2. 게시글 목록 조회 (로그인 여부와 관계없이 항상 실행)
    try {
        List<BoardVO> boardList = BoardDAO.getList();
        request.setAttribute("boardList", boardList); 
    } catch (Exception e) {
        e.printStackTrace(); 
        request.setAttribute("errorMessage", "게시글 목록 조회 중 오류 발생"); 
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<style>
    table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
    }

    th, td {
    padding: 10px;
    text-align: left;
    border-bottom: 1px solid #ddd;
    }
</style>
</head>
<body>

    <c:if test="${empty sessionScope.userId}"> 
        <h2>로그인</h2>
        <form method="POST" action="list.jsp"> 
            <c:if test="${not empty requestScope.loginError}">
                <p style="color: red;">${requestScope.loginError}</p> 
            </c:if>
            <input type="text" name="userId" placeholder="아이디" required><br>
            <input type="password" name="password" placeholder="비밀번호" required><br>
            <button type="submit">로그인</button>
        </form>
    </c:if>

    <c:if test="${not empty sessionScope.userId}"> 
        <h2>게시판</h2>

        <c:if test="${not empty requestScope.errorMessage}">
            <p style="color: red;">${requestScope.errorMessage}</p> 
        </c:if>

        <table>
            <thead>
                </thead>
            <tbody>
                <c:forEach var="vo" items="${boardList}"> 
                    </c:forEach>
            </tbody>
        </table>

        <a href="write.jsp">글쓰기</a>
        <a href="logout.jsp">로그아웃</a>
    </c:if>

</body>
</html>