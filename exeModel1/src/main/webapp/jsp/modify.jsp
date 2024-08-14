<%@page import="exeModel1.BoardDAO"%>
<%@page import="exeModel1.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
int boardId = Integer.parseInt(request.getParameter("boardId"));

try {
    BoardVO vo = BoardDAO.getView(boardId);

    // 권한 확인
    if (!session.getAttribute("userId").equals(vo.getWriter())) {
        out.println("<script>alert('수정 권한이 없습니다.'); history.back();</script>");
        return;
    }

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
<title>게시글 수정</title>
</head>
<body>

    <h2>게시글 수정</h2>

    <form method="post" action="modify_proc.jsp">
        <input type="hidden" name="boardId" value="${vo.boardId}"> 
        <input type="text" name="title" value="${vo.title}" required><br>
        <textarea name="content" required>${vo.content}</textarea><br>
        <button type="submit">수정 완료</button>
    </form>

    <a href="view.jsp?boardId=${vo.boardId}">취소</a> 

</body>
</html>