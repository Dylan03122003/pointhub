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
%>
<body data-userprofileid="<%=user.getUserID()%>"
	data-currentuserid="<%=currentUserID%>">
	<jsp:include page="navbar.jsp" />

	<div class="viewProfile">
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
					<a href="<%=user.getFacebookLink()%>"><i
						class="fa-brands fa-facebook"></i></a> <a
						href="<%=user.getTwitterLink()%>"><i
						class="fa-brands fa-square-x-twitter"></i></a> <a
						href="<%=user.getInstagramLink()%>"><i
						class="fa-brands fa-instagram"></i></a> <a
						href="<%=user.getGithubLink()%>"><i
						class="fa-brands fa-github"></i></a>
				</div>
				<div class="stats stats1">
					<span> <i class="fa-regular fa-circle-question"></i> <span><%=user.getTotalQuestions()%></span>
						Questions
					</span> <span> <i class="fa-solid fa-user-group"></i> <span
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
				</span> <span> <i class="fa-solid fa-user-group"></i> <span
					id="followers-sum"><%=user.getNumberOfFollowers()%> </span>
					Followers
				</span>
			</div>

		</div>

		<div class="body-item">
			<div class="profile-nav">
				<ul>
					<li id="about-nav" data-target="about" class="cursor-pointer"><a href=""
						class="nav-link "></a>About</li>
					<li id="posts-nav" data-target="question" class="cursor-pointer"><a href=""
						class="nav-link"></a>Posts</li>
					<li id="bookmarks-nav" data-target="bookmark" class="cursor-pointer"><a href=""
						class="nav-link"></a>Bookmarks</li>
				</ul>
			</div>
			<div class="content" id="about">
				<p>
					<%=user.getAbout()%>
				</p>
			</div>

			<div class="content" id="question">
				<div class="card-container"></div>
				<div class="flex items-center pb-[10px] justify-center"><button class="load-more-post-btn flex flex-col justify-center pl-[10px] pr-[10px] text-[13px] font-bold items-center text-orange-500 mt-[5px] rounded-lg" type="button">See More<svg xmlns="http://www.w3.org/2000/svg" height="20" fill="orange" viewBox="0 -960 960 960" width="24"><path d="M480-345 240-585l56-56 184 184 184-184 56 56-240 240Z"/></svg></button>
				</div>
			</div>
			<div class="content" id="bookmark">
				<div class="card-bookmark-container"></div>
<div class="flex items-center pb-[10px] justify-center"><button class="load-more-bookmark-btn flex  flex-col justify-center pl-[10px] pr-[10px] text-[13px] font-bold items-center text-orange-500 mt-[5px] rounded-lg" type="button">See More<svg xmlns="http://www.w3.org/2000/svg" height="20" fill="orange" viewBox="0 -960 960 960" width="24"><path d="M480-345 240-585l56-56 184 184 184-184 56 56-240 240Z"/></svg></button>
				</div>			</div>
		</div>
	</div>
</body>


</html>