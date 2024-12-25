<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.test.join.User" %>
<%@ page import="com.test.join.UserDAO" %>

<%
    // 폼 제출 처리 (POST 요청 시)
    if (request.getMethod().equalsIgnoreCase("POST")) {
        request.setCharacterEncoding("UTF-8"); // 한글 처리

        String uid = request.getParameter("uid");
        String pwd = request.getParameter("pwd");

        // 입력값 검증
        if (uid == null || uid.trim().isEmpty() || pwd == null || pwd.trim().isEmpty()) {
            out.println("<script>alert('아이디와 암호를 모두 입력하세요.');</script>"); 
            return;
        }

        // 사용자 객체 생성
        User user = new User(uid, pwd);

        // 로그인 처리
        UserDAO dao = new UserDAO();
        boolean loginSuccess = dao.login(user); 

        if (loginSuccess) {
            // 로그인 성공 시 세션에 사용자 정보 저장
            session.setAttribute("uid", user.getUid()); // 또는 필요한 정보 추가 저장

            // 메인 페이지로 이동
            response.sendRedirect("../board/index.jsp"); 
        } else {
            // 로그인 실패 시 오류 메시지 출력
            out.println("<script>alert('로그인 실패! 아이디 또는 비밀번호를 확인하세요.');</script>");
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 폼</title>
<style type="text/css">
   #main { width:fit-content; margin:0.5em auto; padding:1em;}
   form { border:1px solid black; padding:0.5em;}
   h3 { text-align: center; }
   div:last-child { margin-top:0.3em; text-align:center; }
   label { display:inline-block; width:3em; }
</style>
</head>
<body>
<div id="main">
   <h3>로그인</h3>
   <form method="post" action="loginForm.jsp"> <%-- 폼 제출 방식 및 action 수정 --%>
      <div><label for="uid">아이디</label>
         <input type="text" name="uid" id="uid">
      </div>
      <div><label for="pwd">암호</label>
         <input type="password" name="pwd" id="pwd">
      </div>
      <div>
         <button type="reset">취소</button>
         <button type="submit">로그인</button> <%-- button 타입을 submit으로 변경 --%>
      </div>
   </form>
</div>
</body>
</html>