package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ReplyComment;
import model.User;
import util.Authentication;

import java.io.IOException;
import java.util.Date;

import com.google.gson.Gson;

import DAO.CommentDAO;
import DAO.UserDAO;

/**
 * Servlet implementation class ReplyController
 */
public class ReplyController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	CommentDAO commentDAO;
	UserDAO userDAO;

	@Override
	public void init() throws ServletException {
		commentDAO = new CommentDAO();
		userDAO = new UserDAO();

	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String replyContent = request.getParameter("replyContent");
		int commentID = Integer.parseInt(request.getParameter("commentID"));
		int questionID = Integer.parseInt(request.getParameter("questionID"));
		int userReplyID = Integer.parseInt(request.getParameter("userReplyID"));
		int currentUserID = Authentication.getCurrentUserID(request);
		Date currentDate = new Date();
		ReplyComment replyComment = new ReplyComment(commentID, currentUserID,
				replyContent, userReplyID);
		replyComment.setCreatedAt(currentDate);

		int replyID = commentDAO.replyComment(replyComment);

		String currentUsername = Authentication.getCurrentUsername(request);
		User user = userDAO.getUserProfile(userReplyID); // HERE
		User currentUserProfile = userDAO.getUserProfile(currentUserID); // HERE

		ReplyComment reply = new ReplyComment();
		reply.setReplyID(replyID);
		reply.setCommentID(commentID);
		reply.setUserID(currentUserID);
		reply.setUsername(currentUsername);
		reply.setUserReplyID(userReplyID);
		reply.setUsernameReply(user.getUsername());
		reply.setReplyContent(replyContent);
		reply.setCreatedAt(currentDate);
		reply.setUserPhoto(currentUserProfile.getPhoto());

		String json = new Gson().toJson(reply);

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(json);

	}

}
