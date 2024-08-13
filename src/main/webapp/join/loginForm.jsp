<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script type="text/javascript">
   function login() {
      var uid = document.querySelector("#uid").value;   // Document Object Model(DOM)
      var pwd = document.querySelector("#pwd").value;
      if(uid=="" || pwd=="") {
         alert('아이디, 암호를 확인해주세요');
         return false;
      } // /* */
      
      var obj = {};
      obj.cmd = 'login';
      obj.uid = uid;
      obj.pwd = pwd;
      
      $.ajax({
         url:'userLogin.jsp',
         method:'post',
         cache:false,
         data:obj,
         dataType:'json',
         success:function(res) {
            alert(res.ok ? '로그인 성공':'로그인 실패');
            if(res.ok) location.href='../board/index.jsp';
         },
         error:function(xhr,status,err){
            alert('에러:' + err);
         }
      });
      return false;
   }
</script>
</head>
<body>
<div id="main">
   <h3>로그인</h3>
   <form>
      <div><label for="uid">아이디</label>
         <input type="text" name="uid" id="uid">
      </div>
      <div><label for="pwd">암호</label>
         <input type="password" name="pwd" id="pwd">
      </div>
      <div>
         <button type="reset">취소</button>
         <button type="button" onclick="login()">로그인</button>
      </div>
   </form>
</div>
</body>
</html>