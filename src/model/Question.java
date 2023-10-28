package model;

import java.util.Arrays;
import java.util.Date;

import DAO.TopicDAO;

public class Question {
	private int questionID;
	private int userID;
	private String username;
	private String userPhoto;
	private String title;
	private String questionContent;
	private Date createdAt;
	private String[] tagContents;
	private int upvotes;
	private int downvotes;
	private int voteSum;
	private boolean isBookmarked;
	private int topicID;
	private String topicName;
	private String codeblock;
	private int viewCount;

	public Question(int questionID, int userID, String questionContent,
			String title, Date createdAt) {
		this.questionID = questionID;
		this.userID = userID;
		this.questionContent = questionContent;
		this.title = title;
		this.createdAt = createdAt;
	}

	public Question(int userID, String questionContent, String title,
			String[] tagContents) {
		this.userID = userID;
		this.questionContent = questionContent;
		this.title = title;
		this.tagContents = tagContents;
	}

	public Question(int userID, int questionID, String username, Date createdAt,
			String title, String questionContent, String[] tagContents) {
		this.userID = userID;
		this.questionID = questionID;
		this.username = username;
		this.createdAt = createdAt;
		this.title = title;
		this.questionContent = questionContent;
		this.tagContents = tagContents;
	}

	public Question(int questionID, int userID, String username,
			String questionContent, String title, Date createdAt,
			String[] tagContents, int upvotes, int downvotes,
			boolean isBookmarked) {
		this.questionID = questionID;
		this.userID = userID;
		this.username = username;
		this.questionContent = questionContent;
		this.title = title;
		this.createdAt = createdAt;
		this.tagContents = tagContents;
		this.upvotes = upvotes;
		this.downvotes = downvotes;
		this.isBookmarked = isBookmarked;
	}

	// Constructor for get user questions (or) user bookmarks
	public Question(int questionID, String title, Date createdAt,
			String[] tagContents, int voteSum, String topicName) {
		this.questionID = questionID;
		this.title = title;
		this.createdAt = createdAt;
		this.tagContents = tagContents;
		this.voteSum = voteSum;
		this.topicName = topicName;
	}

	public Question() {
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

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String[] getTagContents() {
		return tagContents;
	}

	public void setTagContents(String[] tagContents) {
		this.tagContents = tagContents;
	}

	public int getUpvotes() {
		return upvotes;
	}

	public void setUpvotes(int upvotes) {
		this.upvotes = upvotes;
	}

	public int getDownvotes() {
		return downvotes;
	}

	public void setDownvotes(int downvotes) {
		this.downvotes = downvotes;
	}

	public boolean isBookmarked() {
		return isBookmarked;
	}

	public void setBookmarked(boolean isBookmarked) {
		this.isBookmarked = isBookmarked;
	}

	public int getVotesSum() {
		return this.upvotes - this.downvotes;
	}

	public int getTopicID() {
		return topicID;
	}

	public void setTopicID(int topicID) {
		this.topicID = topicID;
	}

	public String getUserPhoto() {
		return userPhoto;
	}

	public void setUserPhoto(String userPhoto) {
		this.userPhoto = userPhoto;
	}

	public String getCodeblock() {
		return codeblock;
	}

	public void setCodeblock(String codeblock) {
		this.codeblock = codeblock;
	}

	public String getLanguage() {
		TopicDAO topicDAO = new TopicDAO();
		switch (topicDAO.getTopicNameByID(this.topicID).toLowerCase()) {
			case "java" : {
				return "language-java";
			}
			case "react" : {
				return "language-javascript";
			}
			case "javascript" : {
				return "language-javascript";
			}
			case "csharp" : {
				return "language-csharp";
			}
			case "python" : {
				return "language-python";
			}
			default :
				return "";
		}
	}

	@Override
	public String toString() {
		return "Question [questionID=" + questionID + ", userID=" + userID
				+ ", username=" + username + ", userPhoto=" + userPhoto
				+ ", title=" + title + ", questionContent=" + questionContent
				+ ", createdAt=" + createdAt + ", tagContents="
				+ Arrays.toString(tagContents) + ", upvotes=" + upvotes
				+ ", downvotes=" + downvotes + ", isBookmarked=" + isBookmarked
				+ ", topicID=" + topicID + ", codeblock=" + codeblock + "]";
	}

	public int getVoteSum() {
		return voteSum;
	}

	public void setVoteSum(int voteSum) {
		this.voteSum = voteSum;
	}

	public String getTopicName() {
		return topicName;
	}

	public void setTopicName(String topicName) {
		this.topicName = topicName;
	}

	public int getViewCount() {
		return viewCount;
	}

	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}

}
