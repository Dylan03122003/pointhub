<%@page import="model.Question"%>
<%@page import="util.Authentication"%>

<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,200;0,300;0,400;0,500;0,600;0,700;0,800;1,100;1,200&family=Roboto:wght@100;300;400;500;700&family=Rubik:wght@300;400;500;600&display=swap"
	rel="stylesheet" />
<link rel="stylesheet" href="question-detail-style.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.tailwindcss.com"></script>
<script defer type="module" src="js/question-detail-script.js"></script>
<script defer type="module" src="js/main-question-detail.js"></script>


<style>
.modal {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.7);
}

.modal-content {
	background-color: #fff;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	padding: 20px;
}

.close {
	position: absolute;
	top: 0;
	right: 0;
	padding: 10px;
	cursor: pointer;
}
</style>
</head>

<%
Question question = (Question) request.getAttribute("questionDetail");
boolean isLoggedIn = (boolean) Authentication.isLoggedIn(request);
%>

<body class="" data-questionID="<%=question.getQuestionID()%>"
	data-userID="<%=Authentication.getCurrentUserID(request)%>">
	<!-- Require user log in modal --------------------------------------------------------------------->
	<div
		class="require-login-modal fixed inset-0 z-50 overflow-auto bg-gray-500 bg-opacity-75 hidden justify-center items-center">
		<div
			class="require-login-content flex flex-col justify-center items-center gap-5  bg-white w-1/2 p-4 relative">
			<h2 class="text-2xl font-bold mb-4">Join the Pointhub community</h2>
			<p>Join Pointhubto start earning reputation and unlocking new
				privileges like voting and commenting.</p>

			<a class="bg-orange-400 text-white px-4 py-1 rounded-md"
				href="log-in.jsp">Log in</a> <a
				class="bg-orange-400 text-white px-4 py-1 rounded-md"
				href="sign-up.jsp">Sign up</a>

			<button
				class="require-login-close-btn bg-gray-300 text-gray-700 px-2 py-1 rounded absolute top-4 right-4"
				data-dismiss="modal">&times;</button>
		</div>
	</div>

	<!-- Toast --------------------------------------------------------------------->
	<div id="toast"
		class="z-10 fixed top-20 right-0 p-4 m-4 text-white rounded-md shadow-lg hidden"></div>

	<!-- Reply Comment Form --------------------------------------------------------------------->
	<div
		class="reply-modal fixed inset-0 z-50 overflow-auto bg-gray-500 bg-opacity-75 hidden justify-center items-center">
		<div class="reply-container bg-white w-1/2 p-4 relative">
			<h2 class="text-2xl font-bold mb-4">Reply to Comment</h2>
			<form class="reply-form">
				<div class="mb-4">
					<label for="replyText"
						class="block font-medium text-sm text-gray-700">Your
						Reply:</label>
					<textarea class="reply-content w-full border rounded p-2" rows="4"></textarea>
				</div>
				<input type="hidden" name="parentCommentId" value="123" />
				<!-- Include the parent comment ID here -->
				<button type="button"
					class="reply-submit-btn bg-blue-500 text-white px-4 py-2 rounded">
					Submit</button>
			</form>
			<button
				class="modal-close-btn bg-gray-300 text-gray-700 px-2 py-1 rounded absolute top-4 right-4"
				data-dismiss="modal">&times;</button>
		</div>
	</div>


	<div id="report-overlay"
		class="fixed inset-0 bg-black opacity-50 hidden"></div>

	<!-- Report Modal ----------------------------------------------------------------------------------------------->
	<div id="report-modal"
		class="fixed inset-0 hidden items-center justify-center">
		<div
			class="report-content-container modal-content bg-white p-4 rounded-lg shadow-lg w-1/2">
			<span id="report-close-btn"
				class="text-3xl absolute top-0 right-0 m-2 cursor-pointer text-gray-600 hover:text-gray-800">&times;</span>
			<h2 class="text-2xl font-semibold mb-4">Report</h2>

			<form id="reportForm">
				<textarea
					class="report-textarea w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-blue-500"></textarea>
				<input
					class="report-submit-btn px-4 py-1 bg-blue-400 rounded-md text-white"
					type="button" value="Submit" />
			</form>
		</div>
	</div>

	<jsp:include page="navbar.jsp" />


	<div class="w-[320px] sm:w-[600px] md:w-[800px] lg:w-[1000px] mx-auto">
		<div class="p-10 bg-white">
			<div class="flex item-center justify-between">
				<div class="flex items-center justify-start gap-3">
					<img src="img/<%=question.getUserPhoto()%>" alt=""
						class="w-[50px] h-[50px] object-cover rounded-full" />
					<div class="profile_info">
						<a href="user-profile?userID=<%=question.getUserID()%>"> @<%=question.getUsername()%></a>
						<p><%=question.getCreatedAt()%></p>
					</div>
				</div>
				<div class="sm:block hidden">
					<button
						class="report-btn bg-red-400 text-white px-4 py-1 rounded-md">
						Report</button>
					<button id="bookmark-btn"
						class="<%=question.isBookmarked() ? "bg-orange-400 text-white" : "bg-orange-50 text-gray-600" %>   px-4 py-1 rounded-md">Bookmark</button>
				</div>
			</div>

			<h2 class="mt-10 font-bold text-2xl text-gray-600">
				<%=question.getTitle()%>
			</h2>

			<p class="mt-5"><%=question.getQuestionContent()%></p>

			<div class="mt-10 flex items-center justify-start gap-2">
				<c:forEach var="tag" items="<%=question.getTagContents()%>">
					<span class="px-4 py-1 rounded-md bg-red-50">${tag}</span>
				</c:forEach>
			</div>

			<div class="mt-10 flex items-center gap-2">
				<button class="upvote-btn">Upvote</button>
				<p class="votes-sum"><%=question.getVotesSum()%></p>

				<button class="downvote-btn"
					href="vote-question?questionId=<%=question.getQuestionID()%>&voteType=downvote">Downvote</button>
			</div>
			<div class="flex gap-4">
				<button
					class="report-btn mt-10 sm:hidden block bg-red-400 text-white px-4 py-1 rounded-md">
					Report</button>
				<button id="bookmark-btn"
					class="mt-10 sm:hidden block bg-orange-400 text-white px-4 py-1 rounded-md">
					Bookmark</button>
			</div>
		</div>

		<div
			class="bg-white mt-10 p-4 flex flex-col gap-2 items-center justify-center">
			<h2 class="font-medium text-xl">Comment</h2>
			<form class="w-full flex flex-col gap-4 justify-center items-end">
				<textarea required="required"
					class="comment-content w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-blue-500"></textarea>
				<button
					class="comment-btn px-4 py-1 rounded-md bg-orange-400 text-white"
					type="button">Comment</button>
			</form>
		</div>

		<div class="p-10 mt-10 bg-white">
			<div id="comments-container"></div>
			<button class="view-comments text-gray-600">View more
				comments</button>
		</div>
	</div>

</body>
</html>
