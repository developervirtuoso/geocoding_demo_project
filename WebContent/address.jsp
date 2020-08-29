<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Example</title>
  <script type="text/javascript"
          src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDCGttZaWrzVST_g_pOCUGU53-83WRbkD4"></script>
  <script src="https://unpkg.com/location-picker/dist/location-picker.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <style type="text/css">
    #map {
      width: 100%;
      height: 480px;
    }
  </style>
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

<body>
<input id="authkey" type="hidden" value="abccc">

<div id="typelocation">

</div>
<br>
<div id="map"></div>
<br>
<button id="confirmPosition">Confirm Position</button>
<br>
<p>On idle position: <span id="onIdlePositionView"></span></p>
<p>On click position: <span id="onClickPositionView"></span></p>
<script>
  // Get element references
  var confirmBtn = document.getElementById('confirmPosition');
  var onClickPositionView = document.getElementById('onClickPositionView');
  var onIdlePositionView = document.getElementById('onIdlePositionView');
  var map = document.getElementById('map');

  // Initialize LocationPicker plugin
  var lp = new locationPicker(map, {
    setCurrentPosition: true, // You can omit this, defaults to true
    lat: 45.5017,
    lng: -73.5673
  }, {
    zoom: 15 // You can set any google map options here, zoom defaults to 15
  });

  // Listen to button onclick event
  confirmBtn.onclick = function () {
    // Get current location and show it in HTML
    var location = lp.getMarkerPosition();
    onClickPositionView.innerHTML = 'The chosen location is ' + location.lat + ',' + location.lng;
    var latlang=location.lat + ',' + location.lng;
   // alert(latlang);
	$.ajax({
		url: "fetchAddress.jsp?latandlong="+latlang,
		type: 'GET',
		data: null,
		success: function(data) {
		//	alert(data);
		document.getElementById("typelocation").innerHTML=data;
		sendNotification(latlang);
		}
		});
	
    
  };

  // Listen to map idle event, listening to idle event more accurate than listening to ondrag event
  google.maps.event.addListener(lp.map, 'idle', function (event) {
    // Get current location and show it in HTML
    var location = lp.getMarkerPosition();
    onIdlePositionView.innerHTML = 'The chosen location is ' + location.lat + ',' + location.lng;
  });
</script>

<script>
function getAddressValue(){
	
	//alert("m woekinggggg");
	var latandlong=document.getElementById('onClickPositionView').value;
	//alert(latandlong);
	$.ajax({
		url: "fetchAddress.jsp?latandlong="+latandlong,
		type: 'GET',
		data: null,
		success: function(data) {
		document.getElementById("address").value=data;
		}
		});
	
	
}
</script>

<script>
 
  var tblUsers = document.getElementById('tbl_users_list');
  var databaseRef = firebase.database().ref('users/');

  var rowIndex = 1;
  var rowIndex1 = 1;
 
  databaseRef.orderByKey().endAt("pterodactyl").on("value", function(snapshot) {
//  alert(snapshot.);
 snapshot.forEach(function(childSnapshot) {
  var childKey = childSnapshot.key;
  var childData = childSnapshot.val();
  var row = tblUsers.insertRow(rowIndex1);
  var cellId = row.insertCell(0);
  var cellName = row.insertCell(1);
  cellId.appendChild(document.createTextNode(childKey));
  cellName.appendChild(document.createTextNode(childData.auth_key));
//  alert(childData.user_name);
//   rowIndex = rowIndex + 1;
   });
 

});
 
 
  databaseRef.once('value', function(snapshot) {

  });

  function sendNotification(i){
 

 var datavalue=i;
var auth_key=document.getElementById('authkey').value;addressvalue
var addressvalue=document.getElementById('addressvalue').value;

 
  var uid = firebase.database().ref().child('users').push().key;
 
  var data = {
		  datavalue:datavalue,
		  addressvalue:addressvalue
		 
 }
 
  var updates = {};
  updates['/users/' + auth_key] = data;
  firebase.database().ref().update(updates);
 
//  alert('notification is sent successfully!');
 // reload_page();
 }


 </script>
</body>
</html>