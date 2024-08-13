<%@page import="com.test.model1board.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="dao" class="com.test.model1board.BoardDAO"/>

<%
    int bnum = Integer.parseInt(request.getParameter("bnum"));
    Board b = dao.getBoard(bnum); // 게시글 정보 조회

    // 사용자 인증 및 권한 검증 (예시)
    String loggedInUser = (String) session.getAttribute("uid");
    if (loggedInUser == null || !loggedInUser.equals(b.getAuthor())) {
        // 로그인하지 않았거나 작성자가 아닌 경우 접근 제한
        response.sendRedirect("boardList.jsp"); // 게시글 목록 페이지로 이동
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
function updateBoard() {
    if (!confirm('수정된 내용을 저장하시겠습니까?')) return;

    var formData = $('#editForm').serialize(); 

    $.ajax({
        url: 'updateBoardProc.jsp', // 게시글 수정 처리 JSP 페이지
        method: 'post',
        cache: false,
        data: formData, 
        dataType: 'json',
        success: function(res) {
            alert(res.updated ? '수정 성공' : '수정 실패');
            if (res.updated) {
                location.href = "boardDetail.jsp?bnum=" + <%= bnum %>; 
            }
        },
        error: function(xhr, status, err) {
            alert('에러: ' + err);
        }
    });
}
</script>
</head>
<body>
<main>
    <h3>게시물 수정</h3>
    <form id="editForm">
        <input type="hidden" name="bnum" value="<%= bnum %>"> 
        <div>
            <label for="title">제목</label>
            <input type="text" name="title" id="title" value="<%= b.getTitle() %>">
        </div>

        <div>
            <label for="contents">내용</label>
            <textarea name="contents" id="contents" rows="5" cols="20"><%= b.getContents() %></textarea> 
        </div>

        <div>
            <button type="reset">취소</button>
            <button type="button" onClick="updateBoard();">저장</button>
        </div>
    </form>
</main>
</body>
</html>