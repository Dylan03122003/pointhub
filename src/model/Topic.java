package model;

public class Topic {
	private int topicID;
	private String topicName;

	public Topic(int topicID, String topicName) {
		this.topicID = topicID;
		this.topicName = topicName;
	}
	public int getTopicID() {
		return topicID;
	}
	public void setTopicID(int topicID) {
		this.topicID = topicID;
	}
	public String getTopicName() {
		return topicName;
	}
	public void setTopicName(String topicName) {
		this.topicName = topicName;
	}
	@Override
	public String toString() {
		return "Topic [topicID=" + topicID + ", topicName=" + topicName + "]";
	}

}
