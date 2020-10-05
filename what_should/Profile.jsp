<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
var id = getParameterByName('user_id');
function getParameterByName(name) {
  name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
  var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"), results = regex.exec(location.search);
  return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

var user_ref = firebase.database().ref('user_profile/' + id);
user_ref.once('value', function(snapshot) {		// 원래 정보 불러오기
	var tmp = snapshot.val();
	document.getElementById("name").value=tmp.user_name;
	document.getElementById("gender").value=tmp.user_gender;
	document.getElementById("major").value=tmp.user_major;
	document.getElementById("grade").value=tmp.user_grade;
});

    function rset() {
	var name= document.getElementById("name").value;
      var gender= document.getElementById("gender").value;
      var major= document.getElementById("major").value;
      var grade= document.getElementById("grade").value;
      
      var user_data = firebase.database().ref('user_data');
      user_data.once('value', function(snapshot) {
        snapshot.forEach(function(childSnapshot) {
          var tmp = childSnapshot.val();
          if(tmp.user_id==id){
        	  var user_ref = firebase.database().ref('user_profile/'+id);
        	  user_ref.update({		// update로 값 수정
            	  user_name: name,
                  user_gender: gender,
                  user_major: major,
                  user_grade: grade,
              });
        	  alert("수정이 완료되었습니다");
              history.back();
          }
        });
      });
    }
  </script>

<h3>개인정보 수정 페이지</h3>
<form>
   이름 : <input type="text" id="name"><br>
  성별 : <select id="gender">
                <option value="여" selected>여자</option>
                <option value="남">남자</option>
                </select><br>
  전공 :  <select id="major">
                <option value="컴퓨터공학과" selected>컴퓨터공학과</option>
                <option value="전기공학과">전기공학과</option>
                <option value="전자공학과">전자공학과</option>
                <option value="정보통신공학과">정보통신공학과</option>
                <option value="기계공학과">기계공학과</option>
                </select><br>
  학년 :   <select id="grade">
                <option value="1" selected>1학년</option>
                <option value="2">2학년</option>
                <option value="3">3학년</option>
                <option value="4">4학년</option>
                </select><br><br>
 <input type="button" onclick="rset()" value="완료">
</form>  
</body>
</html>