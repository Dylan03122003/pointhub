<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sign up</title>
<!--  <link rel="stylesheet" href="css/signup_style.css">-->

<style>
@charset "UTF-8";

@import
	url('https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;900&display=swap')
	;

body {
	background-color: rgb(250, 250, 250);
	margin: 0;
}

* {
	box-sizing: border-box;
	font-family: 'Roboto';
}

.register-form {
	margin-top: -30px; 
	display : flex;
	text-align: center;
	justify-content: center;
	align-items: center;
	min-height: 80vh;
	font-family: Roboto;
	display: flex;
}

.register-form img {
	width: 60%;
	height: 93vh;
	object-fit: cover;
}

.register {
	padding: 40px 30px 0;
	min-width: 400px;
	margin: auto;
	width: 400px;
}

.register h2 {
	text-align: center;
	font-size: 24px;
	font-weight: 900;
	letter-spacing: 1.2px;
	text-transform: capitalize;
}

.register p {
	color: #000;
	font-size: 18px;
	text-align: left;
	font-style: normal;
	font-weight: 300;
	line-height: 30px;
	/* 166.667% */
	letter-spacing: 0.9px;
}

.form-group {
	position: relative;
	margin-bottom: 17px;
}

.register label {
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

#btn-register {
	font-size: 15px;
	margin-top: 13px;
	width: 100%;
	height: 40px;
	color: white;
	background-color: #f4783b;
	font-weight: 600;
	border: none;
	border-radius: 5px;
	padding: 12px 0px 11px 0px;
	border-radius: 5px;
	border-radius: 5px;
	background: var(--Primary-2, #F48023);
}

.register input:hover {
	border: 1.3px solid #f4783b;
}

#btn-register:hover {
	opacity: 0.5;
}

.register-form .error {
	color: red;
	font-size: 13px;
	/* text-align:center; */
	margin: 0;
	margin-bottom: 13px;
	margin-left: 2px;
}

@media ( min-width : 1440px) {
	.register-form img {
		width: 63%;
		height: 96vh;
	}
	.register {
		width: 400px;
	}
	.register {
		padding: 0 30px;
		min-width: 480px;
		margin: auto;
		width: 500px;
	}
	.register h2 {
		font-size: 28px;
	}
	.register p {
		font-size: 20px;
	}
	.form-group {
		margin-bottom: 22px;
	}
	.register label {
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
	#btn-register {
		height: 52px;
		font-size: 18px;
		margin-top: 13px;
	}
}

@media ( max-width : 900px) {
	.register-form img {
		width: 40%;
	}
}

@media ( max-width : 700px) {
	.register-form img {
		display: none;
	}
}

@media ( max-width : 400px) {
	.register-form {
		/* padding: 20px; */
		width: 390px;
		box-sizing: border-box;
	}
}
</style>

</head>


<body>
	<jsp:include page="navbar.jsp" />


	<div class="register-form">
		<img src="img/signup.jpg" alt="">

		<form class="register" id="signupForm" action="SignUpController"
			method="post">
			<h2>Join Our Website</h2>
			<p>Get more features and priviliges by joining to the most
				helpful community</p>
			<div class="form-group">
				<input type="text" name="firstName" required> <label>First
					Name</label>
			</div>
			<div class="form-group">
				<input type="text" name="lastName" required> <label>Last
					Name</label>
			</div>
			<div id="email" class="form-group">
				<input type="email" name="email" required> <label>Email</label>
			</div>
			<c:if test="${signUpStatus == 'fail'}">
				<script>
					function emailError() {
						var email = document.getElementById("email");
						email.style.margin = "0";
					}
					emailError();
				</script>
				<p class="error">* Email already existed.</p>
			</c:if>
			<div class="form-group">
				<input type="password" name="password" id="password" required>
				<label>Password</label>
			</div>
			<div id="password-note" class="form-group">
				<input type="password" name="repeatedPassword" id="repeatedPassword"
					required> <label>Repeat password</label>
			</div>
			<p class="error" id="passwordError" style="display: none;">*
				Passwords do not match. Please try again.</p>
			<button id="btn-register" type="submit">Sign up</button>
		</form>
	</div>
	<script>
		document.getElementById("signupForm").addEventListener(
				"submit",
				function(event) {
					var password = document.getElementById("password").value;
					var repeatedPassword = document
							.getElementById("repeatedPassword").value;
					var passwordError = document
							.getElementById("passwordError");
					var passInput = document.getElementById("password-note");

					if (password !== repeatedPassword) {
						passwordError.style.display = "block"; // Display the error message
						passInput.style.margin = "0";
						event.preventDefault(); // Prevent the form from submitting
					} else {
						passwordError.style.display = "none"; // Hide the error message if passwords match
					}
				});
	</script>
</body>
</html>