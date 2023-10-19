<%@page import="model.QuestionReport"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdn.tailwindcss.com"></script>

<title>Insert title here</title>

<style>
.active {
	color: red;
}

.disabled {
	pointer-events: none; /* Disable link interactions */
	color: #999; /* Change the text color to a lighter gray */
	cursor: not-allowed; /* Change the cursor style to not-allowed */
}
</style>
</head>


<body>
	<jsp:include page="navbar.jsp" />

	<table class="min-w-full divide-y divide-gray-200">
		<thead>
			<tr>
				<th
					class="px-6 py-3 bg-gray-100 text-left text-xs leading-4 font-medium text-gray-600 uppercase tracking-wider">
					Question Title</th>
				<th
					class="px-6 py-3 bg-gray-100 text-left text-xs leading-4 font-medium text-gray-600 uppercase tracking-wider">
					User Information</th>
				<th
					class="px-6 py-3 bg-gray-100 text-left text-xs leading-4 font-medium text-gray-600 uppercase tracking-wider">
					Report Content</th>
			</tr>
		</thead>
		<tbody class="bg-white divide-y divide-gray-200">
			<c:forEach var="report" items="${reports}">
				<tr>
					<td class="px-6 py-4 whitespace-no-wrap"><a
						href="<c:url value='/question-detail'>
                      <c:param name='question_id' value='${report.getQuestionID()}' />
                      <c:param name='user_id' value='${report.getReportedUserID()}' />
                    </c:url>"
						class="text-blue-500 hover:underline">${report.getTitle()}
					</a></td>
					<td class="px-6 py-4">
						<div class="flex items-center">
							<img
								src="img/${report.getUserPhoto()}"
								alt="User 1" class="w-12 h-12 object-cover rounded-full">
							<h3 class="ml-4">${report.getReportingUsername()}</h3>
						</div>
					</td>
					<td class="px-6 py-4">
						<p>${report.getReportContent()}</p>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<div class="mt-4">
		<c:choose>
			<c:when test="${currentReportPage > 1}">
				<a href="question-reports?page=${currentReportPage - 1}"
					class="text-blue-500 hover:underline">prev</a>
			</c:when>
			<c:otherwise>
				<a href="#" class="text-gray-500 cursor-not-allowed">prev</a>
			</c:otherwise>
		</c:choose>

		<c:forEach var="i" begin="1" end="${totalReportPages}">
			<a href="question-reports?page=${i}"
				class="ml-2 text-blue-500 hover:underline ${i == currentReportPage ? 'font-bold' : ''}">${i}
			</a>
		</c:forEach>

		<c:choose>
			<c:when test="${currentReportPage < totalReportPages}">
				<a href="question-reports?page=${currentReportPage + 1}"
					class="ml-2 text-blue-500 hover:underline">next</a>
			</c:when>
			<c:otherwise>
				<a href="#" class="ml-2 text-gray-500 cursor-not-allowed">next</a>
			</c:otherwise>
		</c:choose>
	</div>

</body>
</html>