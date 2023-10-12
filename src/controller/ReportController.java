package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.QuestionReport;
import util.MyDispatcher;

import java.io.IOException;
import java.util.ArrayList;

import DAO.QuestionDAO;

public class ReportController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	QuestionDAO questionDAO;
	@Override
	public void init() throws ServletException {
		questionDAO = new QuestionDAO();

	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String path = request.getServletPath();

		switch (path) {
			case "/question-reports" :
				getQuestionReportsHandler(request, response);
				break;

			default :

		}
	}

	private void getQuestionReportsHandler(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		int currentPage = request.getParameter("page") == null
				? 1
				: Integer.parseInt(request.getParameter("page"));

		ArrayList<QuestionReport> questionReports = questionDAO
				.getQuestionReports(1, currentPage);

		request.setAttribute("current_report_question_page", currentPage);

		request.setAttribute("reports", questionReports);

		MyDispatcher.dispatch(request, response, "question-reports.jsp");
	}

}