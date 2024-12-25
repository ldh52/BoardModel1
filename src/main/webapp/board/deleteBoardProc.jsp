<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page import="com.test.model1board.BoardDAO" %>
<%@ page import="org.json.simple.JSONObject"%>

<%
    // JSON 응답 객체 생성
    JSONObject jsonObject = new JSONObject();

    try {
        // 1. 삭제할 게시글 번호 가져오기 및 예외 처리
        int bnum;
        try {
            bnum = Integer.parseInt(request.getParameter("bnum"));
        } catch (NumberFormatException e) {
            jsonObject.put("deleted", false);
            jsonObject.put("message", "잘못된 게시글 번호입니다.");
            out.print(jsonObject.toJSONString());
            return; 
        }

        // 2. 사용자 인증 및 권한 검증 (예시)
        String loggedInUser = (String) session.getAttribute("uid");
        if (loggedInUser == null) {
            // 로그인하지 않은 경우 접근 제한
            jsonObject.put("deleted", false);
            jsonObject.put("message", "로그인이 필요합니다.");
            out.print(jsonObject.toJSONString());
            return;
        } 
        // 추가적으로, 현재 사용자가 게시글 작성자인지 또는 관리자인지 확인하는 로직 필요

        // 3. 게시글 삭제
        BoardDAO dao = new BoardDAO();
        boolean deleted = dao.deleteBoard(bnum);
        jsonObject.put("deleted", deleted);

    } catch (Exception e) {
        jsonObject.put("deleted", false);
        jsonObject.put("message", "오류가 발생했습니다.");
    }

    // 4. JSON 응답 전송
    out.print(jsonObject.toJSONString());
    out.flush();
%>