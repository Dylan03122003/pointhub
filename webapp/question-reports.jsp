<%@page import="model.QuestionReport"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<%
ArrayList<QuestionReport> reports = (ArrayList<QuestionReport>) request.getAttribute("reports");
int currentPage = request.getAttribute("current_report_question_page") == null ? 1
	: (int) request.getAttribute("current_report_question_page");
%>

<body>
	<jsp:include page="navbar.jsp" />

	<ul>
		<c:forEach var="report" items="<%=reports%>">
			<li>${report.getReportContent()}</li>
		</c:forEach>
	</ul>
	<a href="question-reports?page=<%=currentPage - 1%>">prev</a>
	<a href="question-reports?page=<%=currentPage + 1%>">next</a>

</body>
</html>