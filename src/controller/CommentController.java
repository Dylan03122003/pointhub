package controller;

import DAO.CommentDAO;
import DAO.NotificationDAO;
import DAO.QuestionDAO;
import DAO.UserDAO;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import com.google.gson.Gson;

import model.Comment;
import model.Question;
import model.ReplyComment;
import util.Authentication;
import util.CustomLog;
import util.StateName;

public class CommentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	CommentDAO commentDAO;

	@Override
	public void init(ServletConfig config) throws ServletException {
		commentDAO = new CommentDAO();
	}

	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String path = request.getServletPath();
		if (path == "/view-default-comments") {
			viewDefaultComments(request, response);
		}

	}

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String path = request.getServletPath();
		if (path == "/create-comment") {
			createComment(request, response);
		} else if (path == "/view-replies") {
			viewReplies(request, response);
		} else if (path == "/view-comments") {
			viewComments(request, response);
		} else if (path == "/like-comment") {
			likeCommentHandler(request, response);
		} else if (path == "/dislike-comment") {
			dislikeCommentHandler(request, response);
		}

	}

	private void dislikeCommentHandler(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		int commentID = Integer.parseInt(request.getParameter("commentID"));
		int currentUserID = Integer
				.parseInt(request.getParameter("currentUserID"));

		boolean isDisliked = false;
		try {
			isDisliked = commentDAO.dislikeComment(currentUserID, commentID);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// Handle notifying user
		int userIDOfComment = commentDAO.getUserIDOfComment(commentID);
		boolean commentOfCurrentUser = Authentication
				.getCurrentUserID(request) == userIDOfComment;

		if (!commentOfCurrentUser && isDisliked) {
			NotificationDAO notificationDAO = new NotificationDAO();
			String notificationMessage = "disliked your comment.";

			int questionID = commentDAO.getQuestionIDOfComment(commentID);
			notificationDAO.notifyInteractingQuestion(userIDOfComment,
					questionID, currentUserID, notificationMessage);
		}

		String json = new Gson().toJson(isDisliked);

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(json);

	}

	private void likeCommentHandler(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		int commentID = Integer.parseInt(request.getParameter("commentID"));
		int currentUserID = Integer
				.parseInt(request.getParameter("currentUserID"));

		boolean isLiked = false;
		try {
			isLiked = commentDAO.likeComment(currentUserID, commentID);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// Handle notifying user
		int userIDOfComment = commentDAO.getUserIDOfComment(commentID);
		boolean commentOfCurrentUser = Authentication
				.getCurrentUserID(request) == userIDOfComment;

		if (!commentOfCurrentUser && isLiked) {
			NotificationDAO notificationDAO = new NotificationDAO();
			String notificationMessage = "liked your comment.";

			int questionID = commentDAO.getQuestionIDOfComment(commentID);
			notificationDAO.notifyInteractingQuestion(userIDOfComment,
					questionID, currentUserID, notificationMessage);
		}

		String json = new Gson().toJson(isLiked);

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(json);

	}

	private void createComment(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String commentContent = request.getParameter("commentContent");
		int questionID = Integer.parseInt(request.getParameter("questionID"));

		int currentUserID = Authentication.getCurrentUserID(request);

		Comment newComment = new Comment(currentUserID, questionID,
				commentContent);

		int commentID = commentDAO.createComment(newComment);

		Comment createdComment = commentDAO.getCommentByID(questionID,
				commentID);

		NotificationDAO notificationDAO = new NotificationDAO();
		int userIDOfQuestion = new QuestionDAO()
				.getUserIDOfQuestion(questionID);
		boolean commentedByCurrentUser = currentUserID == userIDOfQuestion;
		if (!commentedByCurrentUser) {
			String notificationMessage = "have commented your question.";
			notificationDAO.notifyInteractingQuestion(userIDOfQuestion,
					questionID, currentUserID, notificationMessage);
		}

		String json = new Gson().toJson(createdComment);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(json);
	}

	private void viewDefaultComments(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		int questionID = Integer.parseInt(request.getParameter("questionID"));
		ArrayList<Comment> comments = commentDAO.getComments(questionID, 2);
		String json = new Gson().toJson(comments);

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(json);

	}

	private void viewComments(HttpServletRequest request,
			HttpServletResponse response) throws IOException {

		int questionID = Integer.parseInt(request.getParameter("questionID"));
		int currentCommentSize = Integer
				.parseInt(request.getParameter("currentCommentSize"));

		Comment comment = commentDAO.getAComment(questionID,
				currentCommentSize + 1);

		String json = new Gson().toJson(comment);

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(json);

	}

	private void viewReplies(HttpServletRequest request,
			HttpServletResponse response) throws IOException {

		int commentID = Integer.parseInt(request.getParameter("commentID"));
		int currentRepliesSize;
		if (request.getParameter("repliesSize") == null) {
			currentRepliesSize = 0;
		} else {
			currentRepliesSize = Integer
					.parseInt(request.getParameter("repliesSize"));
		}

		int defaultRepliesSize = 2;

		ArrayList<ReplyComment> replies = commentDAO.getNextReplies(commentID,
				defaultRepliesSize, currentRepliesSize);

		String json = new Gson().toJson(replies);

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(json);

	}

}







//
//
//package controller;
//
//import DAO.CommentDAO;
//import DAO.NotificationDAO;
//import DAO.QuestionDAO;
//import DAO.UserDAO;
//import jakarta.servlet.ServletConfig;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import java.io.IOException;
//import java.io.PrintWriter;
//import java.sql.SQLException;
//import java.util.ArrayList;
//import java.util.Date;
//
//import com.google.gson.Gson;
//
//import model.Comment;
//import model.Question;
//import model.ReplyComment;
//import util.Authentication;
//import util.CustomLog;
//import util.StateName;
//
//public class CommentController extends HttpServlet {
//	private static final long serialVersionUID = 1L;
//	CommentDAO commentDAO;
//
//	@Override
//	public void init(ServletConfig config) throws ServletException {
//		commentDAO = new CommentDAO();
//	}
//
//	@Override
//	protected void doGet(HttpServletRequest request,
//			HttpServletResponse response) throws ServletException, IOException {
//		String path = request.getServletPath();
//		if (path == "/view-default-comments") {
//			viewDefaultComments(request, response);
//		}
//
//	}
//
//	@Override
//	protected void doPost(HttpServletRequest request,
//			HttpServletResponse response) throws ServletException, IOException {
//
//		String path = request.getServletPath();
//		if (path == "/create-comment") {
//			createComment(request, response);
//		} else if (path == "/view-replies") {
//			viewReplies(request, response);
//		} else if (path == "/view-comments") {
//			viewComments(request, response);
//		} else if (path == "/like-comment") {
//			likeCommentHandler(request, response);
//		} else if (path == "/dislike-comment") {
//			dislikeCommentHandler(request, response);
//		}
//
//	}
//
//	private void dislikeCommentHandler(HttpServletRequest request,
//			HttpServletResponse response) throws IOException {
//		int commentID = Integer.parseInt(request.getParameter("commentID"));
//		int currentUserID = Integer
//				.parseInt(request.getParameter("currentUserID"));
//
//		boolean isDisliked = false;
//		try {
//			isDisliked = commentDAO.dislikeComment(currentUserID, commentID);
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//
//		// Handle notifying user
//		int userIDOfComment = commentDAO.getUserIDOfComment(commentID);
//		boolean commentOfCurrentUser = Authentication
//				.getCurrentUserID(request) == userIDOfComment;
//
//		if (!commentOfCurrentUser && isDisliked) {
//			NotificationDAO notificationDAO = new NotificationDAO();
//			String notificationMessage = "disliked your comment.";
//
//			int questionID = commentDAO.getQuestionIDOfComment(commentID);
//			notificationDAO.notifyInteractingQuestion(userIDOfComment,
//					questionID, currentUserID, notificationMessage);
//		}
//
//		String json = new Gson().toJson(isDisliked);
//
//		response.setContentType("application/json");
//		response.setCharacterEncoding("UTF-8");
//		response.getWriter().write(json);
//
//	}
//
//	private void likeCommentHandler(HttpServletRequest request,
//			HttpServletResponse response) throws IOException {
//		int commentID = Integer.parseInt(request.getParameter("commentID"));
//		int currentUserID = Integer
//				.parseInt(request.getParameter("currentUserID"));
//
//		boolean isLiked = false;
//		try {
//			isLiked = commentDAO.likeComment(currentUserID, commentID);
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//
//		// Handle notifying user
//		int userIDOfComment = commentDAO.getUserIDOfComment(commentID);
//		boolean commentOfCurrentUser = Authentication
//				.getCurrentUserID(request) == userIDOfComment;
//
//		if (!commentOfCurrentUser && isLiked) {
//			NotificationDAO notificationDAO = new NotificationDAO();
//			String notificationMessage = "liked your comment.";
//
//			int questionID = commentDAO.getQuestionIDOfComment(commentID);
//			notificationDAO.notifyInteractingQuestion(userIDOfComment,
//					questionID, currentUserID, notificationMessage);
//		}
//
//		String json = new Gson().toJson(isLiked);
//
//		response.setContentType("application/json");
//		response.setCharacterEncoding("UTF-8");
//		response.getWriter().write(json);
//
//	}
//
//	private void createComment(HttpServletRequest request,
//			HttpServletResponse response) throws IOException {
//		String commentContent = request.getParameter("commentContent");
//		int questionID = Integer.parseInt(request.getParameter("questionID"));
//
//		int currentUserID = Authentication.getCurrentUserID(request);
//
//		Comment newComment = new Comment(currentUserID, questionID,
//				commentContent);
//
//		int commentID = commentDAO.createComment(newComment);
//
//		Comment createdComment = commentDAO.getCommentByID(questionID,
//				commentID);
//
//		NotificationDAO notificationDAO = new NotificationDAO();
//		int userIDOfQuestion = new QuestionDAO()
//				.getUserIDOfQuestion(questionID);
//		boolean commentedByCurrentUser = currentUserID == userIDOfQuestion;
//		if (!commentedByCurrentUser) {
//			String notificationMessage = "have commented your question.";
//			notificationDAO.notifyInteractingQuestion(userIDOfQuestion,
//					questionID, currentUserID, notificationMessage);
//		}
//
//		String json = new Gson().toJson(createdComment);
//		response.setContentType("application/json");
//		response.setCharacterEncoding("UTF-8");
//		response.getWriter().write(json);
//	}
//
//	private void viewDefaultComments(HttpServletRequest request,
//			HttpServletResponse response) throws IOException {
//		int questionID = Integer.parseInt(request.getParameter("questionID"));
//		ArrayList<Comment> comments = commentDAO.getComments(questionID, 2);
//		String json = new Gson().toJson(comments);
//
//		response.setContentType("application/json");
//		response.setCharacterEncoding("UTF-8");
//		response.getWriter().write(json);
//
//	}
//
//	private void viewComments(HttpServletRequest request,
//			HttpServletResponse response) throws IOException {
//
//		int questionID = Integer.parseInt(request.getParameter("questionID"));
//		int currentCommentSize = Integer
//				.parseInt(request.getParameter("currentCommentSize"));
//
//		Comment comment = commentDAO.getAComment(questionID,
//				currentCommentSize + 1);
//
//		String json = new Gson().toJson(comment);
//
//		response.setContentType("application/json");
//		response.setCharacterEncoding("UTF-8");
//		response.getWriter().write(json);
//
//	}
//
//	private void viewReplies(HttpServletRequest request,
//			HttpServletResponse response) throws IOException {
//
//		int commentID = Integer.parseInt(request.getParameter("commentID"));
//		int currentRepliesSize;
//		if (request.getParameter("repliesSize") == null) {
//			currentRepliesSize = 0;
//		} else {
//			currentRepliesSize = Integer
//					.parseInt(request.getParameter("repliesSize"));
//		}
//
//		int defaultRepliesSize = 2;
//
//		ArrayList<ReplyComment> replies = commentDAO.getNextReplies(commentID,
//				defaultRepliesSize, currentRepliesSize);
//
//		String json = new Gson().toJson(replies);
//
//		response.setContentType("application/json");
//		response.setCharacterEncoding("UTF-8");
//		response.getWriter().write(json);
//
//	}
//
//}
