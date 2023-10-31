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
<script src="https://cdn.tailwindcss.com"></script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700;900&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700&family=Roboto:wght@100;400&display=swap');

* {
	transition: 0.2s linear;
	font-family: 'Roboto', sans-serif;

}


body {
	background-color: #fff;
	margin: 0;
}

.createUser {
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 100px;
	padding-right: 100px;
	margin: auto;
	margin-top: 50px;
	background-color: #fff;
	box-sizing: border-box;
	font-family: 'Roboto', sans-serif;
	color: #808080;
	font-size: 18px;
	font-style: normal;
	font-weight: 500;
}

.createUser img {
	width: 600px;
	width: 40%;
	min-width: 500px;
	/* object-fit: cover; */

}

.createUser .heading {
	/* text-align: center; */
	font-weight: 600;
	font-size: 38px;
	margin-bottom: 40px;
	color: #ff9960;
	font-family: 'Poppins', sans-serif;
}

.createUser .row {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	margin-bottom: 10px;
}

.createUser .row .input-item {
	margin: auto;
	flex: 1 1 200px;
}

.createUser .row p {
	padding: 0;
	margin-bottom: 6px;
}

.createUser .row .input-item input {
	width: 100%;
	height: 40px;
	color: #444;
	font-size: initial;
	padding: 6px 5px;
	border-radius: 4px;
	box-sizing: border-box;
	border: 1.5px solid var(--Border, #EAEAEA);
}

.createUser .row .input-item #password {
	padding-right: 40px;

}

.createUser .row .input-item input:focus {
	outline-color: rgb(0, 0, 0);
}

.createUser .row .role-item {
	margin: auto;
	flex: 1 1 100px;
}

.createUser .row .role-item select {
	/*	max-width: 200px;*/
	width: 100%;
	height: 40px;
	padding: 4px 5px;
	border-radius: 5px;
	border: 1.5px solid var(--Border, #EAEAEA);
	font-size: initial;
	color: #444;
	font-style: normal;
}

.createUser .btn {
	margin: 40px 0;
	padding-bottom: 2px;
	display: flex;
	gap: 46px;
	justify-content: flex-end;
}

.createUser .btn button {
	width: max-content;
	cursor: pointer;
	border: none;
	font-size: 16px;
	padding: 11px 24px;
	display: inline-flex;
	align-items: center;
	letter-spacing: 0.24px;
	border-radius: 5px;
}

.createUser .btn button:hover {
	opacity: 0.7;
}

.createUser .btn #btn-cancel {
	color: #808080;
	font-weight: 400;
	letter-spacing: 0.24px;
	background-color: #EAEAEA;
}

.createUser .btn #btn-submit {
	color: #FFF;
	font-weight: 700;
	background: #F48023;
}

.createUser .btn #btn-submit svg {
	margin-right: 12px;
}

.password-item {
	position: relative;
}

.password-item i {
	right: 10px;
	bottom: 10px;
	position: absolute;
	display: block;
}

.password-item .fa-eye {
	display: none;
}

.createUser .noteError {
	color: red;
}

@media (max-width: 850px) {
	.createUser {
		box-sizing: border-box;
		padding-right: 0;
		padding: 30px;
	}

	.createUser form {
		margin: 0 30px;
		position: absolute;
	}

	.createUser .heading {
		text-align: center;
	}

	.createUser #background {
		opacity: 0.2;
	}
}

@media (max-width: 500px) {
	.createUser {
		padding-top: 100px;
	}

	.createUser .heading {
		font-size: 32px;
		font-weight: 700;
	}

	.createUser form {
		top: -60px;
		left: 5px;

	}

	.createUser .row {
		gap: 8px;
	}

	.createUser {
		font-size: 16px;
	}

	.createUser .heading {
		margin-top: 200px;
	}

	.createUser #background {
		width: 100%;
		min-width: 375px;
		object-fit: cover;
	}
}

</style>

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