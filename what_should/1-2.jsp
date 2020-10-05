<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>I guess I should eat...</title>
<link type="text/css" rel="stylesheet" href="resources/3.css">
<style>
@import url('https://fonts.googleapis.com/css?family=Gamja+Flower|Nanum+Gothic');
</style>
</head>
<body style="font-family: 'Nanum Gothic', sans-serif; font-size: 40px;">
<% String id = (String) session.getAttribute("id"); %>
<% String pwd = (String) session.getAttribute("pwd"); %>
<% String sid = (String) session.getAttribute("sid"); %>
<% String sname = (String) session.getAttribute("sname"); %>

<% String menu = (String) session.getAttribute("menu"); %>
<% String cost = (String) session.getAttribute("cost"); %>
<% String time = (String) session.getAttribute("time"); %>
<section>
<p id="iname" ></p>
<img id='immg' style="margin:0px;">
<p id="sname" style="margin:10px;"></p><p id="info"></p>
<input type="button" onclick="ins()" value="등록"> <input type="button" onclick="location.href='1-1.jsp'" value="다시 고르기">
<input type="button" onclick="location.href='1.jsp'" value="홈">
<div onclick="nmap()">네이버 지도 / </div><div onclick="searchlink()">검색 링크</div><br><br>
<iframe  style="border:none;" width="500" height="300" id="ma"></iframe>
</section>
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
  // Servlet에서 값을 받아온다
  var id = "<%=id %>";
  var pwd = "<%=pwd %>";
  var sid = "<%=sid %>";
  var sname = "<%=sname %>";

  var menu = "<%=menu %>";
  var cost = "<%=cost %>";
  var time = "<%=time %>";
  var user_ref = firebase.database().ref('user_profile/' + id);
	user_ref.once('value', function(snapshot) {
		var tmp = snapshot.val();
		document.getElementById("iname").innerHTML = tmp.user_name+"님을 위한 오늘의 추천 맛집은...";
	});
var user_survey = firebase.database().ref('user_survey/'+sid);
user_survey.once('value', function(snapshot) {
		    var tmp = snapshot.val();
			    document.getElementById("sname").innerHTML = tmp.sname;
			    document.getElementById("immg").src="resources/"+tmp.sname+".jpg";
			    document.getElementById("info").innerHTML = tmp.sname+"의 대표메뉴 : "+tmp.menu+"<br> 가격은 "+tmp.cost+"원이고, 식사시간은 약 "+tmp.time+"분 입니다.";
		  	
		  });
function nmap(){
	  // iframe의 src를 지정해주는 함수
	  user_survey.once('value', function(snapshot) {
		    var tmp = snapshot.val();
		    document.getElementById("ma").src="https://map.naver.com/index.nhn?query=용현동 "+tmp.sname;	// 용현동의 가게이름을 검색하여 구체적인 검색 구현
		  });
}
 function searchlink(){
	 // 새 창으로 네이버 검색창 띄워주는 함수
			  user_survey.once('value', function(snapshot) {
				    var tmp = snapshot.val();
				    window.open("https://search.naver.com/search.naver?query=용현동 "+tmp.sname);
				  });
		  }
 function ins(){
	 // 개인의 맛집으로 등록해주는 함수
	 var user_data = firebase.database().ref("user_data/"+id);
	 user_data.once('value', function(snapshot) {
    	 snapshot.forEach(function(childSnapshot) {
    		 var tmp = childSnapshot.val();
    		 user_data.update({		// 가게 이름을 user_data 속 키값으로 update
     	         user_last: sname,
     		  });
    	 });
    	 alert("맛집이 갱신되었습니다");
	        location.href="1.jsp";		// 홈으로 돌아간다
     });
    	
     }
  </script>
    
</body>
</html>