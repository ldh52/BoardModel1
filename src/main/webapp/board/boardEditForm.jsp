<%@page import="com.test.model1board.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:useBean id="dao" class="com.test.model1board.BoardDAO"/>

<%
	int bnum = Integer.parseInt(request.getParameter("bnum"));
	Board b = dao.getBoard(bnum);

	//EL을 사용하기 위해 request scope에 Board 객체 저장
	request.setAttribute("board", b);
	
	// 로그인한 사용자 정보를 가져오는 부분 추가
	String loggedInUser = (String) session.getAttribute("userId");
	request.setAttribute("loggedInUser", loggedInUser);
	
	// 수정 요청 처리 (POST 방식)
	if (request.getMethod().equalsIgnoreCase("POST")) {
	    // 폼 데이터 가져오기
	    String title = request.getParameter("title");
	    String contents = request.getParameter("contents");
	
	    // Board 객체 업데이트
	    b.setTitle(title);
	    b.setContents(contents);
	
	    // 수정 처리 및 결과 메시지 설정
	    boolean updated = dao.updateBoard(b);
	    request.setAttribute("updateResult", updated ? "수정 성공" : "수정 실패");
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script type="text/javascript">
var bnum = ${board.bnum};
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
            	location.href = "boardDetail.jsp?bnum=" + ${board.bnum};  // EL 사용
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
</main>
</body>
</html>