<!DOCTYPE html> 
<html>
<head>
<meta charset="UTF-8">
<title>게시글 입력</title>

<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

<script type="text/javascript">
function saveBoard() {
    if (!confirm('작성된 글을 저장하시겠습니까?')) return;

    var formData = $('#addForm').serialize(); // 폼 데이터 직렬화

    $.ajax({
        url: 'addFormProc.jsp',
        method: 'post',
        cache: false,
        data: formData, // 직렬화된 폼 데이터 전송
        dataType: 'json',
        success: function(res) {
            alert(res.saved ? '작성 성공' : '작성 실패');
            if (res.saved) {
                location.href = "boardDetail.jsp?bnum=" + res.bnum;
            }
        },
        error: function(xhr, status, err) {
            alert('에러: ' + err);
        }
    });
}
</script>
</head>
<body>
<main>
    <h3>게시물 입력</h3>
    <form id="addForm">
        <div>
            <label for="title">제목</label>
            <input type="text" name="title" id="title" value="Just Test">
        </div>

        <div>
            <label for="contents">내용</label>
            <textarea name="contents" id="contents" rows="5" cols="20" placeholder="여기에 작성"></textarea> 
        </div>

        <div>
            <button type="reset">취소</button>
            <button type="button" onClick="saveBoard();">저장</button>
        </div>
    </form>
</main>
</body>
</html>