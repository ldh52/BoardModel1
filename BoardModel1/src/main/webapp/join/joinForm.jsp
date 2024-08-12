<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Join Up Form</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script type="text/javascript">
function checkDuplicate() {
    alert('아이디 중복검사 시작');
    console.log('아이디 중복검사 시작');
    var ser = $('#joinForm').serialize();
    $.ajax({ 
        url:'checkDuplicate.jsp',
        method:'post',
        cache:false,
        data:ser,
        dataType:'json',
        success:function(res){
            alert(res.ok ? '유효한 아이디' : '사용할 수 없는 아이디'); 
            if(!res.ok) $('#uid').val(''); 
        },
        error:function(xhr,status,err){ 
            alert('에러:' + err);
        }
    }); 
}

function checkPwd() {
    var pwd = $('#pwd').val();
    var specialCharCnt = pwd.match(/[^a-zA-Z0-9]/g).length;
    alert('특수문자의 수:' + specialCharCnt);
    var smallCharCnt = pwd.match(/[a-z]/g).length;
    alert('소문자의 수:' + smallCharCnt);
}
</script>
</head>
<body>
<main>
<h3>회원가입</h3>
<form id="joinForm" action="formProc.jsp" method="post">
	<div>
		<label for="uid">아이디</label>
		<input type="text" name="uid" id="uid" value="smith">
		<button type="button" onclick="checkDuplicate();">중복검사</button>
	</div>
	<div>
		<label for="pwd">암호</label>
		<input type="password" name="pwd" id="pwd" value="smith">
		<button type="button" onclick="checkPwd();">유효성검사</button>
	</div>
</form>


</main>

</body>
</html>