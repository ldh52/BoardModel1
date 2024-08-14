<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
    <c:if test="${not empty errorMessage}">
        <div style="color: red;">${errorMessage}</div> 
    </c:if>

    <form action="/user/register" method="post">
        <div>
            <label for="userId">아이디:</label>
            <input type="text" id="userId" name="userId" required>
        </div>
        <div>
            <label for="password">비밀번호:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div>
            <label for="passwordConfirm">비밀번호 확인:</label>
            <input type="password" id="passwordConfirm" name="passwordConfirm" required>
        </div>
        <button type="submit">회원가입</button>
    </form>
</body>
</html>