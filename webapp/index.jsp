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
<!--  <link rel="stylesheet" href="css/style.css" /> -->
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

.users {
	display: flex;
	flex-direction: column;
}

.all-container {
display: flex;
justify-content: space-evenly;
overflow: hidden;
width: 100%;
}

.right-small-container .category {
	padding-bottom: 20px;
  padding-top: 20px;
  cursor: pointer;
  display: flex;
  justify-content: flex-start;
  flex-wrap: wrap;
}
@media only screen and (max-width: 880px) {
.all-container {
	  flex-direction: column;
  }
  
  .users {
	display: flex;
	flex-direction: row;
	justify-content: space-around;
}
}

@charset "UTF-8";

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: "Poppins", sans-serif;
}




.right-small-container {
  display: block;
  /*width: 100%;*/
  width: 800px;
  margin: 0px auto;
  padding: 0 30px;
}



.right-small-container .category a {
  padding: 5px 10px;
  background-color: #eaeaea;
  color: #808080;
  margin-right: 10px;
  font-size: 13px;
  border-radius: 20px;
  display: inline-block;
  margin: 6px;
  text-decoration: none;
}

.right-small-container .category .active-topic {
  background-color: #1682fd;
  color: #fff;
}

.right-small-container .list-question {
  /* width: 100%; */
  margin: 0 20px;
}

.right-small-container .list-question .question-author img {
  width: 30px;
  height: 30px;
  border-radius: 50%;
}

.question-item {
	text-decoration: none;
	display: block;
  background-color:  #fff;
  padding: 20px 40px 20px 25px;
  border-radius: 5px;
  border: 1px solid rgba(0, 0, 0, 0.1);
  box-shadow: 2px 2px 2px 1px rgba(0, 0, 0, 0.1);

  margin: 0 15px 50px;
  color: #000;
}

.question-author{
	display: flex;
	align-items: center;
}

.question-author-name {
  display: inline-block;
  margin-left: 10px;
}

.question-author-name h4 {
  font-size: 14px;
  font-weight: 450;
  margin: 2px;
}

.question-author-name p {
  font-size: 11px;
  color: #808080;
  margin: 2px;
}

.question-item .question-content {
  margin-top: 8px;
}

.question-item .question-content h3 {
  margin-bottom: 12px;
  font-size: 20px;
}

.question-item .question-content p {
  font-size: 14px;
  margin-bottom: 16px;
}

.question-item .question-category {
  position: relative;
  cursor: pointer;
}

.question-item .question-category > span {
  font-size: 12px;
  display: inline-block;
  padding: 4px 10px;
  margin-bottom: 8px;
  margin-right: 8px;
  border-radius: 5px;
  background-color: #eaeaea;
  color: #808080;
}

#menu-bar-right {
  margin-left: 12px;
  cursor: pointer;
  padding: 8px;
  background-color: #1682fd;
  color: #fff;
  margin-bottom: 16px;
}

#close {
  margin-left: 12px;
  display: inline-block;
  cursor: pointer;
  background-color: #f48023;
  color: #fff;
  padding: 8px;
  margin-bottom: 10px;
}


@media only screen and (max-width: 1000px) {
	.right-small-container {
		width: 750px;
		margin-right:  15px;
		padding: 0 30px;
		
	}
}

@media only screen and (max-width: 950px) {
	.right-small-container {
		width: 720px;
	}
}

@media only screen and (max-width: 900px) {
  .right-small-container {
    width: 700px;
    /*padding: 0 30px;*/
  }
}

/*@media only screen and (max-width: 800px) {
  .right-small-container {
    width: 680px;
    /*padding: 0 30px;
  }
  
  .all-container {
	  flex-direction: column;
  }
}*/

@media only screen and (max-width: 880px) {
  .right-small-container {
   /*argin-left: 30px;
    margin-right: 30px;*/
    margin: auto;
    padding: 0;
  }
  
  .all-container {
	  flex-direction: column;
  }
}

@media only screen and (max-width: 720px) {
  .right-small-container {
   width: 600px;
    /*padding: 0 30px;*/
  }
}

@media only screen and (max-width: 620px) {
  .right-small-container {
    width: 550px;
    /*padding: 0 15px;*/
  }
}

@media only screen and (max-width: 560px) {
  .right-small-container {
    width: 100%;
    padding: 0 10px;
  }

  .right-small-container .list-question {
    width: 100%;
    margin: auto;
    /* padding: 0 20px; */
  }

  .question-item .question-content p {
    text-align: justify;
  }
}

.popular-user-profile {
	display: flex;
	margin-bottom: 16px;
	
}
.popular-user-profile img {
	margin-right: 20px;
}

.users a div {
position: relative;
}

.users a div .icon-medal-container {
position: absolute;
bottom: -10px;
right: 20px;
}

.users a div .icon-medal-container .icon-medal {
width: 25px;
}

.users a div .icon-medal-container p {
position: absolute;
width: 8px;
text-align: center;
font-weight: 550;
right: 29px;
bottom: 13px;
font-size: 12px;
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

	<div class="all-container">

		<!-- START TOP 5 POPULAR USERS  -------------------------------------------------------------------------------->
		<div class="popular-users">
			<h2 style="color: #888; font-weight: 550;text-align: center; font-size: 1.2rem; margin-left: 15px">Top 5 popular
				users</h2>
			<div class="users"
				style="max-width: 1000px; display: flex; justify-content: center; flex-wrap: wrap; padding: 10px; margin-bottom: 30px; margin-inline: auto">
				<c:set var="counter" value="0" scope="page"></c:set>
				<c:forEach var="user" items="<%=topFivePopularUsers%>">
				<c:set var="index" value="${counter}" scope="page"></c:set>
					<a href="user-profile?userID=${user.getUserID()}"
						style="display: inline-block; padding: 15px 20px"
						class="popular-user-profile"> 
						<div>
						<img alt=""
						src="img/${user.getPhoto()}" style="margin: auto"
						class="w-[70px] h-[70px] object-cover rounded-full">
						<div class="icon-medal-container">
						
						<img class="icon-medal" alt="" src="img/medal.png">
						<p>${ counter + 1}<p>
						</div>
						</div>
						
						
						<div style="padding-top: 8px; margin: auto">
							<p style="color: #888; text-align: center; font-size: 16px; font-weight: 450">${user.getUsername()}</p>
							<p style="color: #888; text-align: center; font-size: 15px">
								<span>${user.getNumberOfFollowers()}</span> <span>followers</span>
							</p>
						</div>
					</a>
					 <c:set var="counter" value="${counter + 1}" scope="page"></c:set>
				</c:forEach>
			</div>
		</div>

		<!-- END TOP 5 POPULAR USERS  -------------------------------------------------------------------------------->


		<div class="question-area" style="margin: 0 15px">
			<form action="questions" method="get"
				class="flex items-center justify-center  gap-3" style="margin: 0 15px">
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
				<div class="category category-container" >
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
	</div>
</body>
</html>