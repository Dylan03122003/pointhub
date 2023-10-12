package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Question;
import util.Authentication;
import util.StateName;

import java.io.IOException;

import DAO.QuestionDAO;

public class QuestionController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	QuestionDAO questionDAO;

	@Override
	public void init() throws ServletException {
		questionDAO = new QuestionDAO();
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String path = request.getServletPath();

		switch (path) {
			case "/report-question" :
				reportQuestionHandler(request, response);
				break;
			default :

		}

	}

	private void reportQuestionHandler(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String reportContent = request.getParameter("reportContent");
		HttpSession session = request.getSession();

		Question currentQuestionDetail = (Question) session
				.getAttribute(StateName.QUESTION_DETAIL);

		questionDAO.reportQuestion(currentQuestionDetail.getQuestionID(),
				Authentication.getCurrentUserID(request), reportContent);

		response.sendRedirect("question-detail.jsp");

	}

}
