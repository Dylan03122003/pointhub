<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<jsp:include page="navbar.jsp" />


	<c:if test="${loginStatus == 'fail'}">
		<h1>Incorrect email or password!</h1>
	</c:if>
	<form action="LogInController" method="post">
		<input type="email" name="email" placeholder="email" /> <input
			type="password" name="password" placeholder="password" />
		<button type="submit">Log in</button>
	</form>



</body>
</html>