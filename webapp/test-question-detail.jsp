<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


	<h1>Question Detail</h1>

	<c:if test="${not empty questionDetail}">
		<h2>${questionDetail.getTitle()}</h2>
	</c:if>

	<!-- Display existing comments -->
	<div id="comments-container">
		<!-- Existing comments are displayed here -->
	</div>

	<!-- Load more comments button -->
	<button id="load-more-button"
		data-question-id="<%=session.getAttribute("currentQuestionID")%>">Load
		More Comments</button>


	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="js/question-detail-test-script.js"></script>
</body>
</html>