<%@page import="DAO.NotificationDAO"%>
<%@page import="model.Notification"%>
<%@page import="java.util.ArrayList"%>
<%@page import="util.Authentication"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="model.User"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<!--  link rel="stylesheet" href="css/user_profile.css">-->
<script defer="defer" type="module" src="js/user-profile.js"></script>
<script src="https://cdn.tailwindcss.com"></script>

<title>Document</title>

<style>
@charset "UTF-8";

@import
	url('https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700&family=Roboto:wght@100;400&display=swap')
	;

* {
	transition: 0.2s linear;
}

html {
	background: #FAFAFA;
	/* font-size: 62.5%; */
	font-family: 'Roboto', sans-serif;
}

.viewProfile {
	font-family: 'Roboto', sans-serif;
	position: relative;
	margin: auto;
	margin-top: 70px;
	box-sizing: border-box;
	width: fit-content;
	justify-content: center;
}

.viewProfile .profile {
	display: flex;
	flex-wrap: wrap;
	gap: 64px;
}

.viewProfile .profile img {
	width: 300px;
	height: 271px;
	width: 260px;
	height: 260px;
	flex-shrink: 0;
	object-fit: cover;
	border-radius: 35px;
	border-radius: 9999px;
}

.viewProfile .profile #username {
	font-size: 30px;
	color: #37474f;
	font-weight: 500;
	letter-spacing: 1px;
		margin-bottom: 20px;
	
}

.viewProfile .profile #contact {
	margin-top: 20px; 
	font-size : 18px;
	font-weight: 600;
	letter-spacing: 1px;
	color: #212121;
	font-size: 18px;
}

.viewProfile .profile #email {
	margin-top: 10px;
	font-size: 14px;
	color: #546e7a;
}

.viewProfile .profile #email span {
	font-weight: 600;
}

.viewProfile .profile .logo-social {
	gap: 13px;
	display: flex;
	font-size: 16px;
	margin-bottom: 30px;
	margin-top: 10px;
}

.viewProfile .profile .logo-social a {
	color: #000;
}

.viewProfile .profile .stats {
	display: flex;
	width: 600px;
	height: 70px;
	align-items: center;
	justify-content: space-around;
	background-color: #FFBF8C;
	border-radius: 25px;
}

.viewProfile .profile .stats span {
	font-weight: 600;
	display: flex;
	gap: 1rem;
	font-size: 15px;
	align-items: center
}

.viewProfile .profile .stats i {
	font-size: 18px;
}

#btn-update {
	position: absolute;
	top: 0;
	right: 0;
	color: #fff;
	text-decoration: none;
	display: block;
	font-size: 14px;
	font-weight: 600;
	padding: 12px 13px;
	letter-spacing: 0.5px;
	background-color: #F48023;
	border-radius: 5px;
}

#follow-btn {
	position: absolute;
	top: 0;
	right: 0;
	color: #fff;
	text-decoration: none;
	display: block;
	border: none;
	font-size: 14px;
	font-weight: 500;
	padding: 9px 15px;
	letter-spacing: 0.5px;
	background-color: #F48023;
	border-radius: 5px;
}

/* ------ BODY ----- */
.body-item {
	margin-top: 30px;
	width: 920px;
	border: 1px solid rgba(0, 0, 0, 0.1);
	font-size: 18px;
	border-radius: 5px;
	border-top: none;
}

.profile-nav ul {
	margin: 0;
	padding: 0;
	display: flex;
	gap: 2px;
	padding: 3px 0 0 0;
	list-style-type: none;
	background-color: #ffbf8c63;
	border-radius: 5px;
}

.profile-nav ul li {
	background-color: #FFBF8C;
	font-weight: 600;
	color: #333;
	padding: 10px 20px;
	border-radius: 3px;
	box-shadow: 0 0.5px 1.5px rgba(0, 0, 0, 0.1);
	box-shadow: 2px 1px 5px 0px rgba(0, 0, 0, 0.15);
}

.body-item .content {
	display: none;
}

.body-item #posts-nav {
	opacity: 0.5;
}

.body-item #about {
	display: block;
}

.body-item #about p {
	padding: 5px 15px;
	max-width: 850px;
	font-size: 16px;
	line-height: 30px;
	margin-left: 5px;
}

.viewProfile .profile .stats2 {
	display: none;
}

@media ( max-width : 1010px) {
	.viewProfile .profile .stats {
		width: 100%;
		min-width: 360px;
	}
	.body-item {
		width: 680px;
	}
}

