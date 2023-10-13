<%@page import="model.Question"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script src="https://cdn.tailwindcss.com"></script>


<title>Pointhub</title>

<style>
/* Style for the card container */
.card-container {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	gap: 20px;
	padding: 20px;
}

/* Style for each card */
.card {
	width: 300px;
	border: 1px solid #ccc;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	border-radius: 5px;
	overflow: hidden;
	text-decoration: none;
}

/* Style for the card header (username) */
.card-header {
	background-color: #007bff;
	color: #fff;
	padding: 10px;
	text-align: center;
}

/* Style for the card body (question details) */
.card-body {
	padding: 20px;
}

/* Style for the card title (question title) */
.card-title {
	font-size: 20px;
	margin-bottom: 10px;
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
ArrayList<Question> questions = (ArrayList<Question>) request.getAttribute("question_list");
%>

<body>
	<jsp:include page="navbar.jsp" />



	<div>
		<a href="newest-questions">Newest Questions</a> <a
			href="top-questions">Top Questions</a>

	</div>

	<div class="card-container">
		<c:forEach var="question" items="<%=questions%>">
			<a
				href="<c:url value='/question-detail'>
                      <c:param name='question_id' value='${question.getQuestionID()}' />
                      <c:param name='user_id' value='${question.getUserID()}' />
                  </c:url>"
				class="card">
				<div class="card-header">${question.getUsername()}</div>
				<div class="card-body">
					<h5 class="card-title">${question.getTitle()}</h5>
					<p class="card-text">${question.getQuestionContent()}</p>
					<div class="card-tags">
						<c:forEach var="tag" items="${question.getTagContents()}">
							<div>${tag}</div>
						</c:forEach>
					</div>
				</div>
				<div class="card-footer text-muted">${question.getCreatedAt()}</div>
			</a>
		</c:forEach>
	</div>
</body>
</html>