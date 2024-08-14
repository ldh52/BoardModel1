<%@page import="exeModel1.BoardDAO"%>
<%@page import="exeModel1.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<%
int boardId = Integer.parseInt(request.getParameter("boardId"));

try {
    BoardVO vo = BoardDAO.getView(boardId);
    request.setAttribute("vo", vo);
} catch (Exception e) {
    e.printStackTrace();
    // 에러 처리 (예: 에러 페이지로 이동 또는 에러 메시지 표시)
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 보기</title>
</head>
<body>

    <h2>${vo.title}</h2>
    <p>작성자: ${vo.writer}</p>
    <p>등록일: <fmt:formatDate value="${vo.regDate}" pattern="yyyy-MM-dd HH:mm:ss" /></p>
    <p>수정일: <fmt:formatDate value="${vo.modDate}" pattern="yyyy-MM-dd HH:mm:ss" /></p>
    <hr>
    <p>${vo.content}</p>

    <c:if test="${sessionScope.userId eq vo.writer}"> 
        <a href="modify.jsp?boardId=${vo.boardId}">수정</a>
        <a href="delete.jsp?boardId=${vo.boardId}">삭제</a>
    </c:if>

    <a href="list.jsp">목록</a> 

</body>
</html>