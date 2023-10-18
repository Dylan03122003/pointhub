package model;

import java.util.ArrayList;
import java.util.Date;

public class Comment {
	private int commentID;
	private int userID;
	private String username;
	private String userPhoto;
	private int questionID;
	private String commentContent;
	private Date createdAt;
	private ArrayList<ReplyComment> replyComments = new ArrayList<ReplyComment>();

	public Comment(int commentID, int userID, int questionID, String commentContent, Date createdAt) {
		this.commentID = commentID;
		this.userID = userID;
		this.questionID = questionID;
		this.commentContent = commentContent;
		this.createdAt = createdAt;
	}

	public Comment(int commentID, int userID, String username, int questionID, String commentContent, Date createdAt) {
		this.commentID = commentID;
		this.userID = userID;
		this.username = username;
		this.questionID = questionID;
		this.commentContent = commentContent;
		this.createdAt = createdAt;
	}

	public Comment(int userID, int questionID, String commentContent) {
		this.userID = userID;
		this.questionID = questionID;
		this.commentContent = commentContent;
	}

	public Comment() {
	}

	public int getCommentID() {
		return commentID;
	}

	public void setCommentID(int commentID) {
		this.commentID = commentID;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public int getQuestionID() {
		return questionID;
	}

	public void setQuestionID(int questionID) {
		this.questionID = questionID;
	}

	public String getCommentContent() {
		return commentContent;
	}

	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
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

	public ArrayList<ReplyComment> getReplyComments() {
		return replyComments;
	}

	public void setReplyComments(ArrayList<ReplyComment> replyComments) {
		this.replyComments = replyComments;
	}


	public String getUserPhoto() {
		return userPhoto;
	}

	public void setUserPhoto(String userPhoto) {
		this.userPhoto = userPhoto;
	}

	@Override
	public String toString() {
		return "Comment [commentID=" + commentID + ", userID=" + userID
				+ ", username=" + username + ", userPhoto=" + userPhoto
				+ ", questionID=" + questionID + ", commentContent="
				+ commentContent + ", createdAt=" + createdAt
				+ ", replyComments=" + replyComments + "]";
	}
	

	

}
