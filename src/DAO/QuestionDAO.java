package DAO;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.Question;

public class QuestionDAO extends BaseDAO {
	public void createQuestion(Question question, int[] tagIDs) {
		String createQuestionQuery = "INSERT INTO questions (user_id, question_content, title, created_at) VALUES (?, ?, ?, NOW());";
		String insertQuestionTagsQuery = "INSERT INTO question_tags (question_id, tag_id) VALUES (?, ?);";

		try {
			int questionID = executeInsert(createQuestionQuery, question.getUserID(), question.getQuestionContent(),
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

		String query = "SELECT q.question_id,  u.username, q.created_at AS createdAt,  q.title, q.question_content AS questionContent, GROUP_CONCAT(t.tag_content) AS tag_content "
				+ "FROM  users u JOIN   questions q ON u.user_id = q.user_id LEFT JOIN "
				+ "    question_tags qt ON q.question_id = qt.question_id LEFT JOIN "
				+ "    tags t ON qt.tag_id = t.tag_id GROUP BY q.question_id ORDER BY q.created_at DESC;";
		try {
			ResultSet result = executeQuery(query);
			while (result.next()) {
				int questionID = result.getInt("question_id");
				String username = result.getString("username");
				Date createdAt = result.getDate("createdAt");
				String title = result.getString("title");
				String questionContent = result.getString("questionContent");
				String[] tagContents = result.getString("tag_content").split(",");
				questions.add(new Question(questionID, username, createdAt, title, questionContent, tagContents));
			}

			return questions;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;

		}

	}

	
}
