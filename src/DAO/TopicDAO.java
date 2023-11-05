package DAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.Topic;

public class TopicDAO extends BaseDAO {
	public ArrayList<Topic> getTopics() {
		ArrayList<Topic> topics = new ArrayList<Topic>();
		String query = "SELECT t.topic_id, t.topic_name, COUNT(q.topic_id) AS question_count "
				+ "FROM topics t "
				+ "LEFT JOIN questions q ON t.topic_id = q.topic_id "
				+ "GROUP BY t.topic_id, t.topic_name"
				+ "";
		try {
			ResultSet result = executeQuery(query);
			while (result.next()) {
				int topicID = result.getInt("topic_id");
				String topicName = result.getString("topic_name");
				int countQuestion = result.getInt("question_count");
				topics.add(new Topic(topicID, topicName, countQuestion));
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


}
