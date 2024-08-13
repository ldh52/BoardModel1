<%@page import="com.test.model1board.Board"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<jsp:useBean id="board" class="com.test.model1board.Board"/>
<jsp:setProperty name="board" property="*"/>
<jsp:useBean id="dao" class="com.test.model1board.BoardDAO"/>

<%
    // 사용자 인증 및 권한 검증 (예시) - 필요에 따라 추가
    String loggedInUser = (String) session.getAttribute("uid");
    if (loggedInUser == null || !loggedInUser.equals(board.getAuthor())) {
        // 로그인하지 않았거나 작성자가 아닌 경우 접근 제한
        out.print("{\"updated\":false, \"message\": \"수정 권한이 없습니다.\"}");
        return;
    }

    boolean updated = dao.updateBoard(board); 
%>
{"updated":<%=updated%>} 