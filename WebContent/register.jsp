<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>Project: Soonja | 회원가입</title>
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expand
				ed="false">
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
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
				<form method = "post" action="/ProjectSoonja/Register">
					<h2 style="text-align: center;">회원가입</h2>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="ID" name="userID" maxlength="25">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="PW" name="userPW" maxlength="25">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="별명" name="userName" maxlength="25">
					</div>
					<input type="submit" class="btn btn-primary form-control" value="회원가입">
				</form>
			</div>
		</div>
	</div>
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>