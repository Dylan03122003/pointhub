package model;

public class Topic {
	private int topicID;
	private String topicName;
	private int countQuestion;

	public Topic(int topicID, String topicName) {
		this.topicID = topicID;
		this.topicName = topicName;
	
		
	}
	public Topic(int topicID, String topicName, int counQuestion) {
		this.topicID = topicID;
		this.topicName = topicName;
		this.countQuestion = counQuestion;
		
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
	public int getCountQuestion() {
		return countQuestion;
	}
	public void setCountQuestion(int countQuestion) {
		this.countQuestion = countQuestion;
	}
	@Override
	public String toString() {
		return "Topic [topicID=" + topicID + ", topicName=" + topicName + ", countQuestion="+ countQuestion +"]";
	}

}
