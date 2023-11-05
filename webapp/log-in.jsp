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
<!--<link rel="stylesheet" type="text/css" href="css/log_in_style.css"> -->
<style>
@charset "UTF-8";

@import
	url('https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;900&display=swap')
	;

html {
	font-family: Robto;
}

body {
	background-color: rgb(250, 250, 250);
	margin: 0;
}

* {
	box-sizing: border-box;
	font-family: 'Roboto';
}

.login-form {
	margin-top: -30px; 
	display: flex;
	text-align: center;
	justify-content: space-between;
	align-items: center;
	min-height: 80vh;
	font-family: Roboto;
}

.login-form img {
	width: 60%;
	height: 93vh;
	object-fit: cover;
}

.login {
	padding: 0 30px;
	min-width: 400px;
	margin: auto;
	width: 400px;
}

.login h2 {
	font-size: 24px;
	font-weight: 900;
	letter-spacing: 1.2px;
	text-transform: capitalize;
}

.login p {
	font-size: 18px;
	text-align: left;
	font-weight: 300;
	line-height: 30px;
	/* 166.667% */
	letter-spacing: 0.9px;
}

.form-group {
	position: relative;
	margin-bottom: 17px;
}

.login label {
	font-weight: 300;
	font-size: 14px;
	position: absolute;
	color: gray;
	padding: 0 10px;
	left: 5px;
	top: 50%;
	transform: translateY(-50%);
	letter-spacing: 0.04em;
	pointer-events: none;
	transition: all 0.3s ease-in-out;
}

.form-group input {
	width: 100%;
	height: 40px;
	outline: none;
	border-radius: 5px;
	border: 1px solid var(--Border, #EAEAEA);
	background: #FFF;
	border-radius: 5px;
	padding: 10px 10px 0 15px;
	font-size: 15px;
	transition: all 0.3s ease-in-out;
}

.form-group input:focus+label, .form-group input:valid+label {
	top: 9px;
	font-size: 9px;
	background-color: #fff;
}

#btn-login {
	font-size: 15px;
	margin-top: 13px;
	width: 100%;
	height: 40px;
	color: white;
	font-weight: 600;
	border: none;
	padding: 12px 0px 11px 0px;
	border-radius: 5px;
	background: var(--Primary-2, #F48023);
}

.login input:hover {
	border: 1.3px solid #f4783b;
}

#btn-login:hover {
	opacity: 0.5;
}

.login-form #error {
	color: red;
}

@media ( min-width : 1440px) {
	.login-form img {
		width: 63%;
		height: 95vh;
	}
	.login {
		width: 400px;
	}
	.login {
		padding: 0 30px;
		min-width: 480px;
		margin: auto;
		width: 500px;
	}
	.login h2 {
		font-size: 28px;
	}
	.login p {
		font-size: 20px;
	}
	.form-group {
		margin-bottom: 22px;
	}
	.login label {
		font-size: 16px;
	}
	.form-group input {
		font-size: 18px;
		height: 52px;
	}
	.form-group input:focus+label, .form-group input:valid+label {
		top: 10px;
		font-size: 12px;
	}
	#btn-login {
		height: 52px;
		font-size: 18px;
		margin-top: 13px;
	}
}

@media ( max-width : 900px) {
	.login-form img {
		width: 40%;
	}
}

@media ( max-width : 650px) {
	.login-form img {
		display: none;
	}
}

@media ( max-width : 430px) {
	.login-form {
		padding: 20px;
	}
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
				<h4 id="error" style="color: red;">Incorrect email or password!</h4>
			</c:if>
			<button id="btn-login" type="submit">Log in</button>
		</form>
	</div>



</body>
</html>