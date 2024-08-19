<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모델 1 게시판</title>
</head>
<body>
<main>
<h3>JSP개발방법론 model 1을 사용한 게시판 프로젝트</h3>
<ul>
    <c:choose>
        <c:when test="${empty loginUser}"> <%-- 로그인하지 않은 경우 --%>
            <li><a href="../join/loginForm.jsp">로그인</a></li>
            <li><a href="../join/joinForm.jsp">회원가입</a></li> 
        </c:when>
        <c:otherwise> <%-- 로그인한 경우 --%>
            <li>
                <c:out value="${loginUser.uid}"/>님 환영합니다. 
            </li> 
            <li><a href="logout.jsp">로그아웃</a></li> 
            <li><a href="boardAddForm.jsp">글쓰기</a></li>
        </c:otherwise>
    </c:choose>
	<li><a href="boardList.jsp">게시글 목록</a></li>	
</ul>
</main>
</body>
</html>