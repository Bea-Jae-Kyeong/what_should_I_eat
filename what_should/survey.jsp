<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>restaurant</title>
<style>
body{
margin:10px;
 background-color:whitesmoke;
}
table{
text-align:center;
}
</style>
</head>
<body>
	<script src="https://www.gstatic.com/firebasejs/5.5.8/firebase.js"></script>
	<script>
		// Initialize Firebase
		var config = {
			apiKey : "AIzaSyCWqVgDijqgISMDjFq6JC3SLMIOS_-MSOo",
			authDomain : "project-232136452420793699.firebaseapp.com",
			databaseURL : "https://project-232136452420793699.firebaseio.com",
			projectId : "project-232136452420793699",
			storageBucket : "project-232136452420793699.appspot.com",
			messagingSenderId : "825867590408"
		};
		var app = firebase.initializeApp(config);
	</script>
	<script>
		allUResdata();
		var user_survey = firebase.database().ref('user_survey');

		var data = new Array();
		user_survey.on('value', function(snapshot) {
			data.splice(0, data.length);
			snapshot.forEach(function(childSnapshot) {
				var childData = childSnapshot.val();
				data.push(childData.sid);
			});
		});
		function survey() {
			var sid = document.getElementById("sid").value;
			var sname = document.getElementById("sname").value;
			var menu = document.getElementById("menu").value;
			var genre = document.getElementById("genre").value;
			var flour_ = document.getElementsByName("flour");
			var meat_ = document.getElementsByName('meat');
			var size_ = document.getElementsByName("size");
			var time = document.getElementById("time").value;
			var cost = document.getElementById("cost").value;
			var soup_ = document.getElementsByName('soup');
			var user_survey = firebase.database().ref('user_survey/' + sid);

			var size, meat, soup, flour="";
			for(var i=0;i<size_.length;i++){
				if(size_[i].checked){
					size=size_[i].value;
				}
			}
			for(var i=0;i<meat_.length;i++){
				if(meat_[i].checked){
					meat=meat_[i].value;
				}
			}
			for(var i=0;i<soup_.length;i++){
				if(soup_[i].checked){
					soup=soup_[i].value;
				}
			}
			for(var i=0;i<flour_.length;i++){
				if(flour_[i].checked){
					flour+=flour_[i].value;
				}
			}

			
			if (document.getElementById("sid").disabled) {		// 가게 정보 등록
				user_survey.set({
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
				alert("맛집 등록이 완료되었습니다");
				location.href = "survey.jsp";
			} else {
				alert("가게이름 중복 확인을 눌러주세요");
			}
		}

		function mycheck() {
			var sid = document.getElementById("sid").value;
			var checked = 0;

			data.forEach(function(tmp) {
				if (tmp == sid) {
					alert("이미 입력된 가게 입니다");
					checked = 1;
				}
			});
			if (checked == 0) {
				alert("새로운 가게 입니다");
				document.getElementById("sid").disabled = true;
			}
		}
		function dele_click(sid){		// 가게 삭제
			var x = confirm("삭제하시겠습니까?");
			if(x){
				alert("가게 id:"+ sid);
				var user_survey = firebase.database().ref('user_survey/'+sid);
				user_survey.remove();
				alert("변경 완료");
				location.href="admin.jsp";
			}
			else{
				
			}
		}
		function revi_click(sid){		// 가게 수정
			var user_survey = firebase.database().ref('user_survey/'+sid);
			user_survey.once('value', function(snapshot) {
		      snapshot.forEach(function(childSnapshot) {
		        	location.href="sProfile.jsp?sid="+sid;
		      });
		    });
		}
		function allUResdata() {
			var user_survey = firebase.database().ref('user_survey');
			user_survey.once('value', function(snapshot) {
				snapshot.forEach(function(childSnapshot) {
					var tmp = childSnapshot.val();
					allResdata(tmp.sid);
				});
			});
		}
		function allResdata(sid) {		// 등록된 모든 가게의 정보 불러오기
			tb = document.getElementById("ssurvey");
			var user_survey = firebase.database().ref('user_survey/' + sid);
			user_survey.once('value', function(snapshot) {
				var tmp = snapshot.val();

				newtr = document.createElement("tr");
				
				td_sid = document.createElement("td");
				td_sid.innerHTML = tmp.sid;
				newtr.appendChild(td_sid);

				td_sname = document.createElement("td");
				td_sname.innerHTML = tmp.sname;
				newtr.appendChild(td_sname);
				
				td_menu = document.createElement("td");
				td_menu.innerHTML = tmp.menu;
				newtr.appendChild(td_menu);
				
				td_genre = document.createElement("td");
				td_genre.innerHTML = tmp.genre;
				newtr.appendChild(td_genre);

				td_flour = document.createElement("td");
				td_flour.innerHTML = tmp.flour;
				newtr.appendChild(td_flour);

				td_meat = document.createElement("td");
				td_meat.innerHTML = tmp.meat;
				newtr.appendChild(td_meat);

				td_size = document.createElement("td");
				td_size.innerHTML = tmp.size;
				newtr.appendChild(td_size);

			      td_time = document.createElement("td");
			      td_time.innerHTML = tmp.time;
			      newtr.appendChild(td_time);
			      
				td_cost = document.createElement("td");
				td_cost.innerHTML = tmp.cost;
				newtr.appendChild(td_cost);

				td_soup = document.createElement("td");
				td_soup.innerHTML = tmp.soup;
				newtr.appendChild(td_soup);

			      rev_b = document.createElement("input");
			      rev_b.setAttribute("type", "button");
			      rev_b.setAttribute("onclick", "revi_click('"+sid+"')");
			      rev_b.setAttribute("value", "수정");
			      newtr.appendChild(rev_b);
			      
				del_b = document.createElement("input");
				del_b.setAttribute("type", "button");
				del_b.setAttribute("onclick", "dele_click('"+sid+"')");
				del_b.setAttribute("value", "삭제");
				newtr.appendChild(del_b);

				tb.appendChild(newtr);
			});
		}
	</script>
	<h3>가게정보 등록 페이지</h3>
	<form name="form2">
	가게 id : <input type="text" id="sid"> <input type="button" onclick="mycheck()" id="check" value="중복 확인"> <br>
		가게 이름 : <input type="text" id="sname" name="surname"> 
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
                                    <input type="checkbox" name="flour" value="noodle">면<br>
			고기 :<input type="radio" name="meat" value="pork" checked="checked">돼지고기 <input
			type="radio"  name="meat" value="beef">소고기 <input
			type="radio"  name="meat" value="chicken">닭고기 <input
			type="radio" name="meat" value="other">기타 <input
			type="radio"  name="meat" value="none">없음 <br>
		양 : <input type="radio"  name="size" value="1" checked="checked">넉넉했으면 좋겠다
			 <input type="radio"  name="size" value="2">적당했으면 좋겠다 
			<input type="radio" name="size" value="3">적었으면 좋겠다<br> 
			시간 : <input type="number" id="time" min="10" max="60" step="10">분 이상 <br>
		가격: <input type="number" id="cost" min="1000" max="10000" step="1000">원
		<br> 
		 국물: <input type="radio" name="soup" value="1" checked="checked">있다
<input type="radio" name="soup" value="2">없다<br> <br>
<input type="button" onclick="survey()" value="완료"><br><br>

		<table id="ssurvey" border=1>
			<tr>
				<td>가게 id</td>
				<td>가게 이름</td>
				<td>대표 메뉴</td>
				<td>종류</td>
				<td>밥/면</td>
				<td>고기</td>
				<td>양</td>
				<td>시간</td>
				<td>가격</td>
				<td>국물</td>
				<td>관리</td>
			</tr>
		</table>
		<br>
	</form>
</body>
</html>