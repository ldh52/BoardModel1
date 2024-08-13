<%@page import="com.test.model1board.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="dao" class="com.test.model1board.BoardDAO"/>

<%
   int bnum = Integer.parseInt(request.getParameter("bnum"));
   Board b = dao.getBoard(bnum); 
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

</head>
<body>
<main>
   <h3>게시글 상세보기</h3>
   <table>
      <tr><th>번호</th><td><%=b.getBnum()%></td></tr>
      <tr><th>제목</th><td><%=b.getTitle()%></td></tr>
      <tr><th>작성자</th><td><%=b.getAuthor()%></td></tr>
      <tr><th>작성일</th><td><%=b.getRdate()%></td></tr>
      <tr><th>조회수</th><td><%=b.getHit()%></td></tr>
      <tr><th>내용</th><td><%=b.getContents()%></td></tr>
   </table>
</main>
</body>
</html>