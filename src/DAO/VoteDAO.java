package DAO;

import java.sql.ResultSet;
import java.sql.SQLException;

public class VoteDAO extends BaseDAO {
	public void voteQuestion(int userID, int questionID, String voteType) throws SQLException {

		boolean userClickUpvote = voteType.equals("upvote");
		boolean userClickDownvote = voteType.equals("downvote");

		if (userClickUpvote && userAlreadyVoted(userID, questionID, "downvote")) {
			deleteVote(userID, questionID, "downvote");
			return;
		}

		if (userClickDownvote && userAlreadyVoted(userID, questionID, "upvote")) {
			deleteVote(userID, questionID, "upvote");
			return;
		}
		String insertSQL = "INSERT INTO votes_question (user_id, question_id, vote_type) VALUES (?, ?, ?)";
		executeInsert(insertSQL, userID, questionID, voteType);

	}

	public void deleteVote(int userID, int questionID, String voteType) {
		String query = "DELETE FROM votes_question WHERE user_id = ?  AND question_id = ? " + "AND vote_type = ?;";
		try {
			executeUpdate(query, userID, questionID, voteType);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public boolean userAlreadyVoted(int userID, int questionID, String voteType) {
		String query = "SELECT * FROM votes_question WHERE user_id = ?  AND question_id = ?  AND vote_type = ?;";
		try {
			ResultSet result = executeQuery(query, userID, questionID, voteType);
			return result.next();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;

	}
}
