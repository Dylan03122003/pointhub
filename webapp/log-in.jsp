<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<!-- <link rel="stylesheet" href="css/login_style.css">
 -->
<link rel="stylesheet" type="text/css" href="css/log_in_style.css">
<style>
html {
	font-family: Robto;
}
</style>
</head>
<body>

	<jsp:include page="navbar.jsp" />

	<div class="login-form">
	<img alt="" src="img/login.jpg">
		<form class="login" action="LogInController" method="post">
			<h2>We've Missed You!</h2>
			<p>More than 150 questions are waiting for your wise suggestions!</p>
			<div class="form-group">
				<input type="email" name="email" required> <label>Email</label>
			</div>
			<div class="form-group">
				<input id="password" type="password" name="password" required>
				<label>Password</label>
			</div>
			<c:if test="${loginStatus == 'fail'}">
				<h4 id="error" style="color: red;">Incorrect email or
					password!</h4>
			</c:if>
			<button id="btn-login" type="submit">Log in</button>
		</form>
	</div>



</body>
</html>