<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필 수정</title>
</head>
<body>
    <c:if test="${not empty errorMessage}">
        <div style="color: red;">${errorMessage}</div> 
    </c:if>

    <form action="/user/edit" method="post">
        <div>
            <label for="userId">아이디:</label>
            <input type="text" id="userId" name="userId" value="${user.userId}" readonly>
        </div>
        <button type="submit">수정</button>
    </form>

    <a href="/user/profile">프로필로 돌아가기</a>
</body>
</html>