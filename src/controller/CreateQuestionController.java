package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.Authentication;
import util.MyDispatcher;

import java.io.IOException;

import org.apache.catalina.User;

public class CreateQuestionController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String tag = request.getParameter("tag");
		String title = request.getParameter("title");
		String questionContent = request.getParameter("question_content");



	}

}
