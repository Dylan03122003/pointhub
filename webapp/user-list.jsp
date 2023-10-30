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
					<tr class="row cursor-pointer" data-userid="<%=user.getUserID()%>">
						<td class="flex items-center justify-center mt-[15px]"><img
							src="img/<%=user.getPhoto()%>" alt="" srcset=""></td>
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

	<c:if test="${totalUserPages == 0}">
		<p class="text-gray-500 text-medium text-center">There is users
			currently</p>
	</c:if>

	<c:if test="${totalUserPages > 0}">
		<div class="flex items-center justify-center gap-6">
			<c:choose>
				<c:when test="${currentUserPage > 1}">
					<a href="user-list?page=${currentUserPage - 1}"
						class="bg-orange-400 text-white px-3 py-1 rounded-md"> <i
						class="fa-solid fa-arrow-left"></i> <span class="ml-1">Previous</span>
					</a>
				</c:when>
				<c:otherwise>
					<a href="#"
						class="bg-gray-100 text-gray-400 px-3 py-1 rounded-md cursor-not-allowed">
						<i class="fa-solid fa-arrow-left"></i> <span class="ml-1">Previous</span>
					</a>
				</c:otherwise>
			</c:choose>
			<div class="flex items-center justify-center gap-5 flex-wrap">
				<c:forEach var="i" begin="1" end="${totalUserPages}">
					<a href="user-list?page=${i}"
						class="flex items-center justify-center border border-solid  rounded-md w-8 h-8 ${i == currentUserPage ? 'bg-orange-100 text-orange-500 border-orange-400' : 'text-gray-500 border-gray-400'}">${i}
					</a>
				</c:forEach>
			</div>
			<c:choose>
				<c:when test="${currentUserPage < totalUserPages}">
					<a href="user-list?page=${currentUserPage + 1}"
						class="bg-orange-400 text-white px-3 py-1 rounded-md"> <span
						class="mr-1">Next</span> <i class="fa-solid fa-arrow-right"></i></a>
				</c:when>
				<c:otherwise>
					<a href="#"
						class="bg-gray-100 text-gray-400 px-3 py-1 rounded-md cursor-not-allowed">
						<span class="mr-1">Next</span> <i class="fa-solid fa-arrow-right"></i>
					</a>
				</c:otherwise>
			</c:choose>
		</div>
	</c:if>


	<script>
		const rows = document.querySelectorAll(".row");

		rows.forEach(function(row) {
			row.addEventListener("click", function() {
				const userId = this.getAttribute("data-userid");
				window.location.href = "user-profile?userID=" + userId;
			});
		});
	</script>


</body>
</html>