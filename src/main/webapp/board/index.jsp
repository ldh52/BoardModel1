<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
</head>
<body>
    <header>
        <h1>게시판</h1>
        <nav>
            <ul>
                <li><a href="/board/list">게시판 목록</a></li>
                <c:if test="${empty userId}"> <%-- 로그인하지 않은 경우 --%>
                    <li><a href="/user/login">로그인</a></li>
                    <li><a href="/user/register">회원가입</a></li>
                </c:if>
                <c:if test="${not empty userId}"> <%-- 로그인한 경우 --%>
                    <li><a href="/user/profile">프로필</a></li>
                    <li><a href="/user/logout" method="post">로그아웃</a></li>
                </c:if>
            </ul>
        </nav>
    </header>

    <main>
        <jsp:include page="${viewPage}" /> <%-- 실제 내용이 표시될 부분 --%>
    </main>

    <footer>
        <p>&copy; 2023 My Board</p>
    </footer>
</body>
</html>