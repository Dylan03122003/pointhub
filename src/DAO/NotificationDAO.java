package DAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import model.Notification;
import model.User;

public class NotificationDAO extends BaseDAO {

	public ArrayList<Notification> getNotifications(int notifiedUserID) {
		ArrayList<Notification> notifications = new ArrayList<Notification>();
		UserDAO userDAO = new UserDAO();

		String query = "SELECT * FROM notifications WHERE user_id = ? ORDER BY created_at DESC";

		try {
			ResultSet result = executeQuery(query, notifiedUserID);
			while (result.next()) {
				int notificationID = result.getInt("notification_id");
				int followerID = result.getInt("follower_id");
				int questionID = result.getInt("question_id");
				String message = result.getString("message");
				Date createdAt = result.getDate("created_at");
				boolean checked = result.getBoolean("checked");
				int userInteractID = result.getInt("user_interact_id");

				boolean hasFollower = followerID != 0;
				User follower = null;
				User userInteract = null;
				if (hasFollower) {
					follower = userDAO.getUserForNotification(followerID);

				} else {
					userInteract = userDAO
							.getUserForNotification(userInteractID);

				}

				Notification notification = new Notification(notificationID,
						notifiedUserID, follower, questionID, userInteract,
						message, createdAt, checked);
				notifications.add(notification);

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
			int userInteractID, String message) {
		String insertCommand = "INSERT INTO notifications (user_id, question_id, message, user_interact_id) "
				+ "VALUES (?, ?, ?, ?)";

		try {
			executeInsert(insertCommand, notifiedUserID, questionID, message,
					userInteractID);
		} catch (SQLException e) {

			e.printStackTrace();
		}
	}

	public boolean checkNotification(int notificationID) {
		String updateCommand = "UPDATE notifications " + "SET checked = 1 "
				+ "WHERE notification_id  = ?";

		try {
			executeUpdate(updateCommand, notificationID);
			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return false;
	}

	public static void main(String[] args) {
		// ArrayList<Notification> n = new
		// NotificationDAO().getNotifications(22);
		// for (Notification notification : n) {
		// System.out.println(notification.hasNewFollower());
		// System.out.println(notification.hasQuestionInteraction());
		// System.out.println("");
		// }
		// new NotificationDAO().checkNotification(72);
		// new NotificationDAO().getNotifications(30);
	}

}
