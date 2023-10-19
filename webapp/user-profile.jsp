<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="model.User"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<%
User user = (User) request.getAttribute("userProfile");
%>
<body>
	<jsp:include page="navbar.jsp" />

	<a href="retrieve-profile?userID=<%=user.getUserID()%>">Update</a>

	<h2>
		Email:
		<%=user.getEmail()%></h2>
	<h2>
		Username:
		<%=user.getUsername()%></h2>
	<img alt="" src="img/<%=user.getPhoto()%>">

	<a href="<%=user.getFacebookLink()%>">facebook</a>
	<a href="<%=user.getTwitterLink()%>">twitter</a>
	<a href="<%=user.getInstagramLink()%>">instagram</a>
	<a href="<%=user.getGithubLink()%>">github</a>

	<p>
		total questions:
		<%=user.getTotalQuestions()%></p>

	<p>
		about:
		<%=user.getAbout()%></p>

</body>
</html>