<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page import="model.User"%>
<%@ page import="model.Question"%>

<%@ page import="util.Authentication"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!--  <link rel="stylesheet" href="css/navbar.css" />-->
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,200;0,300;0,400;0,500;0,600;0,700;0,800;1,100;1,200&family=Roboto:wght@100;300;400;500;700&family=Rubik:wght@300;400;500;600&display=swap"
	rel="stylesheet" />
<script src="https://kit.fontawesome.com/e28a5c6413.js"
	crossorigin="anonymous"></script>
<link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css"
	rel="stylesheet" />

<title>Insert title here</title>

<style>

@charset "UTF-8";

/* Navbar menu */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Poppins', sans-serif;
}

.navbar {
	display: flex;
	padding: 20px 30px 10px;
	justify-content: space-between;
	align-items: center;
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	background-color: #fff;
	box-shadow: 0px 5px 15px rgb(69 67 96 / 10%);
	z-index: 1;
}

.navbar .logo {
	display: flex;
	align-items: center;
	margin-left: 20px;
	color: black;
	text-decoration: none;
}

.navbar .logo .logo-img {
	display: inline-block;
}

.navbar .logo h3 {
	display: inline-block;
}

.navbar-links {
	display: flex;
	justify-content: space-around;
	align-items: center;
	margin-right: 50px;
}

.navbar-links ul {
	display: flex;
	align-items: center;
	justify-content: space-between;
	margin-right: 35px;
}

.navbar-links ul li {
	list-style-type: none;
	padding: 10px 25px;
	cursor: pointer;
	margin-right: 8px;
}

.navbar-links li a {
	text-decoration: none;
	color: black;
	font-size: 15px;
	font-weight: 400;
	display: flex;
	align-items: center;
	justify-content: center;
}

.navbar-links .navbar-icons {
	margin-right: 5px;
}

.navbar .user-icons {
	position: absolute;
	top: 57%;
	transform: translateY(-50%);
	right: 30px;
	cursor: pointer;
}

.user-icons .notice-icon {
	font-size: 16px;
	position: absolute;
	left: -35px;
	bottom: 8px;
}


.user-icons .notice-icon .notice-bell-icon:hover {
  background: none;
  border-radius: 0;
  color: #f48023;
}
.user-icons .notice-icon:hover {
	background: none;
	border-radius: 0;
	color: #f48023;
	animation-delay: 200;

}


.navbar .user-icons > .personal-icon {
	width: 40px;
	height: 40px;
	object-fit: cover;
}

.dropdown-header img {
	width: 30px;
	height: 30px;
}

/* Dropdown menu */
.navbar .personal-icon,
.dropdown-header img {
	border-radius: 50%;
	display: block;
	margin: auto;
	object-fit: cover;
}

.user-icons .dropdown-menu {
	position: absolute;
	display: none;
	right: 10px;
	top: 50px;
	background-color: #fff;
	padding: 0px 20px 8px;
	border: 1px solid #ccccccd2;
	border-radius: 5px;
}

.notice-icon {
  position: relative;
}

.notice-icon > .dropdown-menu {
  position: absolute;
  /* display: block; */
  display: none;
  z-index: 5;
}

.notice-icon > .dropdown-menu .dropdown-menu-content {
  width: 100%;
  display: block;
}

.notice-icon > .dropdown-menu li {
  transition: all 200ms ease-in-out;
  width: 100%;
  display: block;
}

.notice-icon > .dropdown-menu li:hover {
  color: #888;
}

.notice-icon > .dropdown-menu li::after {
  content: "";
  width: 0%;
  /* width: 100%; */
  height: 2px;
  background: #f48023;
  display: block;
  margin: auto;
  transition: 0.5s;
}

.notice-icon > .dropdown-menu li:hover::after {
  width: 100%;
}

/*.notice-bell-icon:hover ~ .dropdown-menu {
  display: block;
}*/

.user-icons .dropdown-menu li {
	font-weight: 400;
	padding-top: 14px;
	padding-bottom: 2px;
	list-style-type: none;
}

.user-icons .dropdown-menu li a {
	text-decoration: none;
	color: #000;
}

.dropdown-header {
	width: 100%;
	display: inline-flex;
	align-items: center;
}

.dropdown-header .dropdown-header-img {
	margin-right: 10px;
}

.dropdown-header-content h5 {
	font-weight: 500;
}

.dropdown-header .gmail {
	font-size: 12px;
}

.navbar-links .active {
	background-color: #f48023;
	border-radius: 5px;
}

.navbar-links .active a {
	color: #fff;
}

.navbar-links ul li:hover {
	background-color: #f48023;
	border-radius: 5px;
	color: #fff;
	animation-delay: 200;
}

.navbar-links ul li:hover a {
	color: inherit;
}




.toggle-button {
	position: absolute;
	display: none;
	margin-left: 20px;
	cursor: pointer;
	top: 12px;
	left: 0px;
	padding: 5px 10px;
	border-radius: 5px;
	color: #555;
	border: 1px solid #ccc;
}

.toggle-button .menu-bar {
	text-align: left;
	font-size: 22px;
	/* color: #fff; */
}

.nav-input {
	display: none;
}
.Ask-icon {
	padding-right: 5px;
}

