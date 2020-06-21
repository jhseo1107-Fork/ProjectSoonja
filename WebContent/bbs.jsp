<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="org.json.simple.parser.ParseException" %>
<%@ page import="java.io.Reader" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="kr.kro.jhseo1107.Pathstring" %>
<%
String path = Pathstring.path;
JSONParser parser = new JSONParser();
Reader reader= new FileReader(path+"/userlist.json");
JSONObject object = new JSONObject();
object = (JSONObject) parser.parse(reader);
JSONArray userarray = (JSONArray) object.get("users");
Iterator<String> iterator = userarray.iterator();
response.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");
String outputstring1= "";
while(iterator.hasNext())
{
	String tmp = iterator.next();	
	Reader reader2 = new FileReader(path+"/"+tmp+".json");
	JSONObject object2 = new JSONObject();
	object2= (JSONObject) parser.parse(reader2);
	String name = (String) object2.get("nickname");
	outputstring1 = outputstring1 + ("<br> <a href='users.jsp?userID="+tmp+"'>"+name+"</a>");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>Project: Soonja | 유저 목록</title>
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="index.jsp">Project: Soonja</a>
		</div>
		<div class="collapse navbar-collapse" id ="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="bbs.jsp">유저 목록</a></li>
				<li><a href="login.jsp">로그인</a></li>
				<li><a href="register.jsp">회원가입</a></li>
			</ul>
		</div>
	</nav>
	<div class="container">
		<h1 style="text-align : center;"> 대화하고자 하는 사람을 선택하세요! </h1>
		<div style="text-align : center;"><img src="img/img1.png" width="600px"></div>
		<h3 style="text-align : center;"><%= outputstring1%></h3>
	</div>
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>