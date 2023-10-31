package DAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
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

		String query = "SELECT r.reply_id, r.user_id, r.reply_content, r.user_reply_id, r.created_at, u.username AS username, u.photo, ur.username AS usernameReply, "
				+ "(SELECT COUNT(*) FROM interactions WHERE reply_id = r.reply_id AND is_like = 1) AS likes, "
				+ "(SELECT COUNT(*) FROM interactions WHERE reply_id = r.reply_id AND is_like = 0) AS dislikes "
				+ "FROM replies r "
				+ "INNER JOIN users u ON r.user_id = u.user_id "
				+ "LEFT JOIN users ur ON r.user_reply_id = ur.user_id "
				+ "WHERE r.comment_id = ? LIMIT ? OFFSET ?";
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
				String userPhoto = result.getString("photo");
				int likes = result.getInt("likes");
				int dislikes = result.getInt("dislikes");

				ReplyComment replyComment = new ReplyComment(replyID, commentID,
						userID, username, replyContent, userReplyID,
						usernameReply, createdAt);
				replyComment.setUserPhoto(userPhoto);
				replyComment.setLikes(likes);
				replyComment.setDislikes(dislikes);
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
		String commentQuery = "SELECT "
				+ "c.comment_id, c.user_id, c.comment_content, c.created_at, u.username, u.photo, "
				+ "COALESCE(likes.likes_count, 0) AS likes, COALESCE(dislikes.dislikes_count, 0) AS dislikes "
				+ "FROM comments c JOIN users u ON c.user_id = u.user_id "
				+ "LEFT JOIN ( "
				+ "    SELECT comment_id, COUNT(*) AS likes_count "
				+ "    FROM interactions   WHERE comment_id IS NOT NULL "
				+ "    AND is_like = 1   AND reply_id IS NULL "
				+ "    GROUP BY comment_id "
				+ ") AS likes ON c.comment_id = likes.comment_id "
				+ "LEFT JOIN ( "
				+ "    SELECT comment_id, COUNT(*) AS dislikes_count "
				+ "    FROM interactions    WHERE comment_id IS NOT NULL "
				+ "    AND is_like = 0    AND reply_id IS NULL "
				+ "    GROUP BY comment_id "
				+ ") AS dislikes ON c.comment_id = dislikes.comment_id "
				+ "WHERE c.question_id = ? LIMIT ?";

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
				String userPhoto = commentResult.getString("photo");
				int likes = commentResult.getInt("likes");
				int dislikes = commentResult.getInt("dislikes");

				Comment comment = new Comment(commentID, userIDFromDB, username,
						questionID, commentContent, createdAt);

				comment.setUserPhoto(userPhoto);
				comment.setLikes(likes);
				comment.setDislikes(dislikes);
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
		String commentQuery = "SELECT c.comment_id, c.user_id, c.comment_content, c.created_at, u.username, u.photo, "
				+ "(SELECT COUNT(*) FROM interactions WHERE comment_id = c.comment_id AND reply_id IS NULL AND is_like = 1) AS likes, "
				+ "(SELECT COUNT(*) FROM interactions WHERE comment_id = c.comment_id AND reply_id IS NULL AND is_like = 0) AS dislikes "
				+ "FROM comments c " + "JOIN users u ON c.user_id = u.user_id "
				+ "WHERE c.question_id = ? LIMIT 1 OFFSET ?";

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
				String userPhoto = commentResult.getString("photo");
				int likes = commentResult.getInt("likes");
				int dislikes = commentResult.getInt("dislikes");

				comment = new Comment(commentID, userIDFromDB, username,
						questionID, commentContent, createdAt);
				comment.setUserPhoto(userPhoto);
				comment.setLikes(likes);
				comment.setDislikes(dislikes);

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return comment;
	}

	public Comment getCommentByID(int questionID, int commentID) {
		Comment comment = null;
		String commentQuery = "SELECT c.comment_id, c.user_id, c.comment_content, c.created_at, u.username, u.photo, "
				+ "COALESCE(likes.likes_count, 0) AS likes, COALESCE(dislikes.dislikes_count, 0) AS dislikes "
				+ "FROM comments c JOIN users u ON c.user_id = u.user_id "
				+ "LEFT JOIN ("
				+ "    SELECT comment_id, COUNT(*) AS likes_count "
				+ "    FROM interactions    WHERE comment_id = ? AND reply_id IS NULL "
				+ "    AND is_like = 1 "
				+ ") AS likes ON c.comment_id = likes.comment_id "
				+ "LEFT JOIN ("
				+ "    SELECT comment_id, COUNT(*) AS dislikes_count "
				+ "    FROM interactions    WHERE comment_id = ? AND reply_id IS NULL "
				+ "    AND is_like = 0 "
				+ ") AS dislikes ON c.comment_id = dislikes.comment_id "
				+ "WHERE c.question_id = ? AND c.comment_id = ?";

		ResultSet commentResult;
		try {
			commentResult = executeQuery(commentQuery, commentID, commentID,
					questionID, commentID);

			if (commentResult.next()) {
				int userIDFromDB = commentResult.getInt("user_id");
				String commentContent = commentResult
						.getString("comment_content");
				Date createdAt = commentResult.getDate("created_at");
				String username = commentResult.getString("username");
				String userPhoto = commentResult.getString("photo");
				int likes = commentResult.getInt("likes");
				int dislikes = commentResult.getInt("dislikes");

				comment = new Comment(commentID, userIDFromDB, username,
						questionID, commentContent, createdAt);
				comment.setUserPhoto(userPhoto);
				comment.setLikes(likes);
				comment.setDislikes(dislikes);

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return comment;
	}

	public boolean likeComment(int userID, int commentID) throws SQLException {
		String insertCommand = "INSERT INTO interactions (user_id, comment_id, is_like) VALUES (?, ?, 1)";
		String deleteCommand = "DELETE FROM interactions WHERE user_id = ? AND comment_id = ? AND reply_id IS NULL AND is_like = 1";
		String selectCommand = "SELECT * FROM interactions WHERE user_id = ? AND comment_id = ? AND reply_id IS NULL AND is_like = 1";
		try {

			boolean alreadyLiked = executeQuery(selectCommand, userID,
					commentID).next();
			if (!alreadyLiked) {
				executeInsert(insertCommand, userID, commentID);
			} else {
				executeUpdate(deleteCommand, userID, commentID);
				return false;

			}

			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return false;
	}

	public boolean dislikeComment(int userID, int commentID)
			throws SQLException {
		String insertCommand = "INSERT INTO interactions (user_id, comment_id, is_like) VALUES (?, ?, 0)";
		String deleteCommand = "DELETE FROM interactions WHERE user_id = ? AND comment_id = ? AND reply_id IS NULL AND is_like = 0";
		String selectCommand = "SELECT * FROM interactions WHERE user_id = ? AND comment_id = ? AND reply_id IS NULL AND is_like = 0";

		try {
			boolean alreadyDisliked = executeQuery(selectCommand, userID,
					commentID).next();
			if (!alreadyDisliked) {
				executeInsert(insertCommand, userID, commentID);
			} else {
				executeUpdate(deleteCommand, userID, commentID);
				return false;
			}

			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return false;
	}

	public boolean likeReply(int userID, int commentID, int replyID)
			throws SQLException {
		String insertCommand = "INSERT INTO interactions (user_id, comment_id, reply_id, is_like) VALUES (?, ?, ?, 1)";
		String deleteCommand = "DELETE FROM interactions WHERE user_id = ? AND comment_id = ? AND reply_id = ?  AND is_like = 1";

		try {
			executeInsert(insertCommand, userID, commentID, replyID);

			return true;
		} catch (SQLException e) {
			executeUpdate(deleteCommand, userID, commentID, replyID);
		}

		return false;
	}

	public boolean dislikeReply(int userID, int commentID, int replyID)
			throws SQLException {
		String insertCommand = "INSERT INTO interactions (user_id, comment_id, reply_id, is_like) VALUES (?, ?, ?, 0)";
		String deleteCommand = "DELETE FROM interactions WHERE user_id = ? AND comment_id = ? AND reply_id = ?  AND is_like = 0";

		try {
			executeInsert(insertCommand, userID, commentID, replyID);

			return true;
		} catch (SQLException e) {
			executeUpdate(deleteCommand, userID, commentID, replyID);
		}

		return false;
	}

	public int getUserIDOfComment(int commentID) {
		String query = "SELECT user_id FROM comments WHERE comment_id = ?";

		try {
			ResultSet result = executeQuery(query, commentID);
			if (result.next()) {
				return result.getInt("user_id");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		throw new Error("There is no userID with that commentID");

	}

	public int getQuestionIDOfComment(int commentID) {
		String query = "SELECT question_id FROM comments WHERE comment_id = ?";

		try {
			ResultSet result = executeQuery(query, commentID);
			if (result.next()) {
				return result.getInt("question_id");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		throw new Error("There is no question_id with that commentID");

	}

	public int getUserIDOfReply(int replyID) {
		String query = "SELECT user_id FROM replies WHERE reply_id = ?";

		try {
			ResultSet result = executeQuery(query, replyID);
			if (result.next()) {
				return result.getInt("user_id");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		throw new Error("There is no user_id with that replyID");

	}

	public boolean canCommnet(int currentUserID, int questionID) {
		String select = "SELECT COUNT(*) AS comment_count "
				+ "FROM comments WHERE user_id = ? " + "AND question_id = ?";

		try {
			ResultSet result = executeQuery(select, currentUserID, questionID);
			if (result.next()) {
				int commentCount = result.getInt("comment_count");

				if (commentCount < 3) {
					return true;
				} else {
					return false;
				}
			}

		} catch (SQLException e) {

			e.printStackTrace();
		}

		return false;

	}
	
	public boolean canReply(int currentUserID, int commentID) {
		String select = "SELECT COUNT(*) AS reply_count "
				+ "FROM replies WHERE user_id = ? " + "AND comment_id = ?";

		try {
			ResultSet result = executeQuery(select, currentUserID, commentID);
			if (result.next()) {
				int replyCount = result.getInt("reply_count");

				if (replyCount < 3) {
					return true;
				} else {
					return false;
				}
			}

		} catch (SQLException e) {

			e.printStackTrace();
		}

		return false;

	}

	public static void main(String[] args) {
		CommentDAO commentDAO = new CommentDAO();
		commentDAO.canCommnet(23, 26);
	}

}
