package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.MyDispatcher;

import java.io.IOException;

public class QuestionTabController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String currentTab = request.getParameter("tab");

		if (currentTab.equals("newest")) {
			response.sendRedirect(request.getContextPath() + "/newest-questions");
		}
	}

}
