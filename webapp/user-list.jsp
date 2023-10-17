<%@page import="java.util.ArrayList"%>
<%@ page import="model.User"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
ArrayList<User> users = (ArrayList<User>) request.getAttribute("users");
%>
<body>
	<jsp:include page="navbar.jsp" />
     <a href="add-user.jsp">Create User</a>
	<div class="table-container">
		<table class="table-list">
			<thead>
				<tr>
					<th>Avatar</th>
					<th>Username</th>
					<th>Gmail</th>
					<th>Delete User</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (User user : users) {
				%>
				<tr>
					<td><%=user.getPhoto()%></td>
					<td><%=user.getUsername()%></td>
					<td><%=user.getEmail()%></td>
					<td class="action-links"><a
						href="delete-user?UserID=<%=user.getUserID()%>">Delete</a></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>
</body>
</html>