<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>administrator</title>
<style type="text/css">
table{
text-align:center;
}
body{
margin:10px;
 background-color:whitesmoke;
}
</style>
</head>
<body><h3>
관리자 페이지</h3>
<table id="infotable" border=1>
<tr>
<td>ID</td>
<td>이름</td>
<td>학년</td>
<td>전공</td>
<td>성별</td>
<td>등록맛집</td>
<td>관리</td>
</tr>
</table>
<br>
<a href="JoinUs.jsp">회원 등록</a><br><br>
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
</table><br>
<a href="survey.jsp">가게 등록</a><br>

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
allUserdata();
function del_click(id){		// 회원 삭제
	var x = confirm("삭제하시겠습니까?");
	if(x){
		alert("id:"+ id);
		var user_data = firebase.database().ref('user_data/'+id);
		user_data.remove();
		var user_prof = firebase.database().ref('user_profile/'+id);
		user_prof.remove();
		alert("변경 완료");
		location.href="admin.jsp";
	}
	else{
		
	}
}
function rev_click(id){		// 회원 정보 수정
	var user_data = firebase.database().ref('user_data/'+id);
    user_data.once('value', function(snapshot) {
      snapshot.forEach(function(childSnapshot) {
        	location.href="Profile.jsp?user_id="+id;
      });
    });
    }

//등록된 모든 회원의 정보 불러오기
function allUserdata(){
	var user_data = firebase.database().ref('user_data');
	user_data.once('value', function(snapshot) {
	    snapshot.forEach(function(childSnapshot) {
	      var tmp = childSnapshot.val();
	      allUserProfile(tmp.user_id, tmp.last_login, tmp.user_last);
	    });
	  });
}
function allUserProfile(id, time, last){
	table = document.getElementById("infotable");
	var user_data = firebase.database().ref('user_profile/'+id);
	user_data.once('value', function(snapshot) {
	      var tmp = snapshot.val();
	      
	      new_tr = document.createElement("tr");
	      
	      td_id = document.createElement("td");
	      td_id.innerHTML = id;
	      new_tr.appendChild(td_id);
	      
	      td_name = document.createElement("td");
	      td_name.innerHTML = tmp.user_name;
	      new_tr.appendChild(td_name);
	      
	      td_grade = document.createElement("td");
	      td_grade.innerHTML = tmp.user_grade;
	      new_tr.appendChild(td_grade);

	      td_major = document.createElement("td");
	      td_major.innerHTML = tmp.user_major;
	      new_tr.appendChild(td_major);

	      td_gender = document.createElement("td");
	      td_gender.innerHTML = tmp.user_gender;
	      new_tr.appendChild(td_gender);
	      
	      td_last = document.createElement("td");
	      td_last.innerHTML = last;
	      new_tr.appendChild(td_last);
	      
	      rev_btn = document.createElement("input");
	      rev_btn.setAttribute("type", "button");
	      rev_btn.setAttribute("onclick", "rev_click('"+id+"')");
	      rev_btn.setAttribute("value", "수정");
	      new_tr.appendChild(rev_btn);
	      
	      del_btn = document.createElement("input");
	      del_btn.setAttribute("type", "button");
	      del_btn.setAttribute("onclick", "del_click('"+id+"')");
	      del_btn.setAttribute("value", "삭제");
	      new_tr.appendChild(del_btn);
	      
	      
	      table.appendChild(new_tr);
	  });
}


allUResdata();
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
function revi_click(sid){		// 가게 정보 수정
	var user_survey = firebase.database().ref('user_survey/'+sid);
	user_survey.once('value', function(snapshot) {
      snapshot.forEach(function(childSnapshot) {
        	location.href="sProfile.jsp?sid="+sid;
      });
    });
}
//등록된 모든 가게의 정보 불러오기
function allUResdata(){
	var user_survey = firebase.database().ref('user_survey');
	user_survey.once('value', function(snapshot) {
	    snapshot.forEach(function(childSnapshot) {
	      var tmp = childSnapshot.val();
	      allResdata(tmp.sid);
	    });
	  });
}
function allResdata(sid){
	tb = document.getElementById("ssurvey");
	var user_survey = firebase.database().ref('user_survey/'+sid);
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
	      rev_b.setAttribute("onclick", "revi_click('" + sid + "')");
	      rev_b.setAttribute("value", "수정");
	      newtr.appendChild(rev_b);
	      
	      del_b = document.createElement("input");
	      del_b.setAttribute("type", "button");
	      del_b.setAttribute("onclick", "dele_click('" + sid + "')");
	      del_b.setAttribute("value", "삭제");
	      newtr.appendChild(del_b);
	      
	      tb.appendChild(newtr);
	  });
}
</script>
</body>
</html>