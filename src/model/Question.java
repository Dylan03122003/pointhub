package model;

import java.util.Date;

public class Question {
	private int questionID;
	private int userID;
	private String username;
	private String questionContent;
	private String title;
	private Date createdAt;
	private String[] tagContents;

	public Question(int questionID, int userID, String questionContent, String title, Date createdAt) {
		this.questionID = questionID;
		this.userID = userID;
		this.questionContent = questionContent;
		this.title = title;
		this.createdAt = createdAt;
	}

	public Question(int userID, String questionContent, String title) {
		this.userID = userID;
		this.questionContent = questionContent;
		this.title = title;
	}

	public Question(int questionID, String username, Date createdAt, String title, String questionContent,
			String[] tagContents) {
		this.questionID = questionID;
		this.username = username;
		this.createdAt = createdAt;
		this.title = title;
		this.questionContent = questionContent;
		this.tagContents = tagContents;
	}

	public int getQuestionID() {
		return questionID;
	}

	public void setQuestionID(int questionID) {
		this.questionID = questionID;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public String getQuestionContent() {
		return questionContent;
	}

	public void setQuestionContent(String questionContent) {
		this.questionContent = questionContent;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	@Override
	public String toString() {
		return "Question [questionID=" + questionID + ", userID=" + userID + ", questionContent=" + questionContent
				+ ", title=" + title + ", createdAt=" + createdAt + "]";
	}

}
