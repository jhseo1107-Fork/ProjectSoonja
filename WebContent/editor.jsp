<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="org.json.simple.parser.ParseException" %>
<%@ page import="java.io.Reader" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="kr.kro.jhseo1107.Register" %>
<%@ page import="kr.kro.jhseo1107.Pathstring" %>
<%@ page import="java.io.File" %>
<% 
String path = Pathstring.path;
JSONParser parser = new JSONParser();
String idgot = request.getParameter("userID");
String pwgot = request.getParameter("userPW");

File checkingfile = new File(path+"\\"+idgot+".json");
if(!checkingfile.exists())
{
	response.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");

	PrintWriter out2 = response.getWriter();

	out2.write("<script>");
	out2.write("alert('존재하지 않는 id입니다.'); window.location.href='login.jsp';");
	out2.write("</script>");
	return;
}

Reader reader= new FileReader(path+"\\"+idgot+".json");
JSONObject object;
object = (JSONObject) parser.parse(reader);
String nickname = (String) object.get("nickname");
String text = (String) object.get("text");
String pw = (String) object.get("pw");
String hashedpw = Register.sha256(pwgot);

if(!pw.equals(hashedpw))
{
	response.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");

	PrintWriter out2 = response.getWriter();

	out2.write("<script>");
	out2.write("alert('암호가 잘못되었습니다.'); window.location.href='login.jsp';");
	out2.write("</script>");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>Project: Soonja | 에디터</title>
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
		<form method="post" action="/ProjectSoonja/Edit">
					<h2 style="text-align: center;">Editor</h2>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="Nickname" name="userName" maxlength="25" value="<%=nickname%>">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="Text" name="userText" maxlength="500" value="<%=text%>">
					</div>
					<input type='hidden' name='userID' value=<%= idgot %>>
					<input type="submit" class="btn btn-primary form-control" value="저장">
				</form>
		</div>
	</div>
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>