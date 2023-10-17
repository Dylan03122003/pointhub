package controller;

import DAO.CommentDAO;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;

import com.google.gson.Gson;

import model.Comment;
import model.Question;
import model.ReplyComment;
import util.Authentication;
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
		if (path == "/load-comment") {
			// loadMoreCommentTest(request, response);
			loadMoreComment(request, response);
		} else if (path == "/view-default-comments") {
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
		}

	}

	private void createComment(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String commentContent = request.getParameter("comment");
		int questionID = Integer.parseInt(request.getParameter("question_id"));

		int currentUserID = Authentication.getCurrentUserID(request);

		Comment newComment = new Comment(currentUserID, questionID,
				commentContent);

		commentDAO.createComment(newComment);

		response.sendRedirect("question-detail?question_id=" + questionID
				+ "&user_id=" + currentUserID + "");
	}

	private void viewDefaultComments(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		int questionID = Integer.parseInt(request.getParameter("questionID"));
		ArrayList<Comment> comments = commentDAO.getComments(questionID, 2);
		// int commentID = commentResult.getInt("comment_id");
		// int userIDFromDB = commentResult.getInt("user_id");
		// String commentContent = commentResult
		// .getString("comment_content");
		// Date createdAt = commentResult.getDate("created_at");
		// String username = commentResult.getString("username");
		// Comment comment = new Comment(commentID, userIDFromDB, username,
		// questionID, commentContent, createdAt);

		String json = new Gson().toJson(comments);

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(json);

	}

	// private void loadMoreCommentTest(HttpServletRequest request,
	// HttpServletResponse response) throws IOException {
	// int questionID = Integer.parseInt(request.getParameter("question_id"));
	// int currentSize = Integer
	// .parseInt(request.getParameter("current_size"));
	//
	// // Fetch additional comments from the database based on the questionID
	// // and currentSize
	// ArrayList<Comment> comments = commentDAO.getComments(questionID,
	// currentSize);
	//
	// // Convert comments to JSON
	// String json = new Gson().toJson(comments);
	//
	// response.setContentType("application/json");
	// response.setCharacterEncoding("UTF-8");
	// response.getWriter().write(json);
	// }

	private void loadMoreComment(HttpServletRequest request,
			HttpServletResponse response) throws IOException {

		HttpSession session = request.getSession();

		Question question = (Question) session
				.getAttribute(StateName.QUESTION_DETAIL);
		int currentCommentSize = question.getComments().size();

		Comment loadedComment = commentDAO.getAComment(question.getQuestionID(),
				currentCommentSize + 1);
		if (loadedComment != null)
			question.getComments().add(loadedComment);

		session.setAttribute(StateName.QUESTION_DETAIL, question);
		response.sendRedirect("question-detail.jsp");
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
