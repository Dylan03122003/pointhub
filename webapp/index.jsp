<%@page import="model.Question"%>
<%@page import="model.Topic"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">



<title>Pointhub</title>

<style>
.active-topic {
	color: red;
}
</style>
</head>

<%
ArrayList<Question> questions = (ArrayList<Question>) request.getAttribute("question_list");
ArrayList<Topic> topics = (ArrayList<Topic>) request.getAttribute("topics");
String activeTopic = (String) request.getAttribute("activeTopic");
%>

<body>
	<jsp:include page="navbar.jsp" />

	<div>
		<c:forEach var="topic" items="<%=topics%>">
			<a href="questions?activeTopic=${topic.getTopicName()}"
				class="${topic.getTopicName().equals(activeTopic) ? 'active-topic' : ''}">${topic.getTopicName()}</a>
		</c:forEach>
	</div>


	<div>
		<c:forEach var="question" items="<%=questions%>">
			<div style="border: 1px solid blue">
				<a
					href="<c:url value='/question-detail'>
                      <c:param name='question_id' value='${question.getQuestionID()}' />
                      <c:param name='user_id' value='${question.getUserID()}' />
                  </c:url>">

					<img style="width: 50px" alt=""
					src="https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1965&q=80">
					<h2>${question.getUsername()}</h2>
					<h3>${question.getTitle()}</h5>
						<p>${question.getQuestionContent()}</p>
						<div>
							<c:forEach var="tag" items="${question.getTagContents()}">
								<div>${tag}</div>
							</c:forEach>
						</div>s
						<p>${question.getCreatedAt()}</p>
				</a>
			</div>
		</c:forEach>
	</div>
</body>
</html>