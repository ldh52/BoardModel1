<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.test.model1board.Board" %>
<%@ page import="com.test.model1board.BoardDAO" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
    // BoardDAO 객체 생성 및 게시글 목록 조회
    BoardDAO dao = new BoardDAO();
    List<Board> list = dao.getBoardList();
    
    // 조회된 게시글 목록을 request scope에 저장
    request.setAttribute("boardList", list); 
    
    // 로그인한 사용자 정보를 가져오는 부분 추가
    String loggedInUser = (String) session.getAttribute("userId"); // 세션에서 사용자 ID 가져오기
    request.setAttribute("loggedInUser", loggedInUser);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> 
<script type="text/javascript">
    function editBoard(bnum) {
        location.href = "boardEditForm.jsp?bnum=" + bnum; 
    }

    function deleteBoard(bnum) {
        if (confirm("정말 삭제하시겠습니까?")) {
            $.ajax({
                url: 'deleteBoard.jsp',
                method: 'post',
                data: { bnum: bnum },
                dataType: 'json',
                success: function(res) {
                    if (res.deleted) {
                        alert('삭제 성공');
                        location.reload(); // 페이지 새로고침
                    } else {
                        alert('삭제 실패');
                    }
                },
                error: function(xhr, status, err) {
                    alert('에러: ' + err);
                }
            });
        }
    }
</script>
</head>
<body>
<main>
    <h3>게시글 목록</h3>
    <table>
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
                <th>조회수</th>
                <th>수정</th>
                <th>삭제</th>
            </tr>
        </thead>
        <tbody>

        <c:forEach items="${boardList}" var="board">
            <tr>
                <td>${board.bnum}</td> 
                <td><a href="boardDetail.jsp?bnum=${board.bnum}">${board.title}</a></td>
                <td>${board.author}</td>
                <td><fmt:formatDate value="${board.rdate}" pattern="yyyy-MM-dd HH:mm:ss" /></td> 
                <td>${board.hit}</td>
                <td>
                    <c:if test="${not empty loggedInUser and loggedInUser == board.author}"> 
                        <a href="javascript:editBoard(${board.bnum});">수정</a>
                    </c:if>
                </td>
                <td>
                    <c:if test="${not empty loggedInUser and loggedInUser == board.author}">
                        <a href="javascript:deleteBoard(${board.bnum});">삭제</a>
                    </c:if>
                </td>
            </tr>
        </c:forEach>

        </tbody>
    </table>
</main>
</body>
</html>