<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page import="model.User"%>
<%@ page import="util.Authentication"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
/* Basic styling for the navbar */
ul.navbar {
	list-style-type: none;
	margin-bottom: 50px;
	padding: 0;
	background-color: #333; /* Background color for the navbar */
	overflow: hidden;
}

/* Style for navbar items */
ul.navbar li {
	float: left;
}

/* Style for navbar links */
ul.navbar li a {
	display: block;
	color: white; /* Text color for navbar links */
	text-align: center;
	padding: 14px 16px; /* Spacing around navbar links */
	text-decoration: none;
}

/* Change the link color when hovering over it */
ul.navbar li a:hover {
	background-color: #555; /* Background color when hovering */
}
</style>
</head>

<%
boolean isLoggedIn = (boolean) Authentication.isLoggedIn(request);
%>

<body>
	<ul class="navbar">
		<li><a href="/PointHubWebsite">Home</a></li>

		<c:if test="<%=!isLoggedIn%>">
			<li><a href="log-in.jsp">Log in</a></li>
			<li><a href="sign-up.jsp">Sign up</a></li>
		</c:if>

		<c:if test="<%=isLoggedIn%>">
			<li><a href="create-question.jsp">Ask a question</a></li>
			<li><a href="log-out">Logout</a></li>
		</c:if>
	</ul>
</body>
</html>