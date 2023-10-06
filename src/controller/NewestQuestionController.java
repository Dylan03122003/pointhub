package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Question;

import java.io.IOException;
import java.util.ArrayList;

import DAO.QuestionDAO;

public class NewestQuestionController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	QuestionDAO questionDAO;

	@Override
	public void init() throws ServletException {
		questionDAO = new QuestionDAO();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ArrayList<Question> questions = questionDAO.getNewestQuestions();
		System.out.println(questions);
	}

}
