<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<base href="<%=basePath%>">
<title>Hmm..</title>
<link type="text/css" rel="stylesheet" href="resources/2.css">
<style>
@import url('https://fonts.googleapis.com/css?family=Gamja+Flower|Nanum+Gothic');
</style>
</head>
<body>
<% String id = (String) session.getAttribute("id"); %>
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

<header>
        <h1 style="font-family: 'Gamja Flower', cursive; font-size: 50px;">오늘 뭐 먹지?</h1>
         <iframe width="200" height="50" src="https://www.youtube.com/embed/BQGucZUTPsM"></iframe><p id="login_id">안녕하세요 </p> 아래의 항목을 응답하시면 후문 주변의 맛집을 추천해드려요!<br>
        </header><br>
        <form id="form2" method="POST">
                         1. 오늘의 음식은?<br>
                               <select id="genre">
               <option value="japan">일식</option>
                <option value="china">중식</option>
                <option value="korea" selected>한식</option>
                <option value="US">양식</option>
                <option value="thai">태국식</option>
                <option value="tteok">분식</option>
                <option value="snack">간식</option>
                <option value="pub">술집</option>
                <option value="else">기타</option>
                </select><br><br> 
                           2. 밥 or 면?<br>
                                    <input type="checkbox" name="flour" value="rice">밥
                                    <input type="checkbox" name="flour" value="noodle">면
                            <br><br>
                
                3. 오늘의 고기는?<br>
                        <input type="radio"  name="meat" value="pork" checked="checked">돼지고기
                        <input type="radio"  name="meat" value="beef">소고기
                        <input type="radio"  name="meat" value="chicken">닭고기
                        <input type="radio" name="meat" value="other">기타
                        <input type="radio" name="meat" value="none">없음
               <br><br>
                
                 4. 양의 정도는?<br>
                        <input type="radio"  name="size" value="1">넉넉했으면 좋겠다
                        <input type="radio" name="size" value="2" checked="checked">적당했으면 좋겠다
                        <input type="radio"  name="size" value="3">적었으면 좋겠다
               <br><br>
                
                 5. 최소 식사시간을 정해주세요<br>
                 <input type="number"  id="time" min="10" max="60" step= "10" value="10">분 이상
                <br><br>
                
                 6. 1인당 가격의 한도를 정해주세요<br>
                 <input type="number" id="cost" name="from" min="1000" max="10000" step= "1000" value="7000">원 이하
                <br><br>
                
                        7. 국물의 유무?<br>
                               <input type="radio"  name="soup" value="1" checked="checked">있다
                               <input type="radio" name="soup" value="2">없다
                       <br><br>
            
           
            <input type="button" onclick="search()" value="제출">
            <input type="reset" value="다시 하기">
        </form>
        <script>
        var id = "<%=id %>";
        var user_ref = firebase.database().ref('user_profile/' + id);
		user_ref.once('value', function(snapshot) {
			var tmp = snapshot.val();
			document.getElementById("login_id").innerHTML += tmp.user_name + "님";		// user_profile의 id를 servlet에서 받아와 이름을 출력함
		});
		
        function search() {			// 설문조사에 입력된 값을 DB에서 검색하는 함수
        	 var genre = document.getElementById("genre").value;
        	 var flour_ = document.getElementsByName("flour");
 			var meat_ = document.getElementsByName("meat");
       	 var time = document.getElementById("time").value;
 			var size_ = document.getElementsByName("size");
 			var size, soup, meat, flour="";
 			var cost = document.getElementById("cost").value;
 			var soup_ = document.getElementsByName('soup');
        	 var user_survey = firebase.database().ref('user_survey');
        	 for(var i=0;i<size_.length;i++){
 				if(size_[i].checked){
 					size=size_[i].value;
 				}
 			}
 			for(var i=0;i<soup_.length;i++){
 				if(soup_[i].checked){
 					soup=soup_[i].value;
 				}
 			}
 			for(var i=0;i<meat_.length;i++){
 				if(meat_[i].checked){
 					meat=meat_[i].value;
 				}
 			}
 			for(var i=0;i<flour_.length;i++){
 				if(flour_[i].checked){
 					flour+=flour_[i].value;
 				}
 			}
 			 user_survey.orderByChild('genre').equalTo(genre).on("child_added", function(snapshot) {	// 입력된 값과 같은 키값이 있는지 찾는다
 					var tmp = snapshot.val();
 					if(tmp.flour>=flour){
 						if(tmp.meat==meat){
 							if(tmp.size<=size){
 								if(tmp.time>=time){
 									if(tmp.cost<=cost){
 										if(tmp.soup==soup){
 											alert("성공!");				// 성공시 SurveyServlet에 id와 이름을 전송한다
 										var form = document.getElementById("form2");
 				 		                  form.setAttribute("action", "./SurveyServlet?sid="+tmp.sid+"&&sname="+tmp.sname+"");
 				 		                  form.submit();
 										}
 										
 									}
 								}
 							}
 						}
 						
 						
 					}
 					
 			});

        }
        </script>
        <footer>
            Copyright 2018 by 배재경
        </footer>
</body>
</html>