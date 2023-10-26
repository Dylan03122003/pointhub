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
import java.sql.SQLException;
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
				break;

			case "/delete-question" :
				deleteQuestion(request, response);
				break;
			case "/view-user-questions" :
				viewUserQuestionsHandler(request, response);
				break;
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
			case "/bookmark-question" :
				bookmarkQuestion(request, response);
				break;
			default :

		}

	}

	private void viewUserQuestionsHandler(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		int userID = Integer.parseInt(request.getParameter("userID"));
		int currentPostSize = request.getParameter("currentPostSize") != null
				? Integer.parseInt(request.getParameter("currentPostSize"))
				: 0;
		int postsLimit = 2;
		ArrayList<Question> userPosts = questionDAO.getUserPosts(userID,
				postsLimit, currentPostSize);

		String json = new Gson().toJson(userPosts);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(json);
	}

	private void deleteQuestion(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		int questionID = Integer.parseInt(request.getParameter("questionID"));

		boolean isDeleted = questionDAO.deleteQuestion(questionID);

		if (isDeleted) {
			System.out.println("question is deleted");
			String json = new Gson().toJson(isDeleted);
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
		}

	}

	private void bookmarkQuestion(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		int questionID = Integer.parseInt(request.getParameter("questionID"));
		int currentUserID = Integer
				.parseInt(request.getParameter("currentUserID"));
		try {
			boolean isBookmarked = questionDAO.bookmarkQuestion(currentUserID,
					questionID);

			String json = new Gson().toJson(isBookmarked);
			response.setContentType("application/json");

			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	private void getQuestionDetailHandler(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		int questionID = Integer.parseInt(request.getParameter("question_id"));
		int currentUserID = Authentication.getCurrentUserID(request);
		int userIDOfQuestion = Integer
				.parseInt(request.getParameter("user_id"));

		Question questionDetail = questionDAO.getQuestionByID(questionID,
				currentUserID, userIDOfQuestion);
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
	@SuppressWarnings("unchecked")
	private void getNewestQuestionsHandler(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String activeTopic = (String) request.getAttribute("activeTopic");
		ArrayList<Topic> topics = (ArrayList<Topic>) request
				.getAttribute("topics");
		int activeTopicID = 1;

		for (Topic topic : topics) {
			if (topic.getTopicName().equals(activeTopic)) {
				activeTopicID = topic.getTopicID();
			}
		}

		int rowsPerPage = 2;

		int currentPage = request.getParameter("page") == null
				? 1
				: Integer.parseInt(request.getParameter("page"));

		ArrayList<Question> questions = questionDAO
				.getNewestQuestions(activeTopic, rowsPerPage, currentPage);

		int totalQuestions = activeTopic.equals("All topics")
				? questionDAO.getTotalQuestionRecords()
				: questionDAO.getTotalQuestionsByTopic(activeTopicID);

		double totalQuestionsPages = (double) Math
				.ceil((double) totalQuestions / (double) rowsPerPage);

		request.setAttribute("currentQuestionPage", currentPage);
		request.setAttribute("totalQuestionPages", totalQuestionsPages);
		request.setAttribute("question_list", questions);
		MyDispatcher.dispatch(request, response, "/index.jsp");
	}

	private void createQuestionHandler(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		int topicID = Integer.parseInt(request.getParameter("questionTopic"));
		String title = request.getParameter("title");
		String[] tagContents = request.getParameter("tags").split(",");
		String questionContent = request.getParameter("question_content");
		String codeBlock = request.getParameter("code_block");

		questionDAO.createQuestion(Authentication.getCurrentUserID(request),
				questionContent, title, tagContents, topicID, codeBlock);

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
