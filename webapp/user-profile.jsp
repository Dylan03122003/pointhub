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

	<h2>
		Email:
		<%=user.getEmail()%></h2>
	<h2>
		Username:
		<%=user.getUsername()%></h2>
	<img alt="" src="img/<%=user.getPhoto()%>">


</body>
</html>