<%@page import="com.test.model1board.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="dao" class="com.test.model1board.BoardDAO"/>

<%
    // 예외 처리 추가 
    try {
        int bnum = Integer.parseInt(request.getParameter("bnum"));
        Board b = dao.getBoard(bnum);

        if (b == null) {
            out.println("<script>alert('게시글이 존재하지 않습니다.'); history.back();</script>");
            return;
        }

        // 로그인한 사용자 정보 가져오기
        String loggedInUser = (String) session.getAttribute("userId");

        // 로그인 상태 및 작성자 확인
        if (loggedInUser == null || !loggedInUser.equals(b.getAuthor())) {
            out.println("<script>alert('수정 권한이 없습니다.'); history.back();</script>");
            return;
        }

        // 수정 요청 처리 (POST 방식)
        if (request.getMethod().equalsIgnoreCase("POST")) {
            request.setCharacterEncoding("UTF-8"); // 한글 처리

            String title = request.getParameter("title");
            String contents = request.getParameter("contents");

            // 입력값 검증 (필요에 따라 추가)
            if (title == null || title.trim().isEmpty() || contents == null || contents.trim().isEmpty()) {
                out.println("<script>alert('제목과 내용을 모두 입력하세요.'); history.back();</script>");
                return;
            }

            // Board 객체 업데이트
            b.setTitle(title);
            b.setContents(contents);

            // 수정 처리
            boolean updated = dao.updateBoard(b);

            if (updated) {
                // 수정 성공 시 상세 페이지로 이동
                response.sendRedirect("boardDetail.jsp?bnum=" + bnum); 
            } else {
                out.println("<script>alert('게시글 수정에 실패했습니다. 다시 시도해주세요.'); history.back();</script>");
            }
        }

        // EL을 사용하기 위해 request scope에 Board 객체 저장
        request.setAttribute("board", b);
        request.setAttribute("loggedInUser", loggedInUser);

    } catch (NumberFormatException e) {
        out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
        return;
    } catch (Exception e) {
        out.println("<script>alert('오류가 발생했습니다: " + e.getMessage() + "'); history.back();</script>");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
</head>
<body>
<main>
    <h3>게시물 수정</h3>
    <form id="editForm" method="post" action="boardEditForm.jsp?bnum=${board.bnum}"> <%-- 폼 action에 EL 적용 --%>
        <div>
            <label for="title">제목</label>
            <input type="text" name="title" id="title" value="${board.title}" required> <%-- EL 적용 --%>
        </div>

        <div>
            <label for="contents">내용</label>
            <textarea name="contents" id="contents" rows="5" cols="20" required>${board.contents}</textarea> <%-- EL 적용 --%>
        </div>

        <div>
            <button type="submit">수정</button>
            <a href="boardDetail.jsp?bnum=${board.bnum}">취소</a> <%-- EL 적용 --%>
        </div>
    </form>
</main>
</body>
</html>