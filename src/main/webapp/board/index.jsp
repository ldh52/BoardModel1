<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Model 1 게시판</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

<script type="text/javascript">
function logout() {
    if (confirm("로그아웃 하시겠습니까?")) {
        $.ajax({
            url: '../join/userLogout.jsp', 
            method: 'post',
            dataType: 'json', // 서버에서 JSON 형식으로 응답을 받도록 설정
            cache: false,
            success: function(res) {
                if (res.ok) { // 서버에서 'ok'라는 속성으로 성공 여부를 전달한다고 가정
                    alert('로그아웃 성공');
                    location.href = '../join/loginForm.jsp'; 
                } else {
                    alert('로그아웃 실패: ' + res.message); // 서버에서 에러 메시지를 전달한다고 가정
                }
            },
            error: function(xhr, status, err) {
                alert('에러: ' + err);
            }
        });
    }
}

function editBoard(bnum) {
    location.href = "boardEditForm.jsp?bnum=" + bnum; 
}

function deleteBoard(bnum) {
    if (confirm("정말 삭제하시겠습니까?")) {
        $.ajax({
            url: 'deleteBoard.jsp',
            method: 'post',
            data: { bnum: bnum },
            dataType: 'json',
            success: function(res) {
                if (res.deleted) {
                    alert('삭제 성공');
                    location.reload(); // 페이지 새로고침
                } else {
                    alert('삭제 실패');
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
    <h3>JSP개발방법론 Model 1을 사용한 게시판 프로젝트</h3>
    <ul>
        <li><a href="../join/loginForm.jsp">로그인</a></li> 
        <li><a href="javascript:logout();">로그아웃</a></li> 
        <li><a href="boardList.jsp">글 목록</a></li> 
        <li><a href="boardAddForm.jsp">게시글 입력</a></li> 
        <li><a href="javascript:editBoard(bnum);">게시글 수정</a></li> 
        <li><a href="javascript:deleteBoard(bnum);">게시글 삭제</a></li>  
    </ul>
</main>
</body>
</html>