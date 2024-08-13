<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
    
<jsp:useBean id="dao" class="com.test.model1board.BoardDAO"/>

<%
    // 1. 삭제할 게시글 번호 가져오기
    int bnum = Integer.parseInt(request.getParameter("bnum"));

    // 2. 사용자 인증 및 권한 검증 (예시) - 필요에 따라 추가
    String loggedInUser = (String) session.getAttribute("uid");
    if (loggedInUser == null) {
        // 로그인하지 않은 경우 접근 제한
        out.print("{\"deleted\":false, \"message\": \"로그인이 필요합니다.\"}");
        return;
    } 
    // 추가적으로, 현재 사용자가 게시글 작성자인지 또는 관리자인지 확인하는 로직 필요

    // 3. 게시글 삭제
    boolean deleted = dao.deleteBoard(bnum);

    // 4. JSON 응답 생성 및 전송
    out.print("{\"deleted\": " + deleted + "}"); 
%>