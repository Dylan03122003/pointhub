<%@page import="java.util.ArrayList"%>
<%@ page import="model.User"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- links css, icon -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="css/user_list_style.css">
<!-- Keep both style sections -->
<script src="https://cdn.tailwindcss.com"></script>

<title>Document</title>

</head>

<%
ArrayList<User> users = (ArrayList<User>) request.getAttribute("users");
%>
<body>
	<jsp:include page="navbar.jsp" />
	
	<div class="userList">
		<div class="searchItem">
			<input type="text" placeholder="Search user name"> <i
				class="fa-solid fa-magnifying-glass"></i>
		</div>
		<div class="div-btn">
			<a class="btnAdd" href="add-user.jsp">ADD NEW+</a>
		</div>

		<div class="table-container">
			<table class="table-list">
				<thead>
					<tr>
						<th colspan="">Avatar</th>
						<th colspan="">Username</th>
						<th colspan="">Email</th>
						<th colspan="">Delete User</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (User user : users) {
					%>
					<tr class="row">
						<td><img
							src="img/<%=user.getPhoto()%>"
							alt="" srcset=""></td>
						<td><%=user.getUsername()%></td>
						<td><%=user.getEmail()%></td>
						<td class="action-links"><a
							href="delete-user?UserID=<%=user.getUserID()%>"><i
								class="fa-solid fa-user-minus"></i></a></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>
	</div>

	<div class="mt-4">
		<c:choose>
			<c:when test="${currentUserPage > 1}">
				<a href="user-list?page=${currentUserPage - 1}"
					class="text-blue-500 hover:underline">prev</a>
			</c:when>
			<c:otherwise>
				<a href="#" class=" disabled text-gray-500 cursor-not-allowed">prev</a>
			</c:otherwise>
		</c:choose>

		<c:forEach var="i" begin="1" end="${totalUserPages}">
			<a href="user-list?page=${i}"
				class="ml-2 text-blue-500 hover:underline ${i == currentUserPage ? 'active' : ''}">${i}
			</a>
		</c:forEach>

		<c:choose>
			<c:when test="${currentUserPage < totalUserPages}">
				<a href="user-list?page=${currentUserPage + 1}"
					class="ml-2 text-blue-500 hover:underline">next</a>
			</c:when>
			<c:otherwise>
				<a href="#" class=" disabled  ml-2 text-gray-500 cursor-not-allowed">next</a>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>