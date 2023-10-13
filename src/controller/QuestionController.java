package controller;

import jakarta.servlet.ServletException;
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
import java.util.ArrayList;

import DAO.QuestionDAO;

public class QuestionController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	QuestionDAO questionDAO;

	@Override
	public void init() throws ServletException {
		questionDAO = new QuestionDAO();
	}

	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String path = request.getServletPath();
		switch (path) {
			case "/newest-questions" :
				getNewestQuestionsHandler(request, response);
				break;
			case "/question-detail" :
				getQuestionDetailHandler(request, response);
				break;
			case "/vote-question" :
				voteQuestionHandler(request, response);
			default :

		}
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String path = request.getServletPath();

		switch (path) {
			case "/report-question" :
				reportQuestionHandler(request, response);
				break;

			case "/create-question" :
				createQuestionHandler(request, response);
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

	private void getNewestQuestionsHandler(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		ArrayList<Question> questions = questionDAO.getNewestQuestions();

		request.setAttribute("question_list", questions);
		MyDispatcher.dispatch(request, response, "/index.jsp");
	}

	private void createQuestionHandler(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String[] tagContents = {"React", "Java"};
		String title = request.getParameter("title");
		String questionContent = request.getParameter("question_content");

		Question question = new Question(
				Authentication.getCurrentUserID(request), questionContent,
				title, tagContents);

		questionDAO.createQuestion(question);

		response.sendRedirect("newest-questions");
	}

	private void getQuestionDetailHandler(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		int questionID = Integer.parseInt(request.getParameter("question_id"));
		int userID = Integer.parseInt(request.getParameter("user_id"));

		Question questionDetail;
		questionDetail = questionDAO.getQuestionByID(questionID, userID);

		HttpSession session = request.getSession();
		session.setAttribute(StateName.QUESTION_DETAIL, questionDetail);

		MyDispatcher.dispatch(request, response, "question-detail.jsp");
	}

	private void voteQuestionHandler(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String voteType = request.getParameter("voteType");
		int questionID = Integer.parseInt(request.getParameter("questionId"));
		int currentUserID = Authentication.getCurrentUserID(request);
		try {
			questionDAO.voteQuestion(currentUserID, questionID, voteType);
		} catch (SQLIntegrityConstraintViolationException e) {
			e.printStackTrace();
			request.setAttribute("violated_unique_vote", true);
			MyDispatcher.dispatch(request, response,
					"question-detail?question_id=" + questionID + "&user_id="
							+ currentUserID + "");
			return;
		} catch (Exception e) {
			System.out.println("global Exception: ");
			e.printStackTrace();
		}
		response.sendRedirect("question-detail?question_id=" + questionID
				+ "&user_id=" + currentUserID + "");
	}

}
