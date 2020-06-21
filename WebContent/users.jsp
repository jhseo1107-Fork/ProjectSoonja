<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="org.json.simple.parser.ParseException" %>
<%@ page import="java.io.Reader" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="kr.kro.jhseo1107.Pathstring" %>
<% 
String path = Pathstring.path;
JSONParser parser = new JSONParser();
String id = request.getParameter("userID");
Reader reader= new FileReader(path+"/"+id+".json");
JSONObject object;
object = (JSONObject) parser.parse(reader);
String nickname = (String) object.get("nickname");
String text = (String) object.get("text");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>Project: Soonja | <%= nickname %></title>
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
		
				<h1 style="text-align: center; font-size: 55px;"><%=nickname%></h1>
				<h4 style="text-align: center; font-size: 15px;">ID : <%=id%></h4>
				<h3 style="text-align: center;"><%=text%></h3>
				<h4 style="text-align: center; font-size: 15px;">당신의 계정인가요?<a href="login.jsp">로그인 한 후 수정하세요.</a></h4>
		</div>
	</div>
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>