<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sign up</title>
<link rel="stylesheet" href="css/signup_style.css">
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