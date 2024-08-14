<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필</title>
</head>
<body>
    <h2>${user.userId}님의 프로필</h2>
    <a href="/user/edit">프로필 수정</a>
    <form action="/user/delete" method="post">
        <button type="submit">회원 탈퇴</button>
    </form>
    <a href="/board/list">게시판 목록</a>
</body>
</html>