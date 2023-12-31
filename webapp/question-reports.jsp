<%@page import="model.QuestionReport"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<script src="https://cdn.tailwindcss.com"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script defer="defer" src="js/reports-list.js"></script>
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

	<!-- Report detail modal --------------------------------------------------------------------->
	<div
		class="report-detail-modal fixed inset-0 z-50 overflow-auto bg-gray-500 bg-opacity-75 hidden justify-center items-center ">
		<div
			class="report-detail-container bg-white w-[90%] sm:w-[70%] md:w-[60%] p-4 relative rounded-sm">
			<h2 class="text-2xl font-bold mb-4 text-gray-500">Reports</h2>

			<div class="reports-detail max-h-[300px] overflow-y-scroll p-2">

			</div>

			<div class="flex items-center justify-center">

				<button class="view-more-reports-btn text-gray-600">View
					more reports</button>
			</div>

			<button
				class="report-detail-close-btn  text-gray-700 text-4xl rounded absolute top-4 right-4"
				data-dismiss="modal">&times;</button>
		</div>
	</div>

	<div class="bg-[#FAFAFA] h-[860px] w-full">
		<div
			class="overflow-x-scroll ">
			<table class="w-[800px] md:w-[90%]  mx-auto divide-y  divide-gray-200">
				<thead>
					<tr>
						<th
							class="px-6 py-3 bg-white text-left text-xs leading-4 font-medium text-gray-600 uppercase tracking-wider">
							Question Title</th>
						<th
							class="px-6 py-3 bg-white text-left text-xs leading-4 font-medium text-gray-600 uppercase tracking-wider">
							Number of reporting users</th>
						<th
							class="px-6 py-3 bg-white text-left text-xs leading-4 font-medium text-gray-600 uppercase tracking-wider">
							Action</th>

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
								class="text-blue-500 hover:underline">${report.getTitle()} </a></td>
							<td class="px-6 py-4 ">${report.getUsersReported()}</td>
							<td class="px-6 py-4">
								<button data-questionid="${report.getQuestionID()}"
									class="see-report-detail-btn bg-orange-100 text-orange-500 w-[100px] py-1 rounded-md">See
									detail</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

		<div class="mt-4 flex items-center justify-center gap-6">
			<c:choose>
				<c:when test="${currentReportPage > 1}">
					<a href="question-reports?page=${currentReportPage - 1}"
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

			<c:forEach var="i" begin="1" end="${totalReportPages}">
				<a href="question-reports?page=${i}"
					class="flex items-center justify-center border border-solid  rounded-md w-8 h-8 ${i == currentReportPage ? 'bg-orange-100 text-orange-500 border-orange-400' : 'text-gray-500 border-gray-400'}">${i}
				</a>
			</c:forEach>

			<c:choose>
				<c:when test="${currentReportPage < totalReportPages}">
					<a href="question-reports?page=${currentReportPage + 1}"
						class="bg-orange-400 text-white px-3 py-1 rounded-md"> <span
						class="mr-1">Next</span> <i class="fa-solid fa-arrow-right"></i>
					</a>
				</c:when>
				<c:otherwise>
					<a href="#"
						class="bg-gray-100 text-gray-400 px-3 py-1 rounded-md cursor-not-allowed">
						<span class="mr-1">Next</span> <i class="fa-solid fa-arrow-right"></i>
					</a>
				</c:otherwise>
			</c:choose>
		</div>
	</div>

</body>
</html>