package DAO;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;

import model.Comment;
import model.Question;
import model.QuestionReport;
import model.ReplyComment;
import model.UserReported;

public class QuestionDAO extends BaseDAO {
	public void createQuestion(int userID, String questionContent, String title,
			String[] tags, int topicID, String codeBlock) {
		String insertCommand = "INSERT INTO questions (user_id, question_content, title, tags, topic_id, code_block, created_at) VALUES (? ,?, ?, ?, ?, ?, NOW());";

		try {
			executeNonQuery(insertCommand, userID, questionContent, title,
					String.join(",", tags), topicID, codeBlock);

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public ArrayList<Question> getNewestQuestions(String topicName,
			int rowsPerPage, int currentPage) {

		ArrayList<Question> questions = new ArrayList<Question>();
		String query = null;
		ResultSet result = null;
		try {

			if (topicName.equals("All topics")) {
				query = "SELECT "
						+ "q.question_id, u.user_id, u.username, u.photo, q.created_at AS createdAt, "
						+ "q.title, q.question_content AS questionContent, q.tags AS tag_content "
						+ "FROM questions q JOIN users u ON q.user_id = u.user_id "
						+ "GROUP BY q.question_id, u.user_id, u.username, createdAt, q.title, questionContent, tag_content "
						+ "ORDER BY createdAt DESC " + "LIMIT ? OFFSET ?";
				result = executeQuery(query, rowsPerPage,
						(currentPage - 1) * rowsPerPage);

			} else {
				query = "SELECT q.question_id, u.user_id, u.username, u.photo, q.created_at AS createdAt, "
						+ "q.title, q.question_content AS questionContent, q.tags AS tag_content "
						+ "FROM questions q "
						+ "JOIN users u ON q.user_id = u.user_id "
						+ "JOIN topics t ON q.topic_id = t.topic_id "
						+ "WHERE t.topic_name = ? "
						+ "GROUP BY q.question_id, u.user_id, u.username, createdAt, q.title, questionContent, tag_content "
						+ "ORDER BY createdAt DESC LIMIT ? OFFSET ?";
				result = executeQuery(query, topicName, rowsPerPage,
						(currentPage - 1) * rowsPerPage);

			}

			while (result.next()) {
				int userID = result.getInt("user_id");
				int questionID = result.getInt("question_id");
				String username = result.getString("username");
				Date createdAt = result.getDate("createdAt");
				String title = result.getString("title");
				String questionContent = result.getString("questionContent");
				String[] tagContents = result.getString("tag_content")
						.split(",");
				String photo = result.getString("photo");
				Question question = new Question(userID, questionID, username,
						createdAt, title, questionContent, tagContents);
				question.setUserPhoto(photo);
				questions.add(question);
			}

			return questions;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;

		}

	}

	public Question getQuestionByID(int questionID, int currentUserID,
			int userIDOfQuestion) {

		Question question = null;

		String query = "SELECT u.username AS username, u.photo, "
				+ "q.created_at AS createdAt, " + "q.title AS title, "
				+ "q.question_content AS questionContent, q.code_block, q.topic_id, "
				+ "q.tags AS tagContents, " + "IFNULL(upvotes, 0) AS upvotes, "
				+ "IFNULL(downvotes, 0) AS downvotes, EXISTS ("
				+ "    SELECT 1  FROM bookmarks b " + "    WHERE b.user_id = ? "
				+ "    AND b.question_id = q.question_id" + ") AS isBookmarked "
				+ "FROM questions q " + "JOIN users u ON q.user_id = u.user_id "
				+ "LEFT JOIN (SELECT question_id, SUM(CASE WHEN vote_type = 'upvote' THEN 1 ELSE 0 END) AS upvotes "
				+ "           FROM votes_question GROUP BY question_id) AS upvote_counts ON q.question_id = upvote_counts.question_id "
				+ "LEFT JOIN (SELECT question_id, SUM(CASE WHEN vote_type = 'downvote' THEN 1 ELSE 0 END) AS downvotes "
				+ "           FROM votes_question GROUP BY question_id) AS downvote_counts ON q.question_id = downvote_counts.question_id "
				+ "WHERE q.question_id = ?";

		try {
			ResultSet result = executeQuery(query, currentUserID, questionID);
			if (result.next()) {
				String username = result.getString("username");
				Date createdAt = result.getDate("createdAt");
				String title = result.getString("title");
				String questionContent = result.getString("questionContent");
				String[] tagContents = result.getString("tagContents")
						.split(",");
				int upvotes = result.getInt("upvotes");
				int downvotes = result.getInt("downvotes");
				boolean isBookmarked = result.getBoolean("isBookmarked");
				String userPhoto = result.getString("photo");
				String codeBlock = result.getString("code_block");
				int topicID = result.getInt("topic_id");

				question = new Question(questionID, userIDOfQuestion, username,
						questionContent, title, createdAt, tagContents, upvotes,
						downvotes, isBookmarked);
				question.setUserPhoto(userPhoto);
				question.setCodeblock(codeBlock);
				question.setTopicID(topicID);

			}

		} catch (SQLException e) {
			System.out.println("in DAO");
			e.printStackTrace();
		}
		return question;

	}

	public boolean reportQuestion(int questionID, int userID,
			String reportContent) {
		String query = "INSERT INTO report_questions (question_id, user_id, report_content) VALUES (?, ?, ?);";

		try {
			executeUpdate(query, questionID, userID, reportContent);

			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return false;

	}

	public ArrayList<QuestionReport> getQuestionReports(int rowsPerPage,
			int currentPage) {

		ArrayList<QuestionReport> questionReports = new ArrayList<QuestionReport>();

		String query = "SELECT rq.report_id, q.question_id, q.user_id AS reported_user_id, q.title, "
				+ "COUNT(rq.question_id) AS users_reported "
				+ "FROM report_questions rq "
				+ "JOIN questions q ON rq.question_id = q.question_id "
				+ "GROUP BY q.question_id, q.user_id, q.title "
				+ "LIMIT ? OFFSET ?";

		try {
			ResultSet result = executeQuery(query, rowsPerPage,
					(currentPage - 1) * rowsPerPage);

			while (result.next()) {
				int reportID = result.getInt("report_id");
				int questionID = result.getInt("question_id");
				String title = result.getString("title");
				int usersReported = result.getInt("users_reported");
				int reportedUserID = result.getInt("reported_user_id");
				// int reportedUserID = result.getInt("reported_user_id");
				// int reportingUserID = result.getInt("reporting_user_id");
				// String reportingUsername = result
				// .getString("reporting_username");
				// String reportContent = result.getString("report_content");
				// String userPhoto = result.getString("photo");

				QuestionReport questionReport = new QuestionReport(reportID,
						questionID, title, usersReported, reportedUserID);
				questionReports.add(questionReport);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return questionReports;
	}

	public ArrayList<UserReported> getReportDetail(int questionID, int limit,
			int currentReportDetailSize) {

		ArrayList<UserReported> usersReported = new ArrayList<UserReported>();

		String query = "SELECT u.user_id, u.username, u.email, u.photo, rq.report_content "
				+ "FROM report_questions rq "
				+ "JOIN users u ON rq.user_id = u.user_id "
				+ "WHERE rq.question_id = ? LIMIT ? OFFSET ?";

		try {
			ResultSet result = executeQuery(query, questionID, limit,
					currentReportDetailSize);

			while (result.next()) {
				int userID = result.getInt("user_id");
				String username = result.getString("username");
				String photo = result.getString("photo");
				String reportContent = result.getString("report_content");
				String email = result.getString("email");

				usersReported.add(new UserReported(userID, username, photo,
						reportContent, email));

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return usersReported;
	}

	public int getTotalQuestionReportsRecords() {
		String query = "SELECT COUNT(DISTINCT question_id) AS total_records FROM report_questions;";

		try {
			ResultSet result = executeQuery(query);

			if (result.next()) {
				return result.getInt("total_records");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;

	}

	public int getTotalQuestionRecords() {
		return getTotalRecords("questions");
	}

	public int getTotalQuestionsByTopic(int topicID) {
		String query = "SELECT COUNT(*) as total_questions FROM questions WHERE topic_id = ?";

		try {
			ResultSet result = executeQuery(query, topicID);
			if (result.next()) {
				return result.getInt("total_questions");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return -1;

	}

	public void voteQuestion(int userID, int questionID, String voteType)
			throws SQLException {

		boolean userClickUpvote = voteType.equals("upvote");
		boolean userClickDownvote = voteType.equals("downvote");

		if (userClickUpvote
				&& userAlreadyVoted(userID, questionID, "downvote")) {
			deleteVote(userID, questionID, "downvote");
			return;
		}

		if (userClickDownvote
				&& userAlreadyVoted(userID, questionID, "upvote")) {
			deleteVote(userID, questionID, "upvote");
			return;
		}
		String insertSQL = "INSERT INTO votes_question (user_id, question_id, vote_type) VALUES (?, ?, ?)";
		executeInsert(insertSQL, userID, questionID, voteType);

	}

	public void deleteVote(int userID, int questionID, String voteType) {
		String query = "DELETE FROM votes_question WHERE user_id = ?  AND question_id = ? "
				+ "AND vote_type = ?;";
		try {
			executeUpdate(query, userID, questionID, voteType);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public boolean userAlreadyVoted(int userID, int questionID,
			String voteType) {
		String query = "SELECT * FROM votes_question WHERE user_id = ?  AND question_id = ?  AND vote_type = ?;";
		try {
			ResultSet result = executeQuery(query, userID, questionID,
					voteType);
			return result.next();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;

	}

	public boolean bookmarkQuestion(int userID, int questionID)
			throws SQLException {
		String insertCommand = "INSERT INTO bookmarks (user_id, question_id) VALUES (?, ?)";
		String deleteCommand = "DELETE FROM bookmarks WHERE user_id = ? AND question_id = ?";

		try {
			executeInsert(insertCommand, userID, questionID);

			return true;
		} catch (SQLException e) {
			executeUpdate(deleteCommand, userID, questionID);
			System.out.println("Delete bookmark");
			return false;
		}
	}

	public ArrayList<Question> getQuestionsOfUser(int userID) {
		String query = "SELECT * FROM questions WHERE user_id = ?";
		ArrayList<Question> questions = new ArrayList<Question>();

		try {
			ResultSet result = executeQuery(query, userID);
			while (result.next()) {
				int questionID = result.getInt("question_id");

				Question question = new Question();
				question.setQuestionID(questionID);

				questions.add(question);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return questions;

	}

	public boolean deleteQuestion(int questionID) {
		String deleteCommand = "DELETE FROM questions WHERE question_id = ?";

		try {
			executeNonQuery(deleteCommand, questionID);
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return false;

	}

	public ArrayList<Question> getUserPosts(int userID, int limit,
			int currentPostSize) {
		ArrayList<Question> userQuestions = new ArrayList<Question>();

		String query = "SELECT " + "q.question_id AS questionID, " + "q.title, "
				+ "q.created_at, " + "q.tags, "
				+ "(IFNULL(upvotes, 0) - IFNULL(downvotes, 0)) AS voteSum, "
				+ "t.topic_name AS topicName " + "FROM questions q "
				+ "LEFT JOIN "
				+ "(SELECT question_id, SUM(CASE WHEN vote_type = 'upvote' THEN 1 ELSE 0 END) AS upvotes "
				+ " FROM votes_question GROUP BY question_id) AS upvote_counts ON q.question_id = upvote_counts.question_id "
				+ "LEFT JOIN "
				+ "(SELECT question_id, SUM(CASE WHEN vote_type = 'downvote' THEN 1 ELSE 0 END) AS downvotes "
				+ " FROM votes_question GROUP BY question_id) AS downvote_counts ON q.question_id = downvote_counts.question_id "
				+ "LEFT JOIN topics t ON q.topic_id = t.topic_id "
				+ "WHERE q.user_id = ? LIMIT ? OFFSET ?";

		try {
			ResultSet resultSet = executeQuery(query, userID, limit,
					currentPostSize);
			while (resultSet.next()) {
				int questionID = resultSet.getInt("questionID");
				String title = resultSet.getString("title");
				Date createdAt = resultSet.getDate("created_at");
				String[] tags = resultSet.getString("tags").split(",");
				int voteSum = resultSet.getInt("voteSum");
				String topicName = resultSet.getString("topicName");

				Question question = new Question(questionID, title, createdAt,
						tags, voteSum, topicName);
				userQuestions.add(question);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return userQuestions;

	}

	public ArrayList<Question> getUserBookmarks(int userID, int limit,
			int currentBookmarkSize) {
		ArrayList<Question> userBookmarks = new ArrayList<Question>();

		String query = "SELECT " + "q.question_id AS questionID, "
				+ "q.title AS title, " + "q.created_at AS createdAt, "
				+ "q.tags AS tags, "
				+ "SUM(CASE WHEN v.vote_type = 'upvote' THEN 1 ELSE 0 END) - SUM(CASE WHEN v.vote_type = 'downvote' THEN 1 ELSE 0 END) AS voteSum, "
				+ "t.topic_name AS topicName " + "FROM bookmarks b "
				+ "JOIN questions q ON b.question_id = q.question_id "
				+ "LEFT JOIN votes_question v ON q.question_id = v.question_id "
				+ "JOIN topics t ON q.topic_id = t.topic_id "
				+ "WHERE b.user_id = ? "
				+ "GROUP BY q.question_id, q.title, q.created_at, q.tags, t.topic_name LIMIT ? OFFSET ?";

		try {
			ResultSet resultSet = executeQuery(query, userID, limit,
					currentBookmarkSize);

			while (resultSet.next()) {
				int questionID = resultSet.getInt("questionID");
				String title = resultSet.getString("title");
				Date createdAt = resultSet.getDate("createdAt");
				String[] tags = resultSet.getString("tags").split(",");
				int voteSum = resultSet.getInt("voteSum");
				String topicName = resultSet.getString("topicName");
				Question question = new Question(questionID, title, createdAt,
						tags, voteSum, topicName);
				userBookmarks.add(question);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return userBookmarks;
	}

	public int getUserIDOfQuestion(int questionID) {
		String selectQuery = "SELECT user_id FROM questions WHERE question_id = ?";

		try {
			ResultSet result = executeQuery(selectQuery, questionID);

			if (result.next()) {
				return result.getInt("user_id");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		throw new Error("There is not username with that questionID");
	}

	public static void main(String[] args) {
		QuestionDAO questionDAO = new QuestionDAO();
		// ArrayList<Question> newestQuetions =
		// questionDAO.getNewestQuestions();
		// Question questionDetail = questionDAO.getQuestionByID(7, 9);
		// System.out.println(questionDAO.getQuestionsOfUser(19));
		// questionDAO.getUserPosts(19);
	}

}
