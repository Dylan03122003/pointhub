package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Topic;
import util.MyDispatcher;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;

import com.google.gson.Gson;

import DAO.TopicDAO;

public class TopicController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	TopicDAO topicDao;
	@Override
	public void init() throws ServletException {
		topicDao = new TopicDAO();
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String path = request.getServletPath();
		switch (path) {
			case "/topics" :
				viewTopicsHandler(request, response);
				break;

			default :

		}
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String path = request.getServletPath();
		switch (path) {
			case "/add-topic" :
				addTopicHandler(request, response);
				break;
			case "/update-topic" :
				updateTopicHandler(request, response);
				break;
			default :

		}
	}

	private void updateTopicHandler(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String topicName = request.getParameter("topicName");
		int topicID = Integer.parseInt(request.getParameter("topicID"));
		boolean isDuplicatedTopicname = false;
		try {
			topicDao.updateTopic(topicName, topicID);
		} catch (SQLException e) {
			System.out.println("Duplicated topic name");
			isDuplicatedTopicname = true;

		}

		String json = new Gson().toJson(isDuplicatedTopicname);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(json);

	}
	private void addTopicHandler(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String topicName = request.getParameter("topicName");
		try {
			topicDao.addTopic(topicName);
		} catch (SQLIntegrityConstraintViolationException e) {
			System.out.println("Duplicated topic name");
			request.setAttribute("duplicatedTopic", true);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		viewTopicsHandler(request, response);

	}

	private void viewTopicsHandler(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		ArrayList<Topic> topics = topicDao.getTopics();
		request.setAttribute("topics", topics);
		MyDispatcher.dispatch(request, response, "topics.jsp");
	}

}
