<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.test.model1board.Board" %>
<%@ page import="com.test.model1board.BoardDAO" %>
<jsp:useBean id="dao" class="com.test.model1board.BoardDAO"/>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
</head>
<body>
<main>
    <h3>게시글 목록</h3>

    <%
        List<Board> boardList = dao.getBoardList();
    %>

    <table>
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
                <th>조회수</th>
            </tr>
        </thead>
        <tbody>
            <% 
                if (boardList != null && !boardList.isEmpty()) {
                    for (Board board : boardList) { 
            %>
                <tr>
                    <td><%= board.getBnum() %></td>
                    <td><a href="boardDetail.jsp?bnum=<%= board.getBnum() %>"><%= board.getTitle() %></a></td>
                    <td><%= board.getAuthor() %></td>
                    <td><%= board.getRdate() %></td>
                    <td><%= board.getHit() %></td>
                </tr>
            <% 
                    } 
                } else { 
            %>
                <tr>
                    <td colspan="5">등록된 게시글이 없습니다.</td>
                </tr>
            <% 
                } 
            %>
        </tbody>
    </table>
</main>
</body>
</html>