package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ReplyComment;
import util.Authentication;

import java.io.IOException;

import DAO.CommentDAO;

/**
 * Servlet implementation class ReplyController
 */
public class ReplyController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	CommentDAO commentDAO;

	@Override
	public void init() throws ServletException {
		commentDAO = new CommentDAO();
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String replyContent = request.getParameter("replyContent");
		int commentID = Integer.parseInt(request.getParameter("comment_id"));
		int questionID = Integer.parseInt(request.getParameter("question_id"));
		int userReplyID = Integer.parseInt(request.getParameter("user_id"));
		int currentUserID = Authentication.getCurrentUserID(request);

		commentDAO.replyComment(new ReplyComment(commentID, currentUserID, replyContent, userReplyID));

		response.sendRedirect("question-detail?question_id=" + questionID + "&user_id=" + userReplyID + "");

	}

}
