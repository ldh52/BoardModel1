<%@page import="com.test.model1board.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="dao" class="com.test.model1board.BoardDAO"/>

<%
    int bnum = Integer.parseInt(request.getParameter("bnum"));
    
    // 조회수 증가 로직 추가
    dao.increaseHit(bnum); 

    Board b = dao.getBoard(bnum); 

    // EL을 사용하기 위해 request scope에 Board 객체 저장
    request.setAttribute("board", b);

    // 로그인한 사용자 정보를 가져오는 부분 추가
    String loggedInUser = (String) session.getAttribute("userId"); // 세션에서 사용자 ID 가져오기
    request.setAttribute("loggedInUser", loggedInUser);
%>

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

<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script type="text/javascript">
    function editBoard(bnum) {
        location.href = "boardEditForm.jsp?bnum=" + bnum; 
    }

    function deleteBoard(bnum) {
        if (confirm("정말 삭제하시겠습니까?")) {
            // 폼을 생성하여 POST 방식으로 데이터 전송
            var form = $('<form></form>');
            form.attr('method', 'post');
            form.attr('action', 'deleteBoard.jsp');
            form.append($('<input/>', {type: 'hidden', name: 'bnum', value: bnum}));
            $('body').append(form);
            form.submit();
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
</main>
</body>
</html>