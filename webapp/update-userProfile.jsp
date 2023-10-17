
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
<link rel="stylesheet" href="css/update_profile_style.css">
<title>Insert title here</title>
</head>
<%
boolean isLoggedIn = (boolean) Authentication.isLoggedIn(request);
String username = (String) Authentication.getCurrentUsername(request);
String role = (String) Authentication.getCurrentUserRole(request);

boolean isAdmin = isLoggedIn && role.equals("admin");
%>
<body>
	<jsp:include page="navbar.jsp" />
	<div class="container">

		<div class="Left-Form">
			<form class="content" action="update-userProfile" method="post">
				<div>
					<label class="sr-only" for="InputUsername">Username</label><br>
					<input type="text" name="username">
				</div>

				<div>
					<label class="sr-only" for="InputEmail">Email</label><br> <input
						type="email" id="InputEmail" name="email">
				</div>

				<div class="name">
					<div>
						<label class="sr-only" for="InputFirstname">FirstName</label><br>
						<input type="text" id="InputFirstname" name="firstname">
					</div>

					<div>
						<label class="sr-only" for="InputLastname">LastName</label><br>
						<input type=text id="InputLastname" name="lastname">
					</div>
				</div>

				<div>
					<label class="sr-only" for="InputAbout">About</label><br> <input
						type="text" id="InputAbout" name="about">
				</div>

				<div>
					<label class="sr-only" for="InputFaceLink">Facebook</label><br>
					<input type="text" id="InputFacelink" name="facebook-link">
				</div>

				<div>
					<label class="sr-only" for="InputTwitterlink">Twitter</label><br>
					<input type="text" id="InputTwitterlink" name="twitter-link">
				</div>

				<div>
					<label class="sr-only" for="InputInstagramlink">Instagram</label><br>
					<input type="text" id="InputInstagramlink" name="about">
				</div>

				<div>
					<label class="sr-only" for="InputGithublink">Github</label><br>
					<input type="text" name="github-link">
				</div>
				<div class="location">
					<div>
						<label class="sr-only" for="InputWard">Ward</label><br> <input
							type="text" name="ward">
					</div>

					<div>
						<label class="sr-only" for="InputDistrict">District</label><br>
						<input type="text" name="district">
					</div>


					<div>
						<label class="sr-only" for="InputProvince">Province</label><br>
						<input type="text" name="province">
					</div>
				</div>

				<div class="btn-form">
					<button class="cancle" type="reset">Cancle</button>
					<button class="done" type="submit">
						<svg xmlns="http://www.w3.org/2000/svg" height="30"
							viewBox="0 -960 960 960" width="20" fill="white">
							<path
								d="M268-240 42-466l57-56 170 170 56 56-57 56Zm226 0L268-466l56-57 170 170 368-368 56 57-424 424Zm0-226-57-56 198-198 57 56-198 198Z" /></svg>
						Done
					</button>
				</div>


			</form>
		</div>
		<div class="Right-Form">
			<div class="User-Avatar">
				<img src="img/User.png" alt="">
				<!--<c:if test="<%=username != null%>">
					 <span class="username">@<%=username%></span>
				</c:if> -->
				<span>@MinhThuan</span>
			</div>

			<div class="Upload-Photo">
				<span>Upload New Photo</span>
				<div class="round">
					<input type="file">
					<svg xmlns="http://www.w3.org/2000/svg" height="30"
						viewBox="0 -960 960 960" width="30" fill="#F48023">
						<path
							d="M200-120q-33 0-56.5-23.5T120-200v-560q0-33 23.5-56.5T200-840h357l-80 80H200v560h560v-278l80-80v358q0 33-23.5 56.5T760-120H200Zm280-360ZM360-360v-170l367-367q12-12 27-18t30-6q16 0 30.5 6t26.5 18l56 57q11 12 17 26.5t6 29.5q0 15-5.5 29.5T897-728L530-360H360Zm481-424-56-56 56 56ZM440-440h56l232-232-28-28-29-28-231 231v57Zm260-260-29-28 29 28 28 28-28-28Z" /></svg>
				</div>
			</div>
		</div>


	</div>
</body>
</html>