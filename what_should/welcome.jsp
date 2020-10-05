<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>welcome</title>
</head>

<script src="https://www.gstatic.com/firebasejs/5.5.8/firebase.js"></script>
<script>
  // Initialize Firebase
  var config = {
    apiKey: "AIzaSyCWqVgDijqgISMDjFq6JC3SLMIOS_-MSOo",
    authDomain: "project-232136452420793699.firebaseapp.com",
    databaseURL: "https://project-232136452420793699.firebaseio.com",
    projectId: "project-232136452420793699",
    storageBucket: "project-232136452420793699.appspot.com",
    messagingSenderId: "825867590408"
  };
  var app = firebase.initializeApp(config);
</script>
  <script>
  function gosignup() {		// 회원 가입
      location.href="JoinUs.jsp";
    }
  
  function myjsplogin() {
      var id = document.getElementById("id").value;
      var pw = document.getElementById("pwd").value;
	  var user_data = firebase.database().ref('user_data');
      user_data.once('value', function(snapshot) {
        snapshot.forEach(function(childSnapshot) {
          var tmp = childSnapshot.val();
          if(tmp.user_id==id){
            if(tmp.user_pwd==pw){
              alert("로그인 성공!");		// 로그인 성공시 LoginServlet에 id와 pw 전송
              var form = document.getElementById("form1");
              form.setAttribute("action", "./LoginServlet?id="+id+"&&pwd="+pw+"");
              form.submit();
            } else {
              alert("잘못된 비밀번호입니다");
            }
          }
        });
      });
    }
  
  </script>

<form id="form1" method="POST">
 아이디 :  <input type="text" id="id" size="20px"><br>
  비밀번호: <input type="password" id="pwd" size="20px"><br><br>
 <input type="button" onclick="myjsplogin()" value="로그인">
 
 <input type="reset" onclick="gosignup()" value="회원가입"><br>
  </form>   

</body>
</html>