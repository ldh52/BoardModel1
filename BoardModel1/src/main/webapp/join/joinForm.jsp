<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.test.join.MemberVO" %>
<%@ page import="com.test.join.UserDAO" %>

<%
    // 폼 제출 처리 (POST 요청 시)
    if (request.getMethod().equalsIgnoreCase("POST")) {
        request.setCharacterEncoding("UTF-8"); 

        // 폼 데이터 가져오기
        String uid = request.getParameter("uid");
        String pwd = request.getParameter("pwd");
        String gender = request.getParameter("gender");
        String[] hobbies = request.getParameterValues("hobby");
        String sHistory = request.getParameter("history");
        String sAge = request.getParameter("age");
        String sBirth = request.getParameter("birth");
        String intro = request.getParameter("intro");

        // 입력값 검증
        if (uid == null || uid.trim().isEmpty() || pwd == null || pwd.trim().isEmpty() 
                || gender == null || hobbies == null || sHistory == null || sAge == null || sBirth == null) {
            out.println("<script>alert('필수 입력 항목을 모두 입력하세요.'); history.back();</script>");
            return;
        }

        // MemberVO 객체 생성 및 데이터 설정
        MemberVO m = new MemberVO();
        m.setUid(uid);
        m.setPwd(pwd); // 실제 운영 환경에서는 비밀번호 암호화 필요
        m.setGender(gender);
        m.setHobby(hobbies);
        
        try {
            m.setHistory(sHistory);
            m.setAge(sAge);
            m.setBirth(sBirth);
        } catch (Exception e) {
            out.println("<script>alert('잘못된 입력 형식입니다.'); history.back();</script>");
            return;
        }

        m.setIntro(intro);

        // 회원 정보 저장
        UserDAO dao = new UserDAO();
        boolean saved = dao.saveMember(m);

        if (saved) {
            response.sendRedirect("main.jsp"); 
        } else {
            out.println("<script>alert('회원 가입에 실패했습니다.'); history.back();</script>");
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Join Up Form</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> 
<script type="text/javascript">
$(function(){ 
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

function checkPwd() { 
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
	$('#histOut').val(hist);
}
</script>
</head>
<body>
<main>