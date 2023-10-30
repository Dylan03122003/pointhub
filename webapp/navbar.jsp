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
<link rel="stylesheet" href="css/navbar.css" />
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,200;0,300;0,400;0,500;0,600;0,700;0,800;1,100;1,200&family=Roboto:wght@100;300;400;500;700&family=Rubik:wght@300;400;500;600&display=swap"
	rel="stylesheet" />
<script src="https://kit.fontawesome.com/e28a5c6413.js"
	crossorigin="anonymous"></script>
<link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css"
	rel="stylesheet" />

<title>Insert title here</title>


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

					<li><a href="create-question.jsp"> <i
							class="bx bx-plus-circle"></i> Ask a question
					</a></li>

				</c:if>
			</ul>
		</label>

		<c:if test="<%=isLoggedIn%>">
			<div class="user-icons">
				<span class="notice-icon"><i class="fa-regular fa-bell"></i></span>
				<img src="img/<%=userPhoto%>" class="personal-icon " id="iconPhoto" />

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
		const dropdownMenu = document.getElementById("dropdown-menu");
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

		document.addEventListener("click", function(e) {
			if (!document.querySelector(".user-icons").contains(e.target)) {
				dropdownMenu.style.display = "none";
			}
		})
	</script>

</body>
</html>