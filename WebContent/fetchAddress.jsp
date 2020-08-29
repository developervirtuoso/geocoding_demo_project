
<%@page import="org.json.JSONObject"%>
<%@page import="com.mashape.unirest.http.Unirest"%>
<%@page import="com.mashape.unirest.http.JsonNode"%>
<%@page import="com.mashape.unirest.http.HttpResponse"%>
<%
String latlang=request.getParameter("latandlong");
System.out.println("latlangg=="+latlang);
HttpResponse<JsonNode> response2=Unirest.get("https://maps.googleapis.com/maps/api/geocode/json?latlng="+latlang+"&key=AIzaSyDCGttZaWrzVST_g_pOCUGU53-83WRbkD4")
.asJson();

String jsonData=response2.getBody().toString();
System.out.println("jsonData=="+jsonData);
JSONObject data=new JSONObject(jsonData);
JSONObject items=data.getJSONObject("plus_code");

System.out.println("address=="+items.getString("compound_code"));

%>
<input type="hidden" id="addressvalue" value="<%=items.get("compound_code")%>">
