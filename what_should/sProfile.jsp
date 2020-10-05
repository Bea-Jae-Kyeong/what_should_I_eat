<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Restaurant revision</title>
<style>
body{
margin:10px;
 background-color:whitesmoke;
}
</style>
</head>
<body>

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
var sid = getParameterByName('sid');
function getParameterByName(name) {
  name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
  var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"), results = regex.exec(location.search);
  return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

var user_survey = firebase.database().ref('user_survey/' + sid);
user_survey.once('value', function(snapshot) {		// 원래 정보 불러오기
	var tmp = snapshot.val();
	document.getElementById("sname").value=tmp.sname;
	document.getElementById("menu").value=tmp.menu;
	document.getElementById("genre").value=tmp.genre;
	document.getElementById("time").value=tmp.time;
	document.getElementById("cost").value=tmp.cost;
	document.getElementsByName("flour").value=tmp.flour;
	document.getElementsByName("meat").value=tmp.meat;
	document.getElementsByName("size").value=tmp.size;
	document.getElementsByName("soup").value=tmp.soup;
});

    function rset() {			// 입력된 값으로 저장하기
		var sname = document.getElementById("sname").value;
		var menu = document.getElementById("menu").value;
		var genre = document.getElementById("genre").value;
		var flour_ = document.getElementsByName("flour");
		var meat_ = document.getElementsByName("meat");
		var size_ = document.getElementsByName("size");
		var time = document.getElementById("time").value;
		var cost = document.getElementById("cost").value;
		var soup_ = document.getElementsByName("soup");
		
		var size, soup, meat, flour="";
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

		var user_survey = firebase.database().ref('user_survey/'+sid);

		user_survey.once('value', function(snapshot) {
        snapshot.forEach(function(childSnapshot) {
        	user_survey.update({		// update로 값 수정
        		sid : sid,
        		sname : sname,
        		menu : menu,
				genre : genre,
				flour : flour,
				meat : meat,
				size : size,
				time : time,
				cost : cost,
				soup : soup
              });
		});
        alert("수정이 완료되었습니다");
        location.href="admin.jsp";
		});
    }
  </script>

<h3>가게정보 수정 페이지</h3>
<form>
   가게 이름 : <input type="text" id="sname"> 
		<br>
		대표 메뉴 : <input type="text" id="menu"> 
		<br>
		종류 : <select id="genre">
			<option value="japan">일식</option>
			<option value="china">중식</option>
			<option value="korea" selected>한식</option>
			<option value="US">양식</option>
			<option value="thai">태국식</option>
			<option value="tteok">분식</option>
			<option value="snack">간식</option>
			<option value="pub">술집</option>
			<option value="else">기타</option>
		</select><br> 밥/면 : <input type="checkbox" name="flour" value="rice">밥
                                    <input type="checkbox" name="flour" value="noodle">면
                                    
			<br>고기 :<input type="radio" name="meat" value="pork" checked="checked">돼지고기 <input
			type="radio"  name="meat" value="beef">소고기 <input
			type="radio"  name="meat" value="chicken">닭고기 <input
			type="radio" name="meat" value="other">기타 <input
			type="radio"  name="meat" value="none">없음 <br>
		양 : <input type="radio"  name="size" value="1">넉넉했으면 좋겠다
			 <input type="radio"  name="size" value="2" checked="checked">적당했으면 좋겠다 
			<input type="radio" name="size" value="3">적었으면 좋겠다<br> 
			시간 : <input type="number" id="time" min="10" max="60" step="10" value="10">분 이상 <br>
		가격: <input type="number" id="cost" min="1000" max="10000" step="1000">원
		<br> 
		 국물: <input type="radio" name="soup" value="1" checked="checked">있다
<input type="radio" name="soup" value="2">없다<br> <br>
 <input type="button" onclick="rset()" value="완료">
</form>
</body>
</html>