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
<link rel="stylesheet" href="css/create_question_style.css" />

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
<title>Post Edit</title>
</head>

<%
TagDAO tagDAO = new TagDAO();
ArrayList<String> tags = tagDAO.getAllTags();
%>

<body>
	<jsp:include page="navbar.jsp" />

	<div class="container">
		<div class="small-container">
			<form class="content" action="create-question" method="post">
				<select name="tag" id="">
					<option value="">Choose categories</option>
					<c:forEach var="tag" items="<%=tags%>">
						<option value="${tag}">${tag}</option>
					</c:forEach>
				</select> <input name="title" type="text"
					placeholder="Type catching attention title" />


				<textarea name="question_content" id="second-input" cols="86"
					rows="10" placeholder="Type your question"></textarea>

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

