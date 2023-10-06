package controller;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.Authentication;
import util.MyDispatcher;

import java.io.IOException;

import org.apache.catalina.User;

import DAO.QuestionDAO;
import DAO.UserDAO;

public class CreateQuestionController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	QuestionDAO questionDAO;

	@Override
	public void init(ServletConfig config) throws ServletException {
		questionDAO = new QuestionDAO();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int[] tagIDs = { 1, 2 };
		String title = request.getParameter("title");
		String questionContent = request.getParameter("question_content");
		
	
	}

}
