package controller;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Question;
import util.Authentication;
import util.MyDispatcher;
import util.StateName;

import java.io.IOException;
import java.sql.SQLIntegrityConstraintViolationException;

import DAO.QuestionDAO;

public class QuestionDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	QuestionDAO questionDAO;

	@Override
	public void init(ServletConfig config) throws ServletException {
		questionDAO = new QuestionDAO();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int questionID = Integer.parseInt(request.getParameter("question_id"));
		int userID = Integer.parseInt(request.getParameter("user_id"));


		Question questionDetail;
		questionDetail = questionDAO.getQuestionByID(questionID, userID);

		HttpSession session = request.getSession();
		session.setAttribute(StateName.QUESTION_DETAIL, questionDetail);


		MyDispatcher.dispatch(request, response, "question-detail.jsp");

	}

}
