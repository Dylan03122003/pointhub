<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
String addStatus = (String) request.getAttribute("createStatus");
%>
<body>
	<h1><%=addStatus%></h1>
	<form action="create-user" method="get">
		<input type="text" name="firstName" placeholder="firstName"> <input
			type="text" name="lastName" placeholder="lastName"> <input
			type="email" name="email" placeholder="Email"> <select
			name="role">
			<option value="admin">Admin</option>
			<option value="user">User</option>
		</select> <input type="password" name="pass" placeholder="Password">
		<button type="submit" value="Add User">Add User</button>
	</form>
</body>
</html>