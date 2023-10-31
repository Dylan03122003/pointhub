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
<link rel="stylesheet" href="css/user_profile.css">
<script defer="defer" type="module" src="js/user-profile.js"></script>
<script src="https://cdn.tailwindcss.com"></script>

<title>Document</title>
</head>

<%
User user = (User) request.getAttribute("userProfile");
boolean isCurrentUser = (boolean) request.getAttribute("isCurrentUser");
int currentUserID = (int) Authentication.getCurrentUserID(request);
ArrayList<Notification> notifications = new NotificationDAO().getNotifications(currentUserID);
%>
<body data-userprofileid="<%=user.getUserID()%>"
	data-currentuserid="<%=currentUserID%>">
	<jsp:include page="navbar.jsp" />


	<!-- Notifications ------------------------------------------------------------------------->
	<div class="bg-blue-100 m-2">
		<h2 class="text-red-300">Cái này test thôi</h2>
		<c:forEach var="notification" items="<%=notifications%>">
			<p>${notification.getMessage()}</p>
			<p>${notification.getCreatedAt()}</p>
		</c:forEach>
	</div>
	<!--END Notifications ------------------------------------------------------------------------->

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
				<span id="contact"> <i class="fa-solid fa-phone"></i> Contact
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
					</span> <span id="followers-sum-container" class="cursor-pointer"> <i class="fa-solid fa-user-group"></i> <span
						id="followers-sum"><%=user.getNumberOfFollowers()%> </span>
						Followers
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