package DAO;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;

import model.Comment;
import model.Question;
import model.ReplyComment;

public class QuestionDAO extends BaseDAO {
	public void createQuestion(Question question, int[] tagIDs) {
		String createQuestionQuery = "INSERT INTO questions (user_id, question_content, title, created_at) VALUES (?, ?, ?, NOW());";
		String insertQuestionTagsQuery = "INSERT INTO question_tags (question_id, tag_id) VALUES (?, ?);";

		try {
			int questionID = executeInsert(createQuestionQuery,
					question.getUserID(), question.getQuestionContent(),
					question.getTitle());

			for (int tagID : tagIDs) {
				executeInsert(insertQuestionTagsQuery, questionID, tagID);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public ArrayList<Question> getNewestQuestions() {

		ArrayList<Question> questions = new ArrayList<Question>();

		String query = "SELECT q.question_id, u.user_id, u.username, q.created_at AS createdAt,  q.title, q.question_content AS questionContent, GROUP_CONCAT(t.tag_content) AS tag_content "
				+ "FROM  users u JOIN   questions q ON u.user_id = q.user_id LEFT JOIN "
				+ "    question_tags qt ON q.question_id = qt.question_id LEFT JOIN "
				+ "    tags t ON qt.tag_id = t.tag_id GROUP BY q.question_id ORDER BY q.created_at DESC;";
		try {
			ResultSet result = executeQuery(query);
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

		String query = "SELECT u.username AS username, q.created_at AS createdAt, q.title AS title, "
				+ "q.question_content AS questionContent, GROUP_CONCAT(t.tag_content) AS tagContents, "
				+ "IFNULL(upvotes, 0) AS upvotes, IFNULL(downvotes, 0) AS downvotes, EXISTS ( "
				+ "    SELECT 1  FROM bookmarks b  WHERE b.user_id = ? AND b.question_id = q.question_id "
				+ ") AS isBookmarked FROM questions q JOIN users u ON q.user_id = u.user_id "
				+ "LEFT JOIN question_tags qt ON q.question_id = qt.question_id LEFT JOIN "
				+ "tags t ON qt.tag_id = t.tag_id LEFT JOIN ( "
				+ "    SELECT question_id, SUM(CASE WHEN vote_type = 'upvote' THEN 1 ELSE 0 END) AS upvotes "
				+ "    FROM votes_question GROUP BY question_id "
				+ ") AS upvote_counts ON q.question_id = upvote_counts.question_id LEFT JOIN ( "
				+ "    SELECT question_id, SUM(CASE WHEN vote_type = 'downvote' THEN 1 ELSE 0 END) AS downvotes "
				+ "    FROM votes_question  GROUP BY question_id ) AS downvote_counts ON q.question_id = "
				+ " downvote_counts.question_id WHERE q.question_id = ?";

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

}
