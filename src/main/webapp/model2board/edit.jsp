<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
        url: '/board/edit', // 게시글 수정 처리 Servlet URL
        method: 'post',
        cache: false,
        data: formData, 
        dataType: 'json',
        success: function(res) {
            alert(res.updated ? '수정 성공' : '수정 실패');
            if (res.updated) {
                location.href = "/board/detail?bnum=" + ${board.bnum};  // EL 사용
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

    <c:if test="${not empty errorMessage}">
        <div style="color: red;">${errorMessage}</div> 
    </c:if>

    <form id="editForm">
        <input type="hidden" name="bnum" value="${board.bnum}"> 
        <div>
            <label for="title">제목</label>
            <input type="text" name="title" id="title" value="${board.title}">
        </div>

        <div>
            <label for="contents">내용</label>
            <textarea name="contents" id="contents" rows="5" cols="20">${board.contents}</textarea>
        </div>

        <div>
            <button type="reset">취소</button>
            <button type="button" onClick="updateBoard();">저장</button>
        </div>
    </form>

    <a href="/board/detail?bnum=${board.bnum}">상세보기로 돌아가기</a> 
</main>
</body>
</html>