package controller;

import DAO.CommentDAO;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

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
//			loadMoreCommentTest(request, response);
			 loadMoreComment(request, response);
		} else if (path == "/show-replies") {
			showReplies(request, response);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String commentContent = request.getParameter("comment");
		int questionID = Integer.parseInt(request.getParameter("question_id"));

		int currentUserID = Authentication.getCurrentUserID(request);

		Comment newComment = new Comment(currentUserID, questionID,
				commentContent);

		commentDAO.createComment(newComment);

		response.sendRedirect("question-detail?question_id=" + questionID
				+ "&user_id=" + currentUserID + "");
	}

	private void loadMoreCommentTest(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		int questionID = Integer.parseInt(request.getParameter("question_id"));
		int currentSize = Integer
				.parseInt(request.getParameter("current_size"));

		// Fetch additional comments from the database based on the questionID
		// and currentSize
		ArrayList<Comment> comments = commentDAO.getComments(questionID,
				currentSize);

		// Convert comments to JSON
		String json = new Gson().toJson(comments);

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(json);
	}

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

	private void showReplies(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		int commentID = Integer.parseInt(request.getParameter("commentID"));

		HttpSession session = request.getSession();
		Question question = (Question) session
				.getAttribute(StateName.QUESTION_DETAIL);

		int replyCommentSize = question.getReplyCommentSize(commentID);

		ArrayList<ReplyComment> replyComments = commentDAO.getReplyComments(
				commentID, replyCommentSize + StateName.NUMBER_OF_REPLIES);
		question.setReplyComments(commentID, replyComments);

		session.setAttribute(StateName.QUESTION_DETAIL, question);
		response.sendRedirect("question-detail.jsp");
	}

}
