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


	<form class="add-topic-form" data-duplicatedtopic="${duplicatedTopic}"
		action="add-topic" method="post">
		<label>Enter topic name</label> <input
			class="border-[1px] border-solid border-gray-300" required="required" type="text"
			name="topicName" />
		<button type="submit">Add</button>
	</form>

	<c:forEach var="topic" items="<%=topics%>">
		<div data-topicid="${topic.getTopicID()}" class="flex gap-5">
			<h2 class="topic-name">${topic.getTopicName()}</h2>
			<button class="update-topic-btn" type="button">Update</button>
		</div>
	</c:forEach>


</body>
</html>