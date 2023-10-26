
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
User userProfile = (User) request.getAttribute("userProfile");

boolean isAdmin = isLoggedIn && role.equals("admin");
%>
<body>
	<jsp:include page="navbar.jsp" />
	<div class="container">

		<div class="Left-Form">
			<form class="content" action="update-profile" method="post">

				<div>
					<label for="InputEmail">Email</label><br> <input type="email"
						id="InputEmail" name="email" value="<%=userProfile.getEmail()%>">
				</div>

				<div class="name">
					<div>
						<label for="InputFirstname">FirstName</label><br> <input
							type="text" id="InputFirstname" name="firstname"
							value="<%=userProfile.getFirstName()%>">
					</div>

					<div>
						<labelfor="InputLastname">LastName</label>
						<br>
						<input type=text id="InputLastname" name="lastname"
							value="<%=userProfile.getLastName()%>">
					</div>
				</div>

				<div>
					<label for="InputAbout">About</label><br> <input type="text"
						id="InputAbout" name="about" value="<%=userProfile.getAbout()%>">
				</div>

				<div>
					<label for="InputFaceLink">Facebook</label><br> <input
						type="text" id="InputFacelink" name="facebook-link"
						value="<%=userProfile.getFacebookLink()%>">
				</div>

				<div>
					<label for="InputTwitterlink">Twitter</label><br> <input
						type="text" id="InputTwitterlink" name="twitter-link"
						value="<%=userProfile.getTwitterLink()%>">
				</div>

				<div>
					<label for="InputInstagramlink">Instagram</label><br> <input
						type="text" id="InputInstagramlink" name="insta_link"
						value="<%=userProfile.getInstagramLink()%>">
				</div>

				<div>
					<label for="InputGithublink">Github</label><br> <input
						type="text" name="github-link"
						value="<%=userProfile.getGithubLink()%>">
				</div>
				<div class="location">
					<div>
						<label for="InputWard">Ward</label><br> <input type="text"
							name="ward" value="<%=userProfile.getWard()%>">
					</div>

					<div>
						<label for="InputDistrict">District</label><br> <input
							type="text" name="district"
							value="<%=userProfile.getDistrict()%>">
					</div>


					<div>
						<label for="InputProvince">Province</label><br> <input
							type="text" name="province"
							value="<%=userProfile.getProvince()%>">
					</div>
				</div>

				<div class="btn-form">
					<button class="cancle" type="reset">Cancel</button>
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
				<img id="userAvatar" src="img/<%=userProfile.getPhoto()%>" alt="" accept="image/*">
				<span>@<%=userProfile.getLastName() + userProfile.getFirstName()%></span>
			</div>

			<form class="Upload-Photo" action="update-photo" method="post"
				enctype="multipart/form-data">
				<span>Upload New Photo</span>
				<div class="round">
					<input type="file" name="photo" id="fileInput"
						onchange="displaySelectedImage()">
					<svg xmlns="http://www.w3.org/2000/svg" height="30"
						viewBox="0 -960 960 960" width="30" fill="#F48023">
						<path
							d="M200-120q-33 0-56.5-23.5T120-200v-560q0-33 23.5-56.5T200-840h357l-80 80H200v560h560v-278l80-80v358q0 33-23.5 56.5T760-120H200Zm280-360ZM360-360v-170l367-367q12-12 27-18t30-6q16 0 30.5 6t26.5 18l56 57q11 12 17 26.5t6 29.5q0 15-5.5 29.5T897-728L530-360H360Zm481-424-56-56 56 56ZM440-440h56l232-232-28-28-29-28-231 231v57Zm260-260-29-28 29 28 28 28-28-28Z" /></svg>
				</div>

				<button type="submit">Accept</button>
			</form>
		</div>


	</div>

	<script>
		function displaySelectedImage() {
			// Get the <img> element and the <input> element by their IDs
			var userAvatar = document.getElementById("userAvatar");
			var fileInput = document.getElementById("fileInput");

			// Check if a file is selected
			if (fileInput.files && fileInput.files[0]) {
				var reader = new FileReader();

				// When the file is loaded, set the src attribute of the <img> element
				reader.onload = function(e) {
					userAvatar.src = e.target.result;
				};

				// Read the selected file as a data URL
				reader.readAsDataURL(fileInput.files[0]);
			}
		}
	</script>

</body>
</html>