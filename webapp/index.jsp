<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pointhub</title>
</head>
<body>
	<jsp:include page="navbar.jsp" />

	<form action="question-tab" method="post">
		<input type="submit" value="newest" name="tab" /> <input type="submit"
			value="top" name="tab" /> <input type="submit" value="unanswered"
			name="tab" />
	</form>
</body>
</html>