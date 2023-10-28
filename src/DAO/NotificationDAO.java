package DAO;

import java.sql.SQLException;

public class NotificationDAO extends BaseDAO {
	public void notifyFollowing(int notifiedUserID, int followerID,
			String message) {
		String insertCommand = "INSERT INTO notifications (user_id, follower_id, message) "
				+ "VALUES (?, ?, ?);";

		try {
			executeInsert(insertCommand, notifiedUserID, followerID, message);
		} catch (SQLException e) {

			e.printStackTrace();
		}
	}

	public void notifyInteractingQuestion(int notifiedUserID, int questionID,
			String message) {
		String insertCommand = "INSERT INTO notifications (user_id, question_id, message) "
				+ "VALUES (?, ?, ?)";

		try {
			executeInsert(insertCommand, notifiedUserID, questionID, message);
		} catch (SQLException e) {

			e.printStackTrace();
		}
	}

}
