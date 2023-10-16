<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page import="model.User"%>
<%@ page import="model.Question"%>

<%@ page import="util.Authentication"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
/* Reset default list styles and remove list bullets */
.navbar-menu {
	list-style: none;
	padding: 20px;
	margin: 0;
}

/* Style navbar items */
.navbar-menu li {
	display: inline-block;
	margin-right: 15px;
}

/* Style navbar links */
.navbar-menu li a {
	text-decoration: none;
	color: #333;
	font-weight: bold;
	padding: 10px;
	border-radius: 5px;
	transition: background-color 0.3s, color 0.3s;
}

/* Hover effect for navbar links */
.navbar-menu li a:hover {
	background-color: #007bff;
	color: #fff;
}

/* Style the username element */
.username {
	color: #007bff;
	font-weight: bold;
}
</style>
</head>

<%
boolean isLoggedIn = (boolean) Authentication.isLoggedIn(request);
String username = (String) Authentication.getCurrentUsername(request);
String role = (String) Authentication.getCurrentUserRole(request);

boolean isAdmin = isLoggedIn && role.equals("admin");

%>

<body>
	<nav class="navbar">
		<ul class="navbar-menu">
			<li><a href="/PointHubWebsite">Home</a></li>

			<c:if test="<%=!isLoggedIn%>">
				<li><a href="log-in.jsp">Log in</a></li>
				<li><a href="sign-up.jsp">Sign up</a></li>
			</c:if>
			
			<c:if test="<%=isAdmin%>">
				<li><a href="question-reports">Question Reports</a></li>
				<li><a href="UserListContrroller">UserList</a></li>
			</c:if>

			<c:if test="<%=isLoggedIn%>">
				<li><a href="create-question.jsp">Ask a question</a></li>
				<li><a href="log-out">Logout</a></li>
			</c:if>

			<c:if test="<%=username != null%>">
				<li class="username"><%=username%></li>
			</c:if>
		</ul>
	</nav>


</body>
</html>