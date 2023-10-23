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
import java.sql.SQLException;
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

		String path = request.getServletPath();
		switch (path) {
			case "/reply-comment" :
				replyCommentHandler(request, response);
				break;
			case "/like-reply" :
				likeReplyHandler(request, response);
				break;
			case "/dislike-reply" :
				dislikeReply(request, response);
				break;
			default :

		}

	}
	
	private void dislikeReply(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		int replyID = Integer.parseInt(request.getParameter("replyID"));
		int currentUserID = Integer
				.parseInt(request.getParameter("currentUserID"));
		int commentID = Integer.parseInt(request.getParameter("commentID"));

		boolean isDisliked = false;
		try {
			isDisliked = commentDAO.dislikeReply(currentUserID, commentID, replyID);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		String json = new Gson().toJson(isDisliked);

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(json);
	}
	
	private void likeReplyHandler(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		int replyID = Integer.parseInt(request.getParameter("replyID"));
		int currentUserID = Integer
				.parseInt(request.getParameter("currentUserID"));
		int commentID = Integer.parseInt(request.getParameter("commentID"));

		boolean isLiked = false;
		try {
			isLiked = commentDAO.likeReply(currentUserID, commentID, replyID);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		String json = new Gson().toJson(isLiked);

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(json);
	}
	private void replyCommentHandler(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
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
		User user = userDAO.getUserProfile(currentUserID, userReplyID); // HERE
		User currentUserProfile = userDAO.getUserProfile(currentUserID, currentUserID); // HERE

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
		reply.setLikes(0);
		reply.setDislikes(0);

		String json = new Gson().toJson(reply);

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(json);
	}

}
