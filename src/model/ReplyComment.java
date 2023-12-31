package model;

import java.util.Date;

public class ReplyComment {
	private int replyID;
	private int commentID;
	private int userID;
	private String username;
	private String userPhoto;
	private String replyContent;
	private int userReplyID;
	private String usernameReply;
	private Date createdAt;
	private int likes;
	private int dislikes;

	public ReplyComment(int replyID, int commentID, int userID, String username, String replyContent, int userReplyID,
			String usernameReply, Date createdAt) {
		this.replyID = replyID;
		this.commentID = commentID;
		this.userID = userID;
		this.username = username;
		this.replyContent = replyContent;
		this.userReplyID = userReplyID;
		this.usernameReply = usernameReply;
		this.createdAt = createdAt;
	}

	public ReplyComment(int commentID, int userID, String replyContent, int userReplyID) {
		this.commentID = commentID;
		this.userID = userID;
		this.replyContent = replyContent;
		this.userReplyID = userReplyID;
	}
	
	public ReplyComment() {
		
	}

	public int getReplyID() {
		
		return replyID;
	}

	public void setReplyID(int replyID) {
		this.replyID = replyID;
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

	public String getReplyContent() {
		return replyContent;
	}

	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}

	public int getUserReplyID() {
		return userReplyID;
	}

	public void setUserReplyID(int userReplyID) {
		this.userReplyID = userReplyID;
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

	public String getUsernameReply() {
		return usernameReply;
	}

	public void setUsernameReply(String usernameReply) {
		this.usernameReply = usernameReply;
	}

	@Override
	public String toString() {
		return "ReplyComment [replyID=" + replyID + ", commentID=" + commentID + ", userID=" + userID
				+ ", replyContent=" + replyContent + ", userReplyID=" + userReplyID + ", createdAt=" + createdAt + "]";
	}

	public String getUserPhoto() {
		return userPhoto;
	}

	public void setUserPhoto(String userPhoto) {
		this.userPhoto = userPhoto;
	}

	public int getLikes() {
		return likes;
	}

	public void setLikes(int likes) {
		this.likes = likes;
	}

	public int getDislikes() {
		return dislikes;
	}

	public void setDislikes(int dislikes) {
		this.dislikes = dislikes;
	}

}
