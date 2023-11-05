<%@page import="DAO.TopicDAO"%>
<%@page import="model.Topic"%>
<%@page import="DAO.TagDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!-- CSS STYLE -->
<!--  <link rel="stylesheet" href="css/create_question_style.css" />-->

<!-- FONTS -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,200;0,300;0,400;0,500;0,600;0,700;0,800;1,100;1,200&family=Roboto:wght@100;300;400;500;700&family=Rubik:wght@300;400;500;600&display=swap"
	rel="stylesheet" />


<!-- ICONS -->
<script src="https://kit.fontawesome.com/e28a5c6413.js"
	crossorigin="anonymous"></script>
<link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css"
	rel="stylesheet" />

<style>
</style>


<title>Post Edit</title>

<style>
@import
	url('https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700;900&display=swap')
	;

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: "Poppins", sans-serif;
	font-family: "Roboto", sans-serif;
}

.container {
	display: flex;
	align-items: center;
	justify-content: center;
	margin-top: -30px;
	/*padding-top: 20px;*/
	padding-bottom: 30px;
}

.small-container {
	height: fit-content;
	/* margin-top: 50px; */
	margin: 0 5px;
	max-width: 800px;
	background: #fff;

	/* overflow: hidden; */
}

/*==============================================================*/
/*----------------------- Form -----------------------*/
.content {
	padding: 40px;
}

.content select, .content input {
	display: block;
	width: 100%;
	margin-bottom: 15px;
	border: 2px solid rgba(204, 204, 204, 0.5);
	font-size: 16px;
	font-weight: 500;
	letter-spacing: 0.24px;
}

.content select, .content input, .content textarea {
	color: #444;
	padding: 6px 10px;
	margin-bottom: 15px;
	border: 2px solid rgba(204, 204, 204, 0.5);
	border-radius: 5px;
	width: 100%;
	font-size: 16px;
	font-weight: 500;
	letter-spacing: 0.24px;
}

.content label {
	display: block;
	margin-bottom: 3px;
	color: #808080;
	font-size: 17px;
	font-style: normal;
	font-weight: 600;
	letter-spacing: 0.24px;
}

.content label i {
	display: inline-block;
	font-size: 10px;
	color: red;
	padding-left: 4px;
}

.content select {
	background-color: transparent;
	font-size: 16px;
}

.content select option {
	display: block;
	background-color: transparent;
	color: black;
	max-width: 100px;
}

.content input::placeholder, #second-input::placeholder {
	color: rgb(141, 141, 141);
	font-size: 16px;
}

#second-input {
	position: relative;
	border: 2px solid rgba(204, 204, 204, 0.5);
	border-radius: 5px;
	width: 100%;
}

#second-input::placeholder {
	position: absolute;
	top: 10px;
}

.btn-toggle {
	display: flex;
	justify-content: right;
	margin-top: 20px;
}

.btn {
	text-align: right;
	background-color: #f48023;
	border: none;
	outline: none;
	padding: 6px 10px;
	font-size: 18px;
	color: #fff;
	border-radius: 5px;
	cursor: pointer;
}

.btn:hover {
	box-shadow: 0px 0px 15px 5px rgb(144, 144, 144, 0.5);
}

.btn i {
	margin-right: 10px;
	transform: rotate(-45deg);
}

@media screen and (min-width: 451px) {
	.container {
		background-color: rgba(204, 204, 204, 0.2);
	}
	.small-container, .content {
		width: 100%;
	}
	.small-container {
		margin: 80px 50px 0;
	}
}
</style>
</head>

<%
ArrayList<Topic> topics = new TopicDAO().getTopics();
%>

<body>
	<jsp:include page="navbar.jsp" />

	<div class="container">
		<div class="small-container">
			<form class="content" action="create-question" method="post">
				<label>Your topic<i class="fa-solid fa-star-of-life"></i></label> <select
					required="required" name="questionTopic" id="">
					<option value="">Choose one topic</option>
					<c:forEach var="topic" items="<%=topics%>">
						<option value="${topic.getTopicID()}">${topic.getTopicName()}</option>
					</c:forEach>
				</select>
				<div class="input-item">
					<label>Your title<i class="fa-solid fa-star-of-life"></i></label> <input
						required="required" name="title" type="text"
						placeholder="Type catching attention title" />
				</div>
				<label>Your tag<i class="fa-solid fa-star-of-life"></i>
				</label> <input required="required" name="tags" type="text"
					placeholder="Type tags (comma-separated)" /> <label>Your
					question<i class="fa-solid fa-star-of-life"></i>
				</label>
				<textarea required="required" name="question_content"
					id="second-input" cols="86" rows="10"
					placeholder="Type your question"></textarea>

				<label>Your code</label>
				<textarea name="code_block" id="secorond-input" cols="86" rows="10"
					placeholder="Paste your code"></textarea>

				<div class="btn-toggle">
					<button class="btn" type="submit">
						<i class="bx bx-send"></i>Publish
					</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>

