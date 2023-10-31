<%@page import="DAO.UserDAO"%>
<%@page import="model.Question"%>
<%@page import="model.Topic"%>
<%@page import="model.User"%>
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
<script defer="defer" type="module" src="js/home.js"></script>
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
String searchKey = (String) request.getAttribute("searchKey");
ArrayList<User> topFivePopularUsers = new UserDAO().getTopFivePopularUsers();
%>

<body>
	<jsp:include page="navbar.jsp" />
	<div id="toast"
		class="z-10 fixed top-20 right-0 p-4 m-4 text-white rounded-md shadow-lg hidden"></div>

	
		<!-- START TOP 5 POPULAR USERS  -------------------------------------------------------------------------------->
		<div class="popular-users" >
			<h2 style="text-align: center; font-size: 1.5rem">Top 5 popular users</h2>
			<div class="users" style="max-width: 1000px;  display: flex; justify-content: center;  flex-wrap: wrap; padding: 10px; margin-bottom: 30px; margin-inline: auto">
			<c:forEach var="user" items="<%=topFivePopularUsers%>">
				<a href="user-profile?userID=${user.getUserID()}"
				style="display: inline-block;  padding: 15px 30px"
					class="popular-user-profile"> <img alt=""
					src="img/${user.getPhoto()}"
					style="margin: auto"
					class="w-[70px] h-[70px] object-cover rounded-full">
					<div style="padding-top: 15px">
						<p style="color: #888; text-align: center">${user.getUsername()}</p>
						<p style="color: #888; text-align: center">
							<span>${user.getNumberOfFollowers()}</span> <span>followers</span>
						</p>
					</div>

				</a>
			</c:forEach>
			</div>
		</div>

		<!-- END TOP 5 POPULAR USERS  -------------------------------------------------------------------------------->


		<div class="question-area">
			<form action="questions" method="get"
				class="flex items-center justify-center  gap-3">
				<input type="hidden" name="page" value="1" /> <input type="hidden"
					name="activeTopic" value="<%=activeTopic%>" /> <input
					value="<%=searchKey%>" required="required"
					placeholder="Search questions by title or content" type="text"
					name="searchQuestionKey"
					class="w-[250px] md:w-[600px]  py-1 px-3 border-[1px] border-solid border-gray-400 rounded-md" />
				<button class="bg-orange-400 text-white px-3 py-1 rounded-md"
					type="submit">Search</button>
			</form>

			<div class="right-small-container">
				<div class="category category-container" style="padding-top: 40px">
					<c:forEach var="topic" items="<%=topics%>">
						<a
							href="questions?activeTopic=${topic.getTopicName()}&searchQuestionKey=<%=searchKey%>"
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

							<p>
								<span class="text-gray-600 font-medium text-sm">${question.getViewCount()}</span>
								<span class="text-gray-600 text-sm"> views</span>
							</p>
						</a>
					</c:forEach>


					<c:if test="${totalQuestionPages == 0}">
						<p class="text-gray-500 text-medium text-center">There is
							currently no questions for this tag</p>
					</c:if>

					<c:if test="${totalQuestionPages != 0}">
						<div class="flex items-center justify-center gap-6"
							style="margin-bottom: 100px; text-align: center;">
							<c:choose>
								<c:when test="${currentQuestionPage > 1}">
									<a
										href="questions?activeTopic=${activeTopic}&page=${currentQuestionPage - 1}&searchQuestionKey=<%=searchKey%>"
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
									<a
										href="questions?activeTopic=${activeTopic}&page=${i}&searchQuestionKey=<%=searchKey%>"
										class="flex items-center justify-center border border-solid  rounded-md w-8 h-8 ${i == currentQuestionPage ? 'bg-orange-100 text-orange-500 border-orange-400' : 'text-gray-500 border-gray-400'}">${i}
									</a>
								</c:forEach>
							</div>

							<c:choose>
								<c:when test="${currentQuestionPage < totalQuestionPages}">
									<a
										href="questions?activeTopic=${activeTopic}&page=${currentQuestionPage + 1}&searchQuestionKey=<%=searchKey%>"
										class="bg-orange-400 text-white px-3 py-1 rounded-md"> <span
										class="mr-1">Next</span> <i class="fa-solid fa-arrow-right"></i></a>
								</c:when>
								<c:otherwise>
									<a href="#"
										class="bg-gray-100 text-gray-400 px-3 py-1 rounded-md cursor-not-allowed">
										<span class="mr-1">Next</span> <i
										class="fa-solid fa-arrow-right"></i>
									</a>
								</c:otherwise>
							</c:choose>

						</div>
					</c:if>


				</div>


			</div>

		</div>
	
</body>
</html>