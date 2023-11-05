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
<!--<link rel="stylesheet" href="css/user_list_style.css"> -->
<!-- Keep both style sections -->
<script src="https://cdn.tailwindcss.com"></script>

<title>Document</title>

<style>
@charset "UTF-8";

@import
	url('https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700&family=Roboto:wght@100;400&display=swap')
	;

* {
	margin: 0;
	padding: 0;
	transition: 0.2s linear;
	border: none;
	outline: none;
	text-decoration: none;
	font-family: 'Poppins', sans-serif;
}

html {
	background: #FAFAFA;
}

.userList {
	margin-top: 60px;
	margin-bottom: 80px;
}

.userList .searchItem {
	display: flex;
	margin: auto;
	width: 100%;
	max-width: 1200px;
	padding: 20px 36px;
	box-sizing: border-box;
	background-color: #fff;
}

.userList .searchItem i {
	order: 1;
	color: #C2CFE0;
	margin-right: 10px;
	font-size: 18px;
}

.userList .searchItem input {
	font-size: 14px;
	order: 2;
	width: 100%;
	color: #90A0B7;
}

.userList .searchItem input::placeholder {
	color: #90A0B7;
}

.userList .div-btn {
	max-width: 1200px;
	margin-left: auto;
	margin-right: auto;
}

.userList .btnAdd {
	display: block;
	width: fit-content;
	margin-top: 50px;
	margin-left: 4%;
	color: #fff;
	padding: 11px 40px;
	background-color: #152C70;
	color: #FFF;
	text-align: center;
	font-size: 12px;
	font-style: normal;
	font-weight: 500;
	letter-spacing: 0.16px;
	border-radius: 4px;
	box-shadow: 0 4px 10px 0 rgba(16, 156, 241, 0.24);
}

.userList .table-container {
	overflow-x: auto;
}

.userList table {
	border-spacing: 0px;
	background-color: #fff;
	margin: auto;
	margin-top: 50px;
	width: 1200px;
	text-align: center;
	background-color: #fff;
}

/* Cho trình duyệt WebKit */
.table-container::-webkit-scrollbar {
	height: 8px;
}

.table-container::-webkit-scrollbar-thumb {
	background-color: #bdbdbd85;
}

.table-container::-webkit-scrollbar-thumb:hover {
	background-color: rgb(192, 190, 190);
}

.table-container::-webkit-scrollbar-track {
	background-color: #ddd;
}

.userList table thead {
	box-shadow: 0 0.5px 0 #ced1d2;
}

.userList table tr {
	font-size: 14px;
	letter-spacing: 0.15px;
	height: 64px;
	color: #323C47;
	font-weight: 500;
	box-sizing: border-box;
}

.userList table .row:hover {
	background-color: #f4f4f4;
}

.userList table img {
	width: 36px;
	height: 36px;
	border-radius: 50%;
	object-fit: cover;
}

.userList i {
	cursor: pointer;
}

@media ( min-width : 1600px) {
	.userList .searchItem {
		max-width: 1500px;
		padding: 20px 36px;
	}
	.userList .searchItem input {
		font-size: 16px;
	}
	.userList table {
		margin-top: 50px;
		width: 1500px;
	}
	.userList table tr {
		font-size: 16px;
		letter-spacing: 0.16px;
		height: 66px;
	}
	.userList .div-btn {
		max-width: 1500px;
	}
	.userList .btnAdd {
		font-size: 15px;
	}
}
</style>

</head>

<%
ArrayList<User> users = (ArrayList<User>) request.getAttribute("users");
String searchKey = request.getAttribute("searchKey") != null ? (String) request.getAttribute("searchKey") : "";
%>
<body>
	<jsp:include page="navbar.jsp" />

	<div class="userList">
		<form class="searchItem" action="user-list">
			<input type="text" placeholder="Search user name" name="searchKey"
				value="<%=searchKey%>"> <i
				class="fa-solid fa-magnifying-glass"></i>
		</form class="searchItem">
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
					<a href="user-list?page=${currentUserPage - 1}&searchKey=<%=searchKey%>"
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
					<a href="user-list?page=${i}&searchKey=<%=searchKey%>"
						class="flex items-center justify-center border border-solid  rounded-md w-8 h-8 ${i == currentUserPage ? 'bg-orange-100 text-orange-500 border-orange-400' : 'text-gray-500 border-gray-400'}">${i}
					</a>
				</c:forEach>
			</div>
			<c:choose>
				<c:when test="${currentUserPage < totalUserPages}">
					<a href="user-list?page=${currentUserPage + 1}&searchKey=<%=searchKey%>"
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