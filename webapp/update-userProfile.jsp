
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
<!-- <link rel="stylesheet" href="css/update_profile_style.css"> -->

<title>Update Profile</title>


<style>
body {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: "Poppins", sans-serif;
	font-family: "Roboto", sans-serif;
}

.container {
	justify-content: center;
	display: flex;
	gap: 100px;
	padding: 50px 20px;
}

.Left-Form {
	max-width: 800px;
	height: fit-content;
	padding: 30px 80px;
	background-color: #FFFFFF;
	border: 1px solid #EAEAEA;
	box-shadow: 0px 0px 5px 0px #0000000D;
	box-shadow: 2px 1px 5px 0px rgba(0, 0, 0, 0.15);

	
}

.content input {
	width: 100%;
	border: 2px solid #e2ddd9;
	border-radius: 4px;
	margin-top: 5px;
	color: #444;
	padding: 6px 10px;
	margin-bottom: 15px;
	border: 2px solid rgba(204, 204, 204, 0.5);
	border-radius: 5px;
	width: 100%;
	font-size: 16px;
	font-weight: 500;
	letter-spacing: 0.24px;
	padding: 6px 10px;
	margin-bottom: 15px;
	border: 2px solid rgba(204, 204, 204, 0.5);
	border-radius: 5px;
	width: 100%;
}

.content {
	padding: 15px;
}

.content label {
	margin-bottom: 3px;
	color: #808080;
	font-size: 17px;
	font-style: normal;
	font-weight: 600;
	letter-spacing: 0.24px;
}

.content div {
	margin-bottom: 10px;
}

.name input {
	width: 280px;
}

.name {
	display: flex;
	gap: 40px;
	text-align: center;
}

.location input {
	width: 190px;
}

.location {
	text-align: center;
	display: flex;
	gap: 15px;
}

.btn-form {
	display: flex;
	justify-content: flex-end;
	gap: 20px;
}

.btn-form button {
	border: 1px solid #EAEAEA;
	width: 95px;
	height: 35px;
	border-radius: 4px;
}

.btn-form .done {
	background-color: #F48023;
	color: white;
	display: flex;
	align-items: center;
	justify-content: center;
}

.Right-Form {
	text-align: center;
	max-width: 450px;
	height: fit-content;
	padding: 20px 20px;
	background-color: #FFFFFF;
	border: 1px solid #EAEAEA;
	box-shadow: 0px 0px 5px 0px #0000000D;
	box-shadow: 2px 1px 5px 0px rgba(0, 0, 0, 0.15);

	
}

.Right-Form .User-Avatar img {
	width: 300px;
	height: 300px;
	border-radius: 50%;
	object-fit: cover;
	border: 6px solid #eaeaea;
}

.User-Avatar {
	display: flex;
	flex-direction: column;
	align-items: center;
	text-align: center;
	padding: 10px 20px;
}

.User-Avatar span {
	font-size: 20px;
	font-weight: bold;
	margin-top: 30px;
}

.Upload-Photo {
	padding: 40px;
}

.Upload-Photo svg {
	width: 30px;
	color: #F48023;
}

.Upload-Photo button {
	background-color: #F48023;
	color: white;
	align-items: center;
	justify-content: center;
	border-radius: 4px;
	border: 1px solid #EAEAEA;
	width: 80px;
	height: 30px;
}

.Upload-Photo span {
	color: #F48023;
}

.Upload-Photo .round input[type='file'] {
	position: absolute;
	transform: scale(1);
	width: 32px;
	height: 32px;
	opacity: 0;
}

input[type=file]::-webkit-file-upload-button {
	cursor: pointer;
}

@media ( max-width : 768px) {
	.container {
		flex-direction: column;
		align-items: center;
	}
	.Right-Form {
		order: 1;
		width: 100%;
		padding: 10px;
		box-sizing: border-box;
	}
	.Left-Form {
		order: 2;
		width: 100%;
		padding: 20px;
		box-sizing: border-box;
		height: fit-content;
	}
	.Left-Form input, .Left-Form button {
		width: 100%;
		margin-bottom: 10px;
	}
	.name {
		display: block;
		text-align: start;
	}
	.location {
		display: block;
		text-align: start;
	}
	.User-Avatar img {
		width: 300px;
		height: 300px;
	}
}

@media all and (min-width: 1101px) and (max-width: 1401px) {
	.container {
		
	}
	.Right-Form {
		width: 300px;
		padding: 10px;
		box-sizing: border-box;
	}
	.Right-Form img {
		max-width: 200px;
		max-height: 200px;
		object-fit: contain;
		border: 6px solid #eaeaea;
	}
	.Left-Form {
		width: fir-content;
		padding: 20px;
		box-sizing: border-box;
	}
}

@media all and (min-width: 768px) and (max-width: 1100px) {
	.container {
		width: 100%;
	}
	.Right-Form {
		align-items: center;
		width: 200px;
		padding: 10px;
		box-sizing: border-box;
	}
	.Right-Form img {
		max-width: 150px;
		max-height: 150px;
	}
	.name, .location {
		display: block;
		text-align: start;
	}
	.name input, .location input {
		width: 100%;
	}
	.Left-Form {
		align-items: center;
		width: 500px;
		height: fit-content;
		padding: 10px;
		box-sizing: border-box;
	}
}
</style>

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
						<label for="InputLastname">LastName</label> <br> <input
							type=text id="InputLastname" name="lastname"
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
				<img id="userAvatar" src="img/<%=userProfile.getPhoto()%>" alt=""
					accept="image/*"> <span>@<%=userProfile.getLastName() + userProfile.getFirstName()%></span>
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

				<button type="submit" id="acceptButton" disabled
					style="background-color: #ccc; color: #666; cursor: not-allowed;">Accept</button>
			</form>
		</div>


	</div>

	<script>
		function displaySelectedImage() {
			// Get the <img> element and the <input> element by their IDs
			var userAvatar = document.getElementById("userAvatar");
			var fileInput = document.getElementById("fileInput");
			var acceptButton = document.getElementById("acceptButton"); // Get the "Accept" button

			// Check if a file is selected
			if (fileInput.files && fileInput.files[0]) {
				var reader = new FileReader();

				// When the file is loaded, set the src attribute of the <img> element
				reader.onload = function(e) {
					userAvatar.src = e.target.result;
					acceptButton.removeAttribute("disabled"); // Enable the "Accept" button
					acceptButton.style.backgroundColor = ""; // Remove the background color
					acceptButton.style.color = ""; // Remove the text color
					acceptButton.style.cursor = ""; // Remove the cursor style
				};

				// Read the selected file as a data URL
				reader.readAsDataURL(fileInput.files[0]);
			} else {
				acceptButton.setAttribute("disabled", "true"); // Disable the "Accept" button

			}
		}
	</script>

</body>
</html>