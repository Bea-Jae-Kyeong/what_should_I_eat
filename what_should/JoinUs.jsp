<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가입 창</title>
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
    var user_data = firebase.database().ref('user_data');

    var data = new Array();
    user_data.on('value', function(snapshot) {
      data.splice(0, data.length);
      snapshot.forEach(function(childSnapshot) {
        var childData = childSnapshot.val();
        data.push(childData.user_id);
      });
    });
    
    function signup() {		// 입력된 정보로 회원 정보 등록하는 함수
      var id = document.getElementById("id").value;
      var pw = document.getElementById("pwd").value;
      var gender= document.getElementById("gender").value;
      var name= document.getElementById("name").value;
      var major= document.getElementById("major").value;
      var grade= document.getElementById("grade").value;
      var user_data = firebase.database().ref('user_data/'+id);
      
      if(document.getElementById("id").disabled){
    	user_data.set({
          user_id: id,
          user_pwd: pw,
        });
    	myProfile(id, gender, name, major, grade);
        alert("회원가입이 완료되었습니다");
        history.back();
      } else {
        alert("아이디 중복확인을 눌러주세요");
      }

    }
    
    function myProfile(id, gender, name, major, grade){
    	var user_ref = firebase.database().ref('user_profile/'+id);
      	user_ref.set({
            user_name: name,
            user_gender: gender,
            user_major: major,
            user_grade: grade,
          });
    }

    function mycheck(){
        var id = document.getElementById("id").value;
        var checked = 0;

        data.forEach(function(tmp) {
          if(tmp==id){
            alert("이미 사용중인 아이디입니다");
            checked = 1;
          }
        });
        if(checked==0){
          alert("사용 가능한 아이디입니다");
          document.getElementById("id").disabled = true;
        }
    }
  </script>


<form name="form1" method="GET"> 
<h3>회원 가입 페이지</h3>  
  아이디 :  <input type="text" id = "id" size="20">
 <input type="button" onclick="mycheck()" id="check" value="중복확인">  <br>
  비밀번호 : <input type="password" id="pwd" name="pwd" size="20"><br>
  이름 :    <input type="text" id="name"><br>
  성별 :  	 <select id="gender">
                <option value="여" selected>여자</option>
                <option value="남">남자</option>
                </select><br>
  전공 :	 <select id="major">
               <option value="컴퓨터공학과" selected>컴퓨터공학과</option>
                <option value="전기공학과">전기공학과</option>
                <option value="전자공학과">전자공학과</option>
                <option value="정보통신공학과">정보통신공학과</option>
                <option value="기계공학과">기계공학과</option>
                </select><br>
  학년 : 	 <select id="grade">
                <option value="1" selected>1학년</option>
                <option value="2">2학년</option>
                <option value="3">3학년</option>
                <option value="4">4학년</option>
                </select><br><br>
 <input type="button" onclick="signup()" value="완료">
</form>  
</body>
</html>