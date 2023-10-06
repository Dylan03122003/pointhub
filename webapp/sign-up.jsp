<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign up</title>
</head>


<body>
	<jsp:include page="navbar.jsp" />


	<c:if test="${signUpStatus == 'fail'}">
		<h1>Email already existed</h1>
	</c:if>

	<form id="signupForm" action="SignUpController" method="post">
		<input type="text" name="firstName" placeholder="firstName" /> <input
			type="text" name="lastName" placeholder="lastName" /> <input
			type="email" name="email" placeholder="email" /> <input
			type="password" name="password" id="password" placeholder="password" />
		<input type="password" name="repeatedPassword" id="repeatedPassword"
			placeholder="repeated password" />
		<div id="passwordError" style="color: red; display: none;">Passwords
			do not match. Please try again.</div>
		<button type="submit">Sign up</button>
	</form>
	<script>
		document.getElementById("signupForm").addEventListener(
				"submit",
				function(event) {
					var password = document.getElementById("password").value;
					var repeatedPassword = document
							.getElementById("repeatedPassword").value;
					var passwordError = document
							.getElementById("passwordError");

					if (password !== repeatedPassword) {
						passwordError.style.display = "block"; // Display the error message
						event.preventDefault(); // Prevent the form from submitting
					} else {
						passwordError.style.display = "none"; // Hide the error message if passwords match
					}
				});
	</script>
</body>
</html>