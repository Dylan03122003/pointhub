package DAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.Topic;

public class TopicDAO extends BaseDAO {
	public ArrayList<Topic> getTopics() {
		ArrayList<Topic> topics = new ArrayList<Topic>();
		String query = "SELECT * FROM topics";
		try {
			ResultSet result = executeQuery(query);
			while (result.next()) {
				int topicID = result.getInt("topic_id");
				String topicName = result.getString("topic_name");
				topics.add(new Topic(topicID, topicName));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return topics;
	}

	public String getTopicNameByID(int topicID) {
		String topicName = "";
		String query = "SELECT topic_name FROM topics WHERE topic_id = ?";
		try {
			ResultSet result = executeQuery(query, topicID);
			if (result.next()) {
				topicName = result.getString("topic_name");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return topicName;
	}

	public void addTopic(String topicName) throws SQLException {
		String insertTopicCommand = "INSERT INTO topics (topic_name) VALUES (?)";

		executeInsert(insertTopicCommand, topicName);

	}

	public void updateTopic(String topicName, int topicID)
			throws SQLException {
		String updateTopicCommand = "UPDATE topics SET topic_name = ? WHERE topic_id = ?";

		executeUpdate(updateTopicCommand, topicName, topicID);

	}

	public static void main(String[] args) {

		// CustomLog.logList(new TopicDAO().getAllTopics());

	}
}
