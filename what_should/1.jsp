<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>What should I eat today?</title>
<link type="text/css" rel="stylesheet" href="resources/1.css">
<style>
@import url('https://fonts.googleapis.com/css?family=Gamja+Flower|Nanum+Gothic');		
</style>
</head>
<body>
<% String id = (String) session.getAttribute("id"); %>

<script>
	var adpwd= "12161595";
	
  function login_(){		// 로그인 성공시에만 다음 페이지로 이동한다

	  location.reload();
	  if(id=="null"||id==null){
	  }
	  else{
		  location.href="1-1.jsp";
	  }

	  
  }
  var id = "<%=id %>";
  function goadmin() {			// 관리자 페이지 접근
	  var ret = prompt("관리자 비밀번호를 입력하세요");
	  if(ret == adpwd){
		  alert("관리자님 안녕하세요");
		  location.href="admin.jsp";
	  }
	  else if(ret == ""||ret==null);
	  else{
		  alert("접근 불가");
	  }
    }
  
  function frm(){		
	  
	  if(id=="null"||id==null){
		  document.getElementById("ma").src="welcome.jsp";
	  }
	  else{
		  document.getElementById("ma").src="LoginPage.jsp";		// 로그인 되어있을 경우에는 로그인 창 띄워줌
	  }
  }

  // 캔버스로 시계 구현
        var cx = 100;
        var cy = 100;
        var radius = 80;
        var dial = new Image();
        dial.src="resources/thinking.png";
        window.onload = function () {
            canv = document.getElementById("myCanvas");
            ctx = canv.getContext("2d");
            clock();
            setInterval(clock, 1000);
        }
        function clock() {
            ctx.drawImage(dial,10, 10, 190, 190);
            drawRotatedRect(100, 100, 55, 2, getTime("h")/ 12* 360 + getTime("m") / 60 * 360 / 12 + getTime("s") / 60 * 360 / 60 / 12, "brown");
            drawRotatedRect(100, 100, 75, 2, getTime("m") / 60 * 360 + getTime("s") / 60 * 360 / 60, "brown");
            drawRotatedRect(100, 100, 75, 1, getTime("s") / 60 * 360, "red");
        }

        function drawRotatedRect(x, y, width, height, degrees, color) {
            ctx.save();
            ctx.beginPath();
            ctx.translate(x, y);
            ctx.rotate((degrees - 90) * Math.PI / 180);
            ctx.rect(0, -height / 2, width, height);
            ctx.fillStyle = color;
            ctx.fill();
            ctx.restore();
        }

        function getTime(str) {		// 현재 시간 리턴하는 함수
            var date = new Date();
            if (str == "h")
                return date.getHours() > 12 ? date.getHours() - 12 : date.getHours();
            else if (str == "m")
                return date.getMinutes();
            else if (str == "s")
                return date.getSeconds();
        }
  </script>
  
    <header>
    <h1 style="font-family: 'Nanum Gothic', sans-serif; font-size: 43px; margin:20px;">
    오늘 인하대에서 뭐 먹지?
    </h1>
    <p style="color: gray; margin:10px;">
    <br>수업이 끝나고, 인하대후문에서 밥을 먹기로 했는데<br>
        종류가 너무 많아 무엇을 먹을지 고민되나요?<br>
        구체적인 선택지로 정해보는 "오늘 뭐 먹지?"<br>
        당신 대신 결정해드려요!<br><br><br></p>
    </header>

    <nav style="font-family: 'Gamja Flower', cursive;">
      아.. 오늘<br>
  <a onclick="login_()">뭐 먹지?</a>
    </nav>
    <section>
    <div onclick="frm()">클릭하여 로그인</div>
<iframe width="350" height="270" id="ma" onclick="frm()"></iframe>
 <canvas id="myCanvas" width="250" height="250"></canvas></section>
 <footer>
        <br>Copyright 2018 by 12161595 배재경 <input type="button" onclick="goadmin()" value="관리자">
    </footer>
</body>
</html>