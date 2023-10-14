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

public class QuestionDAO extends BaseDAO {
	public void createQuestion(int userID, String questionContent, String title,
			String[] tags, int topicID) {
		String createQuestionQuery = "INSERT INTO questions (user_id, question_content, title, tags, topic_id, created_at) VALUES (? ,?, ?, ?, ?, NOW());";

		try {
			executeNonQuery(createQuestionQuery, userID, questionContent, title,
					String.join(",", tags), topicID);

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public ArrayList<Question> getNewestQuestions(String topicName) {

		ArrayList<Question> questions = new ArrayList<Question>();
		String query = null;
		ResultSet result = null;
		try {

			if (topicName.equals("All topics")) {
				query = "SELECT "
						+ "q.question_id, u.user_id, u.username, q.created_at AS createdAt, "
						+ "q.title, q.question_content AS questionContent, q.tags AS tag_content "
						+ "FROM questions q JOIN users u ON q.user_id = u.user_id "
						+ "GROUP BY q.question_id, u.user_id, u.username, createdAt, q.title, questionContent, tag_content "
						+ "ORDER BY createdAt DESC";
				result = executeQuery(query);

			} else {
				query = "SELECT q.question_id, u.user_id, u.username, q.created_at AS createdAt, "
						+ "q.title, q.question_content AS questionContent, q.tags AS tag_content "
						+ "FROM questions q "
						+ "JOIN users u ON q.user_id = u.user_id "
						+ "JOIN topics t ON q.topic_id = t.topic_id "
						+ "WHERE t.topic_name = ? "
						+ "GROUP BY q.question_id, u.user_id, u.username, createdAt, q.title, questionContent, tag_content "
						+ "ORDER BY createdAt DESC";
				result = executeQuery(query, topicName);

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
				questions.add(new Question(userID, questionID, username,
						createdAt, title, questionContent, tagContents));
			}

			return questions;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;

		}

	}

	// Retrieve user photo, username, createdAt (question), title,
	// questionContent, tags, vote, bookmark
	public Question getQuestionByID(int questionID, int userID) {

		Question question = null;
		// ArrayList<Comment> comments = new ArrayList<Comment>();

		String query = "SELECT " + "u.username AS username, "
				+ "q.created_at AS createdAt, " + "q.title AS title, "
				+ "q.question_content AS questionContent, "
				+ "q.tags AS tagContents, " + "IFNULL(upvotes, 0) AS upvotes, "
				+ "IFNULL(downvotes, 0) AS downvotes, " + "EXISTS ("
				+ "    SELECT 1 " + "    FROM bookmarks b "
				+ "    WHERE b.user_id = ? "
				+ "    AND b.question_id = q.question_id" + ") AS isBookmarked "
				+ "FROM questions q " + "JOIN users u ON q.user_id = u.user_id "
				+ "LEFT JOIN (SELECT question_id, SUM(CASE WHEN vote_type = 'upvote' THEN 1 ELSE 0 END) AS upvotes "
				+ "           FROM votes_question GROUP BY question_id) AS upvote_counts ON q.question_id = upvote_counts.question_id "
				+ "LEFT JOIN (SELECT question_id, SUM(CASE WHEN vote_type = 'downvote' THEN 1 ELSE 0 END) AS downvotes "
				+ "           FROM votes_question GROUP BY question_id) AS downvote_counts ON q.question_id = downvote_counts.question_id "
				+ "WHERE q.question_id = ?";

		try {
			ResultSet result = executeQuery(query, userID, questionID);
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

				question = new Question(questionID, userID, username,
						questionContent, title, createdAt, tagContents, upvotes,
						downvotes, isBookmarked);

			}

			CommentDAO commentDAO = new CommentDAO();
			ArrayList<Comment> comments = commentDAO.getComments(questionID, 1);

			question.setComments(comments);

		} catch (SQLException e) {
			System.out.println("in DAO");
			e.printStackTrace();
		}
		return question;

	}

	public void reportQuestion(int questionID, int userID,
			String reportContent) {
		String query = "INSERT INTO report_questions (question_id, user_id, report_content) VALUES (?, ?, ?);";

		try {
			executeUpdate(query, questionID, userID, reportContent);
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public ArrayList<QuestionReport> getQuestionReports(int rowsPerPage,
			int currentPage) {

		ArrayList<QuestionReport> questionReports = new ArrayList<QuestionReport>();

		String query = "SELECT " + "rq.report_id, " + "rq.question_id, "
				+ "q.title, " + "q.user_id AS reported_user_id, "
				+ "rq.user_id AS reporting_user_id, "
				+ "u.username AS reporting_username, " + "rq.report_content "
				+ "FROM report_questions rq "
				+ "INNER JOIN questions q ON rq.question_id = q.question_id "
				+ "INNER JOIN users u ON rq.user_id = u.user_id "
				+ "LIMIT ? OFFSET ?;";

		try {
			ResultSet result = executeQuery(query, rowsPerPage,
					(currentPage - 1) * rowsPerPage);

			while (result.next()) {
				int reportID = result.getInt("report_id");
				int questionID = result.getInt("question_id");
				String title = result.getString("title");
				int reportedUserID = result.getInt("reported_user_id");
				int reportingUserID = result.getInt("reporting_user_id");
				String reportingUsername = result
						.getString("reporting_username");
				String reportContent = result.getString("report_content");

				QuestionReport questionReport = new QuestionReport(reportID,
						questionID, title, reportingUserID, reportedUserID,
						reportingUsername, reportContent);
				questionReports.add(questionReport);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return questionReports;
	}

	public int getTotalQuestionReportsRecords() {
		return getTotalRecords("report_questions");
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

	public static void main(String[] args) {
		QuestionDAO questionDAO = new QuestionDAO();
		// ArrayList<Question> newestQuetions =
		// questionDAO.getNewestQuestions();
		// Question questionDetail = questionDAO.getQuestionByID(7, 9);
		String[] tags = {"javascript, css, html"};
		questionDAO.createQuestion(9, "Please explain to me", "What is react?",
				tags, 1);
	}

}