@media ( max-width : 732px) {
	.viewProfile {
		margin: 10px;
	}
	.viewProfile .profile .stats1 {
		display: none;
	}
	.viewProfile .profile .stats2 {
		display: flex;
	}
	.viewProfile .content {
		margin-top: auto;
		margin-bottom: auto;
	}
	.body-item {
		width: 500px;
	}
}

@media ( max-width : 600px) {
	.viewProfile .profile {
		justify-content: center;
		text-align: center;
	}
	.viewProfile {
		margin: auto;
		padding: 10px;
	}
	.viewProfile .profile .logo-social {
		justify-content: center;
	}
	#btn-update, #follow-btn {
		right: 50px;
	}
	.body-item {
		width: 450px;
	}
	.viewProfile .profile img {
		margin-top: 33px;
	}
}

/* --------------------------------------------------------------------------------------- */
/* Style for the card container */
.card-container {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	gap: 20px;
	/* padding: 20px; */
}

.card-bookmark-container {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	gap: 20px;
	/* padding: 20px; */
}

/* Style for each card */
.card {
	width: 100%;
	border: 1px solid #ccc;
	/* border-left: 0.8rem solid #999; */
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	border-radius: 5px;
	overflow: hidden;
	text-decoration: none;
}

/* Style for the card body (question details) */
.card-body {
	padding: 15px;
}

/* Style for the card title (question title) */
.card-title {
	color: #555D7B;
	margin: 0;
	font-size: 18px;
	margin-bottom: 0.5rem;
}

/* Style for the card text (question content) */
.card-text {
	font-size: 14px;
	color: #333;
}

/* Style for the card tags (tag contents) */
.card-tags {
	font-size: 12px;
	color: #555;
	margin-top: 10px;
	display: flex;
	gap: 5px;
}

/* Style for the card footer (created date) */
.card-footer {
	background-color: #f8f8f8;
	padding: 10px;
	text-align: center;
	color: #555;
	font-size: 12px;
}
</style>
</head>

