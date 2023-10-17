package DAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import model.Comment;
import model.ReplyComment;

public class CommentDAO extends BaseDAO {
	public int createComment(Comment comment) {
		String insertSQL = "INSERT INTO comments (user_id, question_id, comment_content) VALUES (?, ?, ?)";

		try {
			int commentID = executeInsert(insertSQL, comment.getUserID(),
					comment.getQuestionID(), comment.getCommentContent());

			return commentID;
		} catch (SQLException e) {

			e.printStackTrace();
		}

		return -1;

	}

	public int replyComment(ReplyComment replyComment) {
		String insertSQL = "INSERT INTO replies (comment_id, user_id, user_reply_id, reply_content, created_at) VALUES (?, ?, ?, ?, ?)";
		try {
			int replyID = executeInsert(insertSQL, replyComment.getCommentID(),
					replyComment.getUserID(), replyComment.getUserReplyID(),
					replyComment.getReplyContent(),
					replyComment.getCreatedAt());

			return replyID;

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return -1;

	}

	public ArrayList<ReplyComment> getNextReplies(int commentID, int limit,
			int currentRepliesSize) {
		ArrayList<ReplyComment> replyComments = new ArrayList<ReplyComment>();

		String query = "SELECT r.reply_id, r.user_id, r.reply_content, r.user_reply_id, r.created_at, u.username AS username, ur.username AS usernameReply "
				+ "FROM replies r INNER JOIN users u ON r.user_id = u.user_id "
				+ "LEFT JOIN users ur ON r.user_reply_id = ur.user_id "
				+ "WHERE r.comment_id = ? " + "LIMIT ? OFFSET ?";
		try {
			ResultSet result = executeQuery(query, commentID, limit,
					(currentRepliesSize - limit) + limit);
			while (result.next()) {
				int replyID = result.getInt("reply_id");
				int userID = result.getInt("user_id");
				String replyContent = result.getString("reply_content");
				int userReplyID = result.getInt("user_reply_id");
				Date createdAt = result.getDate("created_at");
				String username = result.getString("username");
				String usernameReply = result.getString("usernameReply");

				ReplyComment replyComment = new ReplyComment(replyID, commentID,
						userID, username, replyContent, userReplyID,
						usernameReply, createdAt);
				replyComments.add(replyComment);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return replyComments;
	}

	public ArrayList<Comment> getComments(int questionID, int commentLimit) {
		ArrayList<Comment> comments = new ArrayList<Comment>();
		String commentQuery = "SELECT c.comment_id, c.user_id, c.comment_content, c.created_at, u.username "
				+ "FROM comments c JOIN users u ON c.user_id = u.user_id WHERE c.question_id = ? LIMIT ?";

		ResultSet commentResult;
		try {
			commentResult = executeQuery(commentQuery, questionID,
					commentLimit);

			while (commentResult.next()) {
				int commentID = commentResult.getInt("comment_id");
				int userIDFromDB = commentResult.getInt("user_id");
				String commentContent = commentResult
						.getString("comment_content");
				Date createdAt = commentResult.getDate("created_at");
				String username = commentResult.getString("username");
				Comment comment = new Comment(commentID, userIDFromDB, username,
						questionID, commentContent, createdAt);

				comments.add(comment);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return comments;
	}

	public Comment getAComment(int questionID, int ordinal) {
		Comment comment = null;
		String commentQuery = "SELECT c.comment_id, c.user_id, c.comment_content, c.created_at, u.username "
				+ "FROM comments c JOIN users u ON c.user_id = u.user_id WHERE c.question_id = ? LIMIT 1 OFFSET ?";

		ResultSet commentResult;
		try {
			commentResult = executeQuery(commentQuery, questionID, ordinal - 1);

			if (commentResult.next()) {
				int commentID = commentResult.getInt("comment_id");
				int userIDFromDB = commentResult.getInt("user_id");
				String commentContent = commentResult
						.getString("comment_content");
				Date createdAt = commentResult.getDate("created_at");
				String username = commentResult.getString("username");
				comment = new Comment(commentID, userIDFromDB, username,
						questionID, commentContent, createdAt);

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return comment;
	}

	public Comment getCommentByID(int questionID, int commentID) {
		Comment comment = null;
		String commentQuery = "SELECT c.comment_id, c.user_id, c.comment_content, c.created_at, u.username "
				+ "FROM comments c JOIN users u ON c.user_id = u.user_id WHERE c.question_id = ? AND c.comment_id = ?";

		ResultSet commentResult;
		try {
			commentResult = executeQuery(commentQuery, questionID, commentID);

			if (commentResult.next()) {
				int userIDFromDB = commentResult.getInt("user_id");
				String commentContent = commentResult
						.getString("comment_content");
				Date createdAt = commentResult.getDate("created_at");
				String username = commentResult.getString("username");
				comment = new Comment(commentID, userIDFromDB, username,
						questionID, commentContent, createdAt);

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return comment;
	}

//	 public static void main(String[] args) {
//	 CommentDAO commentDAO = new CommentDAO();
//	 }

}
