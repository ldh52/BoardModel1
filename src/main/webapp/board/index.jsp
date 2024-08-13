<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Model 1 게시판</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script type="text/javascript">
function logout() {
    // 1. Confirm logout with the user
    if (confirm("로그아웃 하시겠습니까?")) {

      // 2. Make an AJAX request to the server-side logout endpoint
      $.ajax({
          url: '../join/userLogout.jsp', // Replace with your actual logout JSP file
          method: 'post',
          cache: false,
          success: function(res) {
              if (res.ok) {
                  alert('로그아웃 성공');
                  // 3. Redirect to the login page or another appropriate page
                  location.href = '../join/loginForm.jsp'; // Replace with your login page URL
              } else {
                  alert('로그아웃 실패'); 
                  // Handle logout failure (e.g., display an error message)
              }
          },
          error: function(xhr, status, err) {
              alert('에러: ' + err);
              // Handle AJAX request errors
          }
      });
  }
}

</head>
<body>
<main>
<h3>JSP개발방법론 Model 1을 사용한 게시판 프로젝트</h3>
<ul>
	<li><a href="../join/loginForm.jsp">로그인</a>
	<li><a href="javascript:logout();">로그아웃</a>
	<li><a href="boardAddForm.jsp">게시글 입력</a>
	<li><a href="boardList.jsp">글 목록</a>
</ul>
</main>
</body>
</html>