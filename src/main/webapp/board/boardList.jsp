<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.test.model1board.Board" %>
<%@ page import="com.test.model1board.BoardDAO" %>
<%@ page import="java.util.List" %>

<%
    // BoardDAO 객체 생성 및 게시글 목록 조회
    BoardDAO dao = new BoardDAO();
    List<Board> list = dao.getBoardList(); 
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
        <% if (list != null && !list.isEmpty()) { 
               for (Board b : list) { %>
            <tr>
                <td><%= b.getBnum() %></td>
                <td><a href="boardDetail.jsp?bnum=<%= b.getBnum() %>"><%= b.getTitle() %></a></td>
                <td><%= b.getAuthor() %></td>
                <td><%= b.getRdate() %></td>
                <td><%= b.getHit() %></td>
                <td><a href="javascript:editBoard(<%= b.getBnum() %>);">수정</a></td>
                <td><a href="javascript:deleteBoard(<%= b.getBnum() %>);">삭제</a></td>
            </tr>
        <%    } 
           } else { %>
            <tr>
                <td colspan="7">게시글이 없습니다.</td> 
            </tr>
        <% } %>
        </tbody>
    </table>
</main>
</body>
</html>