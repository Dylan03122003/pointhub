package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Question;
import model.Topic;
import util.Authentication;
import util.CustomLog;
import util.MyDispatcher;
import util.StateName;

import java.io.IOException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;

import com.google.gson.Gson;

import DAO.QuestionDAO;
import DAO.TopicDAO;

public class QuestionController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	QuestionDAO questionDAO;
	TopicDAO topicDAO;

	@Override
	public void init() throws ServletException {
		questionDAO = new QuestionDAO();
		topicDAO = new TopicDAO();
	}

	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String path = request.getServletPath();
		switch (path) {
			case "/questions" :
				getQuestions(request, response);
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

	private void getQuestionDetailHandler(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		int questionID = Integer.parseInt(request.getParameter("question_id"));
		int userID = Integer.parseInt(request.getParameter("user_id"));

		Question questionDetail = questionDAO.getQuestionByID(questionID,
				userID);

		request.setAttribute("questionDetail", questionDetail);

		MyDispatcher.dispatch(request, response, "question-detail.jsp");
	}

	private void reportQuestionHandler(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String reportContent = request.getParameter("reportContent");
		int questionID = Integer.parseInt(request.getParameter("questionID"));

		boolean isReported = questionDAO.reportQuestion(questionID,
				Authentication.getCurrentUserID(request), reportContent);
		String json = new Gson().toJson(isReported);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(json);

	}
	private void getQuestions(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String activeTopic = request.getParameter("activeTopic");

		if (activeTopic == null)
			activeTopic = "All topics";

		ArrayList<Topic> topics = topicDAO.getTopics();
		topics.add(new Topic(0, "All topics"));

		request.setAttribute("topics", topics);
		request.setAttribute("activeTopic", activeTopic);

		getNewestQuestionsHandler(request, response);

	}
	private void getNewestQuestionsHandler(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String activeTopic = (String) request.getAttribute("activeTopic");

		ArrayList<Question> questions = questionDAO
				.getNewestQuestions(activeTopic);
		request.setAttribute("question_list", questions);
		MyDispatcher.dispatch(request, response, "/index.jsp");
	}

	private void createQuestionHandler(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		int topicID = Integer.parseInt(request.getParameter("questionTopic"));
		String title = request.getParameter("title");
		String[] tagContents = request.getParameter("tags").split(",");
		String questionContent = request.getParameter("question_content");

		questionDAO.createQuestion(Authentication.getCurrentUserID(request),
				questionContent, title, tagContents, topicID);

		response.sendRedirect("questions");
	}

	private void voteQuestionHandler(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String voteType = request.getParameter("voteType");
		int questionID = Integer.parseInt(request.getParameter("questionId"));
		int currentUserID = Authentication.getCurrentUserID(request);
		boolean isVoted = false;
		String json;
		try {
			questionDAO.voteQuestion(currentUserID, questionID, voteType);
		} catch (SQLIntegrityConstraintViolationException e) {
			System.out.println("User have already voted");
			isVoted = false;
			json = new Gson().toJson(isVoted);
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
			return;
		} catch (Exception e) {
			System.out.println("global Exception: ");
			e.printStackTrace();
		}
		isVoted = true;
		json = new Gson().toJson(isVoted);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(json);
	}

}
