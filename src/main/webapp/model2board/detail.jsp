<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세보기</title>

<style type="text/css">
main { width:fit-content; margin:0.5em auto; }
main>h3 { width:fit-content; margin:0.2em auto; border-bottom:3px double black;}
table { border-spacing: 0; border-collapse: collapse; border:1px solid black;}
th {background-color:#eef; text-align:right; border-right:3px double black;}
th,td { padding:0.2em 0.5em; border-bottom:1px dashed black; }
tr:last-child>td { width:20em; height:5em; overflow: auto;}
</style>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
    function editBoard(bnum) {
        location.href = "/board/edit?bnum=" + bnum; 
    }

    function deleteBoard(bnum) {
        if (confirm("정말 삭제하시겠습니까?")) {
            $.ajax({
                url: '/board/delete', // Model2에서는 Controller의 URL을 사용합니다.
                method: 'post',
                data: { bnum: bnum },
                dataType: 'json',
                success: function(res) {
                    if (res.deleted) {
                        alert('삭제 성공');
                        location.href = "/board/list"; 
                    } else {
                        alert('삭제 실패: ' + res.message); 
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
   <h3>게시글 상세보기</h3>
   <table>
      <tr><th>번호</th><td>${board.bnum}</td></tr>
      <tr><th>제목</th><td>${board.title}</td></tr>
      <tr><th>작성자</th><td>${board.author}</td></tr>
      <tr><th>작성일</th><td><fmt:formatDate value="${board.rdate}" pattern="yyyy-MM-dd HH:mm:ss" /></td></tr>
      <tr><th>조회수</th><td>${board.hit}</td></tr>
      <tr><th>내용</th><td>${board.contents}</td></tr>
   </table>

   <c:if test="${not empty loggedInUser and loggedInUser == board.author}"> 
       <div>
           <button type="button" onclick="editBoard(${board.bnum})">수정</button>
           <button type="button" onclick="deleteBoard(${board.bnum})">삭제</button>
       </div>
   </c:if>
   <a href="/board/list">목록으로</a> 
</main>
</body>
</html>