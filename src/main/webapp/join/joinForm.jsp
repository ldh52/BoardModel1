<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Join Up Form</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script type="text/javascript">

$(function(){  // jQuery ready 이벤트 핸들러 함수
	console.log('DOM 오브젝트 준비됨');
	$('#pwd').blur(function(){
		checkPwd();
	});
});

function checkDuplicate(){
	console.log('아이디 중복검사 시작');
	var ser = $('#joinForm').serialize();
	$.ajax({
		url:'checkDuplicate.jsp',
		method:'post',
		cache:false,
		data:ser,
		dataType:'json',
		success:function(res){
			alert(res.ok ? '유효한 아이디':'사용할 수 없는 아이디');
			if(!res.ok) $('#uid').val('');
		},
		error:function(xhr,status,err){
			alert('에러:' + err);
		}
	});
}

function checkPwd() {  // 총길이 8자 이상(특수문자2이상, 소문자2이상, 대문자2이상)
	var pwd = $('#pwd').val();
	var len = pwd.length;
	console.log('총 길이:' + len);
	
	var specialChaCnt = (pwd.match(/[^a-zA-Z0-9]/g) || []).length;
	console.log('특수문자 수:' + specialChaCnt);
	
	var lowChaCnt = (pwd.match(/[a-z]/g) || []).length;
	console.log('소문자의 수:' + lowChaCnt);
	
	var upperChaCnt = (pwd.match(/[A-Z]/g) || []).length;
	console.log('대문자의 수:' + upperChaCnt);
	
	if(len>=8 && specialChaCnt>=2 && lowChaCnt>=2 && upperChaCnt){
		console.log('유효한 암호');
	}else{
		alert('무효한 암호');
	}
}

function onHistoryInput(){
	var hist = $('#history').val();
	//console.log('취미경력:' + hist);
	$('#histOut').val(hist);
}

function saveMember() {
	if(!confirm('이 정보를 저장하시겠어요?')) return;
	var ser = $('#joinForm').serialize();
	console.log('직렬화된 데이터:' + ser);
	$.ajax({
		url:'formProc.jsp',
		method:'post',
		cache:false,
		data:ser,
		dataType:'json',
		success:function(res){
			alert(res.saved ? "저장에 성공했습니다":"저장 실패");
		},
		error:function(xhr,status,err){
			alert('에러:' + err);
		}
	});
}
</script>
</head>
<body>
<main>
<h3>회원가입</h3>
<form id="joinForm">
	<div>
		<label for="uid">아이디</label>
		<input type="text" name="uid" id="uid" value="smith">
		<button type="button" onclick="checkDuplicate();">중복검사</button>
	</div>
	<div>
		<label for="pwd">암 호</label>
		<input type="password" name="pwd" id="pwd" value="ABcd$#12">
		<button type="button" onclick="checkPwd();">유효성검사</button>
	</div>
	<div>
		<label for="gender">성별</label>
		남<input type="radio" name="gender" id="gender" value="m">
		여<input type="radio" name="gender" id="gender" value="f">
	</div>
	<div>
		<label for="hobby">취미</label>
		게임<input type="checkbox" name="hobby" value="game">
		독서<input type="checkbox" name="hobby" value="reading">
		여행<input type="checkbox" name="hobby" value="travel">
		낚시<input type="checkbox" name="hobby" value="fishing">
		그림<input type="checkbox" name="hobby" value="drawing">
	</div>
	<div>
		<label for="history">취미 경력</label>
		<input type="range" name="history" id="history" min="0" max="100" oninput="onHistoryInput();">
		<output id="histOut"></output>
	</div>
	<div>
		<label for="age">나이</label>
		<input type="number" name="age" id="age" value="20">
	</div>
	<div>
		<label for="birth">생년월일</label>
		<input type="date" name="birth" id="birth">
	</div>
	<div>
		<label for="intro">간단한 개인소개</label>
		<textarea rows="5" cols="10" placeholder="여기에 입력..." name="intro" id="intro"></textarea>
	</div>
	<div>
		<button type="reset">취소</button>
		<button type="button" onclick="saveMember();">저장</button>
	</div>
	
</form>
</main>

</body>
</html>