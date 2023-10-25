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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/styles/tomorrow-night-blue.min.css">
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
boolean currentUserIsAdmin = isLoggedIn && Authentication.getCurrentUserRole(request).equals("admin");
int currentUserID = isLoggedIn ? Authentication.getCurrentUserID(request) : -1;
%>

<body class="" data-questionID="<%=question.getQuestionID()%>"
	data-userID="<%=Authentication.getCurrentUserID(request)%>">

	<!-- Confirm delete question modal --------------------------------------------------------------------->
	<div
		class="confirm-delete-modal fixed inset-0 z-50 overflow-auto bg-gray-500 bg-opacity-75 hidden justify-center items-center ">
		<div
			class="confirm-delete-container bg-white w-fit p-4 relative rounded-sm">
			<h2 class="text-2xl font-bold my-5 text-gray-500">Are you sure
				to delete this question?</h2>
			<div class="flex item-centers justify-end gap-4">
				<button class="cancel-delete-btn px-4 py-1 rounded-md bg-slate-100 hover:bg-slate-200 text-slate-500">Cancel</button>
				<button class="confirm-delete-btn px-4 py-1 rounded-md bg-orange-100 hover:bg-orange-200 text-orange-500">Confirm</button>
			</div>
			
		</div>
	</div>

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
		class="reply-modal fixed inset-0 z-50 overflow-auto bg-gray-500 bg-opacity-75 hidden justify-center items-center ">
		<div
			class="reply-container bg-white w-[90%] sm:w-[70%] md:w-[60%] p-4 relative rounded-sm">
			<h2 class="text-2xl font-bold mb-4 text-gray-500">Reply to
				Comment</h2>
			<form class="reply-form">
				<div class="mb-4">
					<label for="replyText"
						class="block font-medium text-sm text-gray-500 mb-4">Your
						Reply</label>
					<textarea class="reply-content w-full border rounded p-2" rows="4"></textarea>
				</div>
				<div class="flex justify-end">
					<button type="button"
						class="reply-submit-btn bg-blue-500 text-white px-4 py-2 rounded">
						Submit</button>
				</div>

			</form>
			<button
				class="modal-close-btn  text-gray-700 text-4xl rounded absolute top-4 right-4"
				data-dismiss="modal">&times;</button>
		</div>
	</div>


	<div id="report-overlay"
		class="fixed inset-0 bg-gray-500 bg-opacity-75 hidden z-10"></div>

	<!-- Report Modal ----------------------------------------------------------------------------------------------->
	<div id="report-modal"
		class="z-20 fixed inset-0 hidden items-center justify-center">
		<div
			class="report-content-container modal-content bg-white p-4 rounded-lg shadow-lg w-[90%] sm:w-[70%] md:w-[60%]">
			<span id="report-close-btn"
				class="text-3xl absolute top-0 right-0 m-2 cursor-pointer text-gray-600 hover:text-gray-800">&times;</span>
			<h2 class="text-2xl font-semibold mb-4 text-gray-500">Report</h2>

			<form id="reportForm" class="">
				<label class="block font-medium text-sm text-gray-500 mb-4">Your
					Report</label>
				<textarea
					class="report-textarea w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-blue-500"
					rows="4"></textarea>
				<div class="flex justify-end">
					<input
						class="report-submit-btn mt-4 px-4 py-1 bg-blue-400 rounded-md text-white cursor-pointer"
						type="button" value="Submit" />
				</div>
			</form>
		</div>
	</div>

	<jsp:include page="navbar.jsp" />


	<div class="w-full sm:w-[650px] md:w-[800px] lg:w-[1000px] mx-auto">
		<div class="p-3 sm:p-10 bg-white">
			<div class="flex item-center justify-between">
				<div class="flex items-center justify-start gap-3">
					<img src="img/<%=question.getUserPhoto()%>" alt=""
						class="w-[50px] h-[50px] object-cover rounded-full" />
					<div class="profile_info">
						<a class="text-gray-600 font-medium"
							href="user-profile?userID=<%=question.getUserID()%>"> @<%=question.getUsername()%></a>
						<p class="text-gray-500"><%=question.getCreatedAt()%></p>
					</div>
				</div>
				<div class="sm:block hidden">
					<c:if
						test="<%=currentUserID == question.getUserID() || currentUserIsAdmin%>">
						<button
							class="delete-question-btn bg-slate-100 hover:bg-slate-200 text-slate-500 px-4 py-1 rounded-md">
							<i class="fa-solid fa-trash"></i> <span class="ml-2">Delete</span>
						</button>
					</c:if>

					<button
						class="report-btn bg-red-100 hover:bg-red-200 text-white px-4 py-1 rounded-md">
						<i class="fa-solid fa-flag text-red-500"></i> <span
							class="ml-2 text-red-500">Report</span>
					</button>
					<button
						class="bookmark-btn px-4 py-1 rounded-md bg-orange-100 hover:bg-orange-200 text-orange-500">
						<i
							class="<%=question.isBookmarked() ? "fa-solid" : "fa-regular"%> fa-bookmark bookmark-icon"></i>
						<span class="ml-2">Bookmark</span>
					</button>
				</div>
			</div>

			<h2 class="mt-10 font-bold text-2xl text-gray-600">
				<%=question.getTitle()%>
			</h2>

			<p class="mt-5 text-gray-500"><%=question.getQuestionContent()%></p>

			<div class="mt-10 flex items-center justify-start flex-wrap gap-2">
				<c:forEach var="tag" items="<%=question.getTagContents()%>">
					<span class="px-4 py-1 rounded-md bg-orange-50 text-orange-500">${tag}</span>
				</c:forEach>
			</div>

			<div class="mt-10 flex items-center gap-4">
				<button
					class="upvote-btn w-10 h-10 bg-slate-200 hover:bg-slate-300 rounded-full flex items-center justify-center">
					<i class="fa-solid fa-angle-up text-2xl text-slate-500"></i>
				</button>
				<p class="votes-sum text-gray-600 font-medium"><%=question.getVotesSum()%></p>

				<button
					class="downvote-btn w-10 h-10 bg-slate-200 hover:bg-slate-300 rounded-full flex items-center justify-center">
					<i class="fa-solid fa-angle-down text-2xl text-slate-500"></i>
				</button>
			</div>
			<div class="mt-8 mb-5 flex flex-wrap sm:hidden gap-4">
				<c:if
					test="<%=currentUserID == question.getUserID() || currentUserIsAdmin%>">
					<button
						class="delete-question-btn bg-slate-100 hover:bg-slate-200 text-slate-500 px-4 py-1 rounded-md">
						<i class="fa-solid fa-trash"></i> <span class="ml-2">Delete</span>
					</button>
				</c:if>
				<button
					class="report-btn bg-red-100 hover:bg-red-200 text-white px-4 py-1 rounded-md">
					<i class="fa-solid fa-flag text-red-500"></i> <span
						class="ml-2 text-red-500">Report</span>
				</button>
				<button
					class="bookmark-btn px-4 py-1 rounded-md bg-orange-100 hover:bg-orange-200 text-orange-500">
					<i
						class="<%=question.isBookmarked() ? "fa-solid" : "fa-regular"%> fa-bookmark bookmark-icon"></i>
					<span class="ml-2">Bookmark</span>
				</button>
			</div>

			<c:if
				test="<%=question.getCodeblock() != null && !question.getCodeblock().isBlank()%>">
				<pre style="tab-size: 2">
		         <code class="<%=question.getLanguage()%>"><%=question.getCodeblock()%></code>
	           </pre>
			</c:if>
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


		<div class="p-3 sm:p-10 mt-10 bg-white">
			<div id="comments-container"></div>
			<button class="view-comments text-gray-600">View more
				comments</button>
		</div>
	</div>



	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js"></script>
	<script>
		hljs.highlightAll();
	</script>
</body>
</html>
