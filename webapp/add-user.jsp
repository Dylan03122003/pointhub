<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="css/add_user_style.css">

</head>
<%
String addStatus = (String) request.getAttribute("createStatus");
%>
<style>
.createUser .noteError {
	color: red;
}
</style>
<body>
	<jsp:include page="navbar.jsp" />

	<div class="createUser">
		<img id="background"
			src="https://i.pinimg.com/564x/ee/e2/79/eee279c7d9b4c4e5fc060a9f9bb61c5f.jpg"
			alt="" srcset="">
		<form action="create-user" id="create-user" method="get">
			<h1 class="heading">User Information</h1>
			<div class="row">
				<div class="input-item">
					<p>First name</p>
					<input type="text" name="firstName" required>
				</div>
				<div class="input-item">
					<p>Last name</p>
					<input type="text" name="lastName" required>
				</div>
			</div>
			<div class="row">
				<div class="role-item">
					<p>Role</p>
					<select name="role" id="role">
						<!-- <option value="">Role</option> -->
						<option value="user">user</option>
						<option value="admin">admin</option>
					</select>
				</div>
				<div class="input-item">
					<p>Email</p>
					<input type="email" name="email" required>
				</div>
			</div>
			<div class="row">
				<div class="input-item">
					<p>Password</p>
					<div class="password-item">
						<input id="password" type="password" name="pass" required>
						<i data="password" class="fa-regular fa-eye" onclick="hide(event)"></i>
						<i data="password" class="fa-regular fa-eye-slash"
							onclick="deleteHide(event)"></i>
					</div>
				</div>
				<div class="input-item">
					<p>Repeat pasword</p>
					<div class="password-item">
						<input id="repeatPassword" type="password" required> <i
							data="repeatPassword" class="fa-regular fa-eye reOpenEye"
							onclick="hide(event)"></i> <i data="repeatPassword"
							class="fa-regular fa-eye-slash reCloseEye"
							onclick="deleteHide(event)"></i>
					</div>
				</div>
			</div>
			<c:if test="<%=addStatus != null%>">
					<p class="noteError">* <%=addStatus%></p>
				</c:if>
				<p class="error noteError" id="passwordError" style="display: none;">*
					Passwords do not match. Please try again.</p>
			<div class="btn">
				<button id="btn-cancel" type="reset">Cancel</button>
				<button id="btn-submit" type="submit">
					<svg xmlns="http://www.w3.org/2000/svg" width="13" height="14"
						viewBox="0 0 13 14" fill="none">
                        <path d="M11.9167 1.58337L5.95834 7.54171"
							stroke="white" stroke-linecap="round" stroke-linejoin="round" />
                        <path
							d="M11.9167 1.58337L8.125 12.4167L5.95834 7.54171L1.08334 5.37504L11.9167 1.58337Z"
							stroke="white" stroke-linecap="round" stroke-linejoin="round" />
                    </svg>
					Add User
				</button>
			</div>
		</form>
	</div>
	<script>
		/*  add eye hide password */
		let password = document.getElementById('password');
		let rePass = document.getElementById('repeatPassword');
		let openEye = document.querySelector('.fa-eye');
		let reOpenEye = document.querySelector('.reOpenEye');
		let closeEye = document.querySelector('.fa-eye-slash');
		let reCloseEye = document.querySelector('.reCloseEye');

		function deleteHide(element) {
			// console.log(password.type);
			console.log(element.target.getAttribute('data'));
			let data = element.target.getAttribute('data');
			if (data == "password") {
				password.type = "text";
				closeEye.style.display = "none";
				openEye.style.display = "block";
			} else {
				rePass.type = "text";
				reCloseEye.style.display = "none";
				reOpenEye.style.display = "block";
			}

		}
		function hide(element) {
			// console.log(password.type);
			console.log(element.target.getAttribute('data'));
			let data = element.target.getAttribute('data');
			if (data == "password") {
				password.type = "password";
				closeEye.style.display = "block";
				openEye.style.display = "none";
			} else {
				rePass.type = "password";
				reCloseEye.style.display = "block";
				reOpenEye.style.display = "none";
			}
		}
		/* add check pass  */

		document.getElementById("create-user").addEventListener(
				"submit",
				function(event) {
					var password = document.getElementById("password").value;
					var repeatedPassword = document
							.getElementById("repeatPassword").value;
					var passwordError = document
							.getElementById("passwordError");
					if (password !== repeatedPassword) {
						passwordError.style.display = "block"; // Display the error message
						event.preventDefault(); // Prevent the form from submitting
					} else {
						passwordError.style.display = "none"; // Hide the error message if passwords match
					}
/* 					event.preventDefault();
 */				});
	</script>
</body>
</html>