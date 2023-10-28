package DAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import model.Notification;

public class NotificationDAO extends BaseDAO {

	public ArrayList<Notification> getNotifications(int notifiedUserID) {
		ArrayList<Notification> notifications = new ArrayList<Notification>();
		String query = "SELECT * FROM notifications WHERE user_id = ?";

		try {
			ResultSet result = executeQuery(query, notifiedUserID);
			while (result.next()) {
				int notificationID = result.getInt("notification_id");
				int followerID = result.getInt("follower_id");
				int questionID = result.getInt("question_id");
				String message = result.getString("message");
				Date createdAt = result.getDate("created_at");
				boolean checked = result.getBoolean("checked");

				notifications.add(new Notification(notificationID,
						notifiedUserID, followerID, questionID, message,
						createdAt, checked));
			}
		} catch (SQLException e) {

			e.printStackTrace();
		}

		return notifications;
	}

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
	
	
//	public static void main(String[] args) {
//		ArrayList<Notification> n = new NotificationDAO().getNotifications(22);
//		for (Notification notification : n) {
//			System.out.println(notification.hasNewFollower());
//			System.out.println(notification.hasQuestionInteraction());
//			System.out.println("");
//		}
//	}

}