<%
User user = (User) request.getAttribute("userProfile");
boolean isCurrentUser = (boolean) request.getAttribute("isCurrentUser");
int currentUserID = (int) Authentication.getCurrentUserID(request);
%>
<body data-userprofileid="<%=user.getUserID()%>"
	data-currentuserid="<%=currentUserID%>">
	<jsp:include page="navbar.jsp" />



	<!-- Followers Modal -------------------------------------------------------------------------------------------->
	<div
		class="followers-modal fixed inset-0 z-50 overflow-auto bg-gray-500 bg-opacity-75 hidden justify-center items-center">
		<div
			class="followers-content flex flex-col justify-center items-center gap-5  bg-white w-[340px] sm:w-[500px] p-4 relative rounded-md">
			<h2 class="text-2xl text-center font-bold text-gray-600 mb-4 mt-8">Followers</h2>

			<div class="followers-container px-5 max-h-[200px] overflow-y-scroll">
				<a href="user-profile?userID=" class="flex gap-4 mb-5"> <img
					class="w-[50px] h-[50px] object-cover rounded-full" alt=""
					src="https://images.unsplash.com/photo-1698375962447-8aac6091e31b?auto=format&fit=crop&q=80&w=1965&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D">
					<div>
						<h2 class="font-medium text-gray-700">@DuongCao</h2>
						<p class="text-gray-600">duong@gmail.com</p>
					</div>
				</a>
			</div>

			<button class="view-more-followers-btn text-gray-600">View
				more</button>

			<button
				class="followers-modal-btn text-3xl text-gray-700 absolute top-4 right-4"
				data-dismiss="modal">&times;</button>
		</div>
	</div>

	<!-- Require user log in modal --------------------------------------------------------------------->
	<div
		class="require-login-modal  fixed inset-0 z-50 overflow-auto bg-gray-500 bg-opacity-75 hidden justify-center items-center">
		<div
			class="require-login-content flex flex-col justify-center items-center gap-5  bg-white w-[340px] sm:w-[600px] p-4 relative rounded-md">
			<h2 class="text-2xl text-center font-bold mb-4 mt-8">Join the
				Pointhub community</h2>
			<p class="text-gray-600 text-center">Join Pointhubto start
				earning reputation and unlocking new privileges like voting and
				commenting.</p>

			<div class="flex gap-5 mt-5">
				<a class="bg-orange-400 text-white px-4 py-1 rounded-md"
					href="log-in.jsp">Log in</a> <a
					class="bg-orange-400 text-white px-4 py-1 rounded-md"
					href="sign-up.jsp">Sign up</a>
			</div>

			<button
				class="require-login-close-btn text-3xl text-gray-700 absolute top-4 right-4"
				data-dismiss="modal">&times;</button>
		</div>
	</div>


	<div class="viewProfile flex flex-col">
		<div class="profile">
			<img alt="" src="img/<%=user.getPhoto()%>">
			<div class="content">
				<h2 id="username">
					<%=user.getUsername()%>
				</h2>
				<span id="contact"> <i class="fa-solid fa-phone text-sm"></i>
					Contact
				</span>
				<p id="email">
					<span>Email:</span>
					<%=user.getEmail()%>
				</p>
				<div class="logo-social">
					<a target="_blank" href="<%=user.getFacebookLink()%>"><i
						class="fa-brands fa-facebook"></i></a> <a target="_blank"
						href="<%=user.getTwitterLink()%>"><i
						class="fa-brands fa-square-x-twitter"></i></a> <a target="_blank"
						href="<%=user.getInstagramLink()%>"><i
						class="fa-brands fa-instagram"></i></a> <a target="_blank"
						href="<%=user.getGithubLink()%>"><i
						class="fa-brands fa-github"></i></a>
				</div>
				<div class="stats stats1">
					<span> <i class="fa-regular fa-circle-question"></i> <span><%=user.getTotalQuestions()%></span>
						Questions
					</span> <span id="followers-sum-container" class="cursor-pointer">
						<i class="fa-solid fa-user-group"></i> <span id="followers-sum"><%=user.getNumberOfFollowers()%>
					</span> Followers
					</span>
				</div>
			</div>
			<c:if test="<%=isCurrentUser%>">
				<a id="btn-update"
					href="retrieve-profile?userID=<%=user.getUserID()%>"> <i
					class="fa-regular fa-pen-to-square"></i>
				</a>
			</c:if>

			<c:if test="<%=!isCurrentUser%>">
				<button id="follow-btn"><%=user.isFollowedByCurrentUser() ? "Following" : "Follow"%></button>
			</c:if>
			<div class="stats stats2">
				<span> <i class="fa-regular fa-circle-question"></i> <span><%=user.getTotalQuestions()%></span>
					Questions
				</span> <span id="followers-sum-container"> <i
					class="fa-solid fa-user-group"></i> <span id="followers-sum"><%=user.getNumberOfFollowers()%>
				</span> Followers
				</span>
			</div>

		</div>

		<div class="body-item">
			<div class="profile-nav">
				<ul>
					<li id="about-nav" data-target="about" class="cursor-pointer"><a
						href="" class="nav-link "></a>About</li>
					<li id="posts-nav" data-target="question" class="cursor-pointer"><a
						href="" class="nav-link"></a>Posts</li>
					<c:if test="<%=isCurrentUser%>">
						<li id="bookmarks-nav" data-target="bookmark"
							class="cursor-pointer"><a href="" class="nav-link"></a>Bookmarks</li>
					</c:if>

				</ul>
			</div>
			<div class="content" id="about">
				<p>
					<%=user.getAbout()%>
				</p>
			</div>

			<div class="content" id="question">
				<div class="card-container"></div>
				<div class="flex items-center pb-[10px] justify-center">
					<button
						class="load-more-post-btn flex flex-col justify-center pl-[10px] pr-[10px] text-[13px] font-bold items-center text-orange-500 mt-[5px] rounded-lg"
						type="button">
						See More
						<svg xmlns="http://www.w3.org/2000/svg" height="20" fill="orange"
							viewBox="0 -960 960 960" width="24">
							<path d="M480-345 240-585l56-56 184 184 184-184 56 56-240 240Z" /></svg>
					</button>
				</div>
			</div>
			<div class="content" id="bookmark">
				<div class="card-bookmark-container"></div>
				<div class="flex items-center pb-[10px] justify-center">
					<button
						class="load-more-bookmark-btn flex  flex-col justify-center pl-[10px] pr-[10px] text-[13px] font-bold items-center text-orange-500 mt-[5px] rounded-lg"
						type="button">
						See More
						<svg xmlns="http://www.w3.org/2000/svg" height="20" fill="orange"
							viewBox="0 -960 960 960" width="24">
							<path d="M480-345 240-585l56-56 184 184 184-184 56 56-240 240Z" /></svg>
					</button>
				</div>
			</div>
		</div>
	</div>
</body>


</html>