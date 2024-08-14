<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색 결과</title>
<style type="text/css">
main { width: fit-content; margin: 0.5em auto; }
main>h3 { width: fit-content; margin: 0.2em auto; border-bottom: 3px double black; }
table { border-spacing: 0; border-collapse: collapse; border: 1px solid black; }
th { background-color: #eef; text-align: right; border-right: 3px double black; }
th, td { padding: 0.2em 0.5em; border-bottom: 1px dashed black; }
tr:last-child>td { width: 20em; height: 5em; overflow: auto; }
</style>
</head>
<body>
    <main>
        <h3>"${keyword}" 검색 결과 - 총 ${totalBoardCount}건</h3> 

        <form action="/board/search" method="get"> 
            <input type="text" name="keyword" value="${keyword}" placeholder="검색어 입력">
            <button type="submit">검색</button>
        </form>

        <table>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                    <th>조회수</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${boardList}" var="board">
                    <tr>
                        <td>${board.bnum}</td>
                        <td><a href="/board/detail?bnum=${board.bnum}">${board.title}</a></td>
                        <td>${board.author}</td>
                        <td><fmt:formatDate value="${board.rdate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                        <td>${board.hit}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <c:if test="${pageNum > 1}">
            <a href="/board/search?keyword=${keyword}&pageNum=${pageNum - 1}&pageSize=${pageSize}">이전</a>
        </c:if>

        <c:forEach begin="1" end="${Math.ceil(totalBoardCount / pageSize)}" var="i">
            <c:choose>
                <c:when test="${i == pageNum}">
                    <span>${i}</span> 
                </c:when>
                <c:otherwise>
                    <a href="/board/search?keyword=${keyword}&pageNum=${i}&pageSize=${pageSize}">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:if test="${pageNum < Math.ceil(totalBoardCount / pageSize)}">
            <a href="/board/search?keyword=${keyword}&pageNum=${pageNum + 1}&pageSize=${pageSize}">다음</a>
        </c:if>

        <a href="/board/list">목록으로</a> 
    </main>
</body>
</html>