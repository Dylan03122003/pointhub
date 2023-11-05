<%@page import="model.Topic"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="https://cdn.tailwindcss.com"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script defer="defer" src="js/manage-topic.js"></script>
<title>Topics</title>
</head>
<%
ArrayList<Topic> topics = (ArrayList<Topic>) request.getAttribute("topics");
%>
<body>
	<jsp:include page="navbar.jsp" />

	<!-- Toast --------------------------------------------------------------------->
	<div id="toast"
		class="z-10 fixed top-20 right-0 p-4 m-4 text-white rounded-md shadow-lg hidden"></div>
	<div class="flex items-center justify-center ">
		<div class=" w-[90%] shadow">

			<div class="flex justify-center">
				<form class="add-topic-form"
					data-duplicatedtopic="${duplicatedTopic}" action="add-topic"
					method="post">
					<div
						class="flex flex-col justify-center items-center pb-[20px] pt-[20px] lg:w-[100%] md:w-[500px] sm:w-[300px] w-[200px] ">
						<label class="text-orange-500 font-bold text-[25px] pb-[10px]">Manage
							Topic</label>
						<div class="flex">
							<input
								class="border-[1px] border-[2px] rounded-md px-2 lg:w-[550px] md:w-[560px] w-[210px] sm:w-[450px] border-gray-300"
								required="required" placeholder="Enter topic..." type="text"
								name="topicName" />

							<button
								class="flex items-center pl-2 pr-2 justify-center w-[] rounded-md text-white text-[10px] w-[100px] h-[30px] ml-[10px] bg-orange-500"
								type="submit">
								<svg class="pr-[5px]" xmlns="http://www.w3.org/2000/svg"
									height="24" fill="white" viewBox="0 -960 960 960" width="24">
								<path
										d="M440-280h80v-160h160v-80H520v-160h-80v160H280v80h160v160Zm40 200q-83 0-156-31.5T197-197q-54-54-85.5-127T80-480q0-83 31.5-156T197-763q54-54 127-85.5T480-880q83 0 156 31.5T763-763q54 54 85.5 127T880-480q0 83-31.5 156T763-197q-54 54-127 85.5T480-80Zm0-80q134 0 227-93t93-227q0-134-93-227t-227-93q-134 0-227 93t-93 227q0 134 93 227t227 93Zm0-320Z" /></svg>
								Add Topic
							</button>
						</div>
					</div>
				</form>
			</div>
			<div class="">
				<c:forEach var="topic" items="<%=topics%>">
					<div data-topicid="${topic.getTopicID()}"
						class="flex justify-center border-[1px] border-gray-100 h-[60px]">
						
							<div class="flex flex-col md:w-[610px] sm:w-[500px] pt-[5px] w-[280px]">

								<h2 class="topic-name mr-[150px] font-semibold text-[#2980b9]">${topic.getTopicName()}</h2>


								<div class="flex" id="Total" data-topicid="${topic.getTopicID()}">
									<p class="text-orange-500">
										Total question: <label class="text-[#2980b9]">${topic.getCountQuestion()}</label>
									</p>

								</div>
							</div>
							<button class="update-topic-btn mr-[10px]" type="button">
								<svg xmlns="http://www.w3.org/2000/svg" height="20"
									fill="#2980b9" viewBox="0 -960 960 960" width="20">
								<path
										d="M200-200h57l391-391-57-57-391 391v57Zm-80 80v-170l528-527q12-11 26.5-17t30.5-6q16 0 31 6t26 18l55 56q12 11 17.5 26t5.5 30q0 16-5.5 30.5T817-647L290-120H120Zm640-584-56-56 56 56Zm-141 85-28-29 57 57-29-28Z" /></svg>
							</button>
						
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
<script>

</script>
</body>
</html>