@media screen and (max-width: 1000px) {
	.navbar {
		flex-direction: column;
		align-items: flex-start;
		padding: 0;
		padding-bottom: 10px;
		padding-top: 15px;
	}

	.navbar-links {
		display: none;
		padding-bottom: 10px;
		position: absolute;
		top: 40px;
		left: 0;
		right: 0;
		background-color: #fff;
		margin-top: 15px;
		width: 100%;
		transition: 0.2s linear;
	}

	.navbar-links ul {
		width: 100%;
		flex-direction: column;
		margin-right: 0;
	}

	.navbar-links ul li {
		margin-right: 0;
		text-align: center;
		width: 100%;
		padding: 15px 0;
		display: flex;
		justify-content: center;
		align-items: center;
	}

	.navbar .user-icons {
		top: 30px;
	}

	.navbar .logo {
		display: flex;
		align-items: center;
		margin-left: 70px;

	}

	.navbar .logo h3 {
		text-decoration: none;
		color: black;
	}

	.toggle-button {
		display: block;
		/* margin-right: 10px; */
	}

	.nav-input:checked~.navbar-links {
		display: flex;
	}
}

@media screen and (max-width: 520px) {
	.navbar .logo h3 {
		visibility: hidden;
	}
}

@keyframes fadeIn {
	from {
		opacity: 0;
	}

	to {
		opacity: 1;
	}
}
</style>

</head>

<%
boolean isLoggedIn = (boolean) Authentication.isLoggedIn(request);
String username = (String) Authentication.getCurrentUsername(request);
String role = (String) Authentication.getCurrentUserRole(request);
String userPhoto = (String) Authentication.getCurrentUserPhoto(request);
String email = (String) Authentication.getCurrentEmail(request);
boolean isAdmin = isLoggedIn && role.equals("admin");
%>

<body>
	<nav class="navbar">
		<label class="toggle-button" for="nav-mobile"> <i
			class="fa-solid fa-bars menu-bar"></i>
		</label> <a href="/PointHubWebsite" class="logo">
			<div class="logo-img">
				<img style="height: auto;" src="./img/logo_1.png" alt="" />
			</div>
			<h3 class="font-bold text-lg">PointHub</h3>
		</a> <input type="checkbox" class="nav-input" id="nav-mobile" /> <label
			class="navbar-links" for="nav-mobile">
			<ul>

				<c:if test="<%=!isLoggedIn%>">
					<li><a href="log-in.jsp">Log in</a></li>
					<li><a href="sign-up.jsp">Sign up</a></li>
				</c:if>

				<c:if test="<%=isAdmin%>">
					<li><a href="topics">Manage Topics</a></li>
					<li><a href="question-reports">Question Reports</a></li>
					<li><a href="user-list">UserList</a></li>

				</c:if>

				<c:if test="<%=isLoggedIn%>">

					<li><a href="create-question.jsp"> <i class="Ask-icon"
							class="bx bx-plus-circle"></i> Ask a question
					</a></li>

				</c:if>
			</ul>
		</label>

		<c:if test="<%=isLoggedIn%>">
			<div class="user-icons">
				<span class="notice-icon"> <i
					class="fa-regular fa-bell notice-bell-icon" id="iconBell"></i>
					<div class="dropdown-menu" id="dropdown-menu-bell">
						<ul class="dropdown-menu-content">
							<li>Notice</li>
							<li>Notice</li>
							<li>Notice</li>
						</ul>
					</div>
				</span> <img src="img/<%=userPhoto%>" class="personal-icon" id="iconPhoto" />


				<div class="dropdown-menu" id="dropdown-menu">
					<ul class="dropdown-menu-content">
						<li class="dropdown-header">
							<div class="dropdown-header-img">
								<img src="img/<%=userPhoto%>" class="personal-icon  max-w-none" />

							</div>
							<div class="dropdown-header-content">
								<h5><%=username%></h5>
								<p class="gmail"><%=email%></p>
							</div>
						</li>

						<li><a href="view-my-profile">View Profile</a></li>
						<li><a href="log-out">Logout</a></li>
					</ul>
				</div>
			</div>
		</c:if>


	</nav>
	<div style="margin-bottom: 100px"></div>
	<script>
		const iconPhoto = document.getElementById("iconPhoto");
		const iconBell = document.getElementById("iconBell");
		const dropdownMenu = document.getElementById("dropdown-menu");
		const dropdownMenuBell = document.getElementById("dropdown-menu-bell");
		const dropdownMenuContent = document
				.querySelector(".dropdown-menu-content");
		const toggleButton = document.querySelector(".toggle-button");
		const navbarLinks = document.querySelector(".navbar-links");

		iconPhoto
				.addEventListener(
						"click",
						function() {

							console.log('dm')
							dropdownMenu.style.display = dropdownMenu.style.display === "block" ? "none"
									: "block";
						});

		iconBell
				.addEventListener(
						"click",
						function() {
							dropdownMenuBell.style.display = dropdownMenuBell.style.display === "block" ? "none"
									: "block";
						});

		document.addEventListener("click", function(e) {
			if (!document.querySelector(".user-icons").contains(e.target)) {
				dropdownMenu.style.display = "none";
			}
		})
	</script>

</body>
</html>