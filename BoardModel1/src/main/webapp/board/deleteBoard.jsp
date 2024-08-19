<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> 
<script type="text/javascript">
    function deleteBoard(bnum) {
        if (confirm("정말 삭제하시겠습니까?")) {
            $.ajax({
                url: 'deleteBoardProc.jsp', // 게시글 삭제 처리 JSP 페이지 URL
                method: 'post',
                data: { bnum: bnum },
                dataType: 'json',
                success: function(res) {
                    if (res.deleted) {
                        alert('삭제 성공');
                        location.href = 'boardList.jsp'; // 게시글 목록 페이지로 이동
                    } else {
                        alert('삭제 실패: ' + res.message); // 오류 메시지 표시
                    }
                },
                error: function(xhr, status, err) {
                    alert('에러: ' + err);
                }
            });
        }
    }
</script>

<%-- 이 페이지는 실제로 화면에 표시되는 내용은 없고, JavaScript 함수만 포함합니다. --%>