<%@page import="model.Question"%>
<%@page import="model.Topic"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="css/style.css" />
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,200;0,300;0,400;0,500;0,600;0,700;0,800;1,100;1,200&family=Roboto:wght@100;300;400;500;700&family=Rubik:wght@300;400;500;600&display=swap"
	rel="stylesheet" />
<script src="https://kit.fontawesome.com/e28a5c6413.js"
	crossorigin="anonymous"></script>
<!-- <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script> -->
<link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css"
	rel="stylesheet" />

<script src="https://cdn.tailwindcss.com"></script>
<title>Pointhub</title>

<style>
.active-page {
	color: red
}
</style>
</head>

<%
ArrayList<Question> questions = (ArrayList<Question>) request.getAttribute("question_list");
ArrayList<Topic> topics = (ArrayList<Topic>) request.getAttribute("topics");
String activeTopic = (String) request.getAttribute("activeTopic");
%>

<body>
	<jsp:include page="navbar.jsp" />

	<div class="right-small-container">
		<div class="category category-container" style="padding-top: 40px">
			<c:forEach var="topic" items="<%=topics%>">
				<a href="questions?activeTopic=${topic.getTopicName()}"
					class="${topic.getTopicName().equals(activeTopic) ? 'active-topic' : ''}">${topic.getTopicName()}</a>
			</c:forEach>
		</div>

		<div class="list-question">
			<c:forEach var="question" items="<%=questions%>">

				<a
					href="<c:url value='/question-detail'>
                      <c:param name='question_id' value='${question.getQuestionID()}' />
                      <c:param name='user_id' value='${question.getUserID()}' />
                  </c:url>"
					class="question-item">
					<div class="question-author">
						<img src="img/${question.getUserPhoto()}" />
						<div class="question-author-name">
							<h4>${question.getUsername()}</h4>
							<p>${question.getCreatedAt()}</p>
						</div>
					</div>

					<div class="question-content">
						<h3 class="text-gray-700 font-medium ">${question.getTitle()}</h3>
						<p>${question.getQuestionContent()}</p>
					</div>

					<div class="question-category">

						<c:forEach var="tag" items="${question.getTagContents()}">
							<span>${tag}</span>
						</c:forEach>
					</div>
				</a>
			</c:forEach>



			<div class="flex items-center justify-center gap-6"
				style="margin-bottom: 100px; text-align: center;">
				<c:choose>
					<c:when test="${currentQuestionPage > 1}">
						<a
							href="questions?activeTopic=${activeTopic}&page=${currentQuestionPage - 1}"
							class="bg-orange-400 text-white px-3 py-1 rounded-md"> <i
							class="fa-solid fa-arrow-left"></i> <span class="ml-1">Previous</span></a>
					</c:when>
					<c:otherwise>
						<a href="#"
							class="bg-gray-100 text-gray-400 px-3 py-1 rounded-md cursor-not-allowed">
							<i class="fa-solid fa-arrow-left"></i> <span class="ml-1">Previous</span>
						</a>
					</c:otherwise>
				</c:choose>
				<div class="flex items-center justify-center gap-5 flex-wrap">
					<c:forEach var="i" begin="1" end="${totalQuestionPages}">
						<a href="questions?activeTopic=${activeTopic}&page=${i}"
							class="flex items-center justify-center border border-solid  rounded-md w-8 h-8 ${i == currentQuestionPage ? 'bg-orange-100 text-orange-500 border-orange-400' : 'text-gray-500 border-gray-400'}">${i}
						</a>
					</c:forEach>
				</div>

				<c:choose>
					<c:when test="${currentQuestionPage < totalQuestionPages}">
						<a
							href="questions?activeTopic=${activeTopic}&page=${currentQuestionPage + 1}"
							class="bg-orange-400 text-white px-3 py-1 rounded-md">  <span class="mr-1">Next</span> <i
							class="fa-solid fa-arrow-right"></i></a>
					</c:when>
					<c:otherwise>
						<a href="#"
							class="bg-gray-100 text-gray-400 px-3 py-1 rounded-md cursor-not-allowed">
							 <span class="mr-1">Next</span> <i class="fa-solid fa-arrow-right"></i>
						</a>
					</c:otherwise>
				</c:choose>
			</div>

		</div>


	</div>



</body>
</html>