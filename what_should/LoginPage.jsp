<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<base href="<%=basePath%>">
<style>p{margin:10px;}
body{
margin:10px;
 background-color:whitesmoke;
}</style>
</head>
<body>
	<%
		String id = (String) session.getAttribute("id");
	%>
	<p id="login_id">안녕하세요 </p>
	<p id="major"></p>
	<p id="gender"></p>
	<p id="last"></p>
	<input type="button" onclick="location.href='logout.jsp'" value="로그아웃">
	<input type="button" onclick="rset()" value="개인정보 수정">
	<input type="button" onclick="rdelete()" value="탈퇴">
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
  var id = "<%=id%>";
 
	//로그인 시 개인 정보 띄우기
		var user_data = firebase.database().ref('user_data/');

		user_data.once('value', function(snapshot) {
			snapshot.forEach(function(childSnapshot) {
				var tmp = childSnapshot.val();
				if (tmp.user_id == id)
					document.getElementById("last").innerHTML = "가장 최근 등록한 가게: "+ tmp.user_last;
			});
		});

		var user_ref = firebase.database().ref('user_profile/' + id);
		user_ref.once('value', function(snapshot) {
			var tmp = snapshot.val();
			document.getElementById("login_id").innerHTML += tmp.user_name + "님";
			document.getElementById("major").innerHTML = tmp.user_major+" "+tmp.user_grade + "학년";
			document.getElementById("gender").innerHTML = "성별: "+ tmp.user_gender;
		});

		function rdelete() {
			var x = confirm("정말 탈퇴하시겠습니까?");
			if(x){
				var user_p = firebase.database().ref('user_profile/' + id);
				user_p.remove();
				var user_d = firebase.database().ref('user_data/' + id);
				user_d.remove();
				alert("탈퇴되었습니다.");
				history.back();
			}
			else{
				
			}
		}

		function rset() {
			location.href = "Profile.jsp?user_id="+id;
		}
		
	</script>
</body>
</html>