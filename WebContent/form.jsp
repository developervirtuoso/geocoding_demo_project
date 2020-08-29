<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
 <script src="https://www.gstatic.com/firebasejs/4.9.0/firebase.js"></script>
<script>
  // Your web app's Firebase configuration
  var firebaseConfig = {
    apiKey: "AIzaSyDozCMZrsKLxcCxFc_WNg53RnNC2_WmmwE",
    authDomain: "loationpicker.firebaseapp.com",
    databaseURL: "https://loationpicker.firebaseio.com",
    projectId: "loationpicker",
    storageBucket: "loationpicker.appspot.com",
    messagingSenderId: "829169346555",
    appId: "1:829169346555:web:8f098bf279b78579384d5e",
    measurementId: "G-3772YNQDFP"
  };
  // Initialize Firebase
  firebase.initializeApp(firebaseConfig);
  firebase.analytics();
</script>
</head>
<body onload="deleteEntry()">
<%
String authkey3="abccc";
%>
<form action="">
<label>Address:-</label>:-<input type="text" id="address_value" style="width:32%"placeholder="type your address or fetch from map by clicking the button next to this">
<span><button onclick="openMap()">open map</button></span><br>
<span><button onclick="deleteEntry()">Reset</button>

</form>
</body>
<script>
function openMap(){
	window.open("http://localhost:8852/geocoding_google/address.jsp", "myWindow", 'width=800,height=600');
	//window.close();	
}

</script>
<script>
 

  var databaseRef = firebase.database().ref('users/<%=authkey3%>/');
  databaseRef.on('value', function(snapshot) {
	  
    snapshot.forEach(function(childSnapshot) {
   var childKey = childSnapshot.key;
   var childData = childSnapshot.val();
   if(childKey=='addressvalue'){
	   

	  // alert(childData);
	   document.getElementById('address_value').value=childData;
   }
  
 /*  var row = tblUsers.insertRow(rowIndex);
   var cellId = row.insertCell(0);
   var cellName = row.insertCell(1);
   cellId.appendChild(document.createTextNode(childKey));
   cellName.appendChild(document.createTextNode(childData.user_name));
   
   rowIndex = rowIndex + 1;*/
    });
  });

  
  
  function reload_page(){
   window.location.reload();
  }
  
 </script>
 <script>
 function deleteEntry(){
	   firebase.database().ref('users/<%=authkey3%>/').remove();

 }
 </script>
</html>