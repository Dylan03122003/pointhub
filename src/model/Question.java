package model;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;

public class Question {
	private int questionID;
	private int userID;
	private String username;
	private String title;
	private String questionContent;
	private Date createdAt;
	private String[] tagContents;
	private int upvotes;
	private int downvotes;
	private boolean isBookmarked;
	private ArrayList<Comment> comments = new ArrayList<Comment>();

	public Question(int questionID, int userID, String questionContent, String title, Date createdAt) {
		this.questionID = questionID;
		this.userID = userID;
		this.questionContent = questionContent;
		this.title = title;
		this.createdAt = createdAt;
	}

	public Question(int userID, String questionContent, String title, String[] tagContents) {
		this.userID = userID;
		this.questionContent = questionContent;
		this.title = title;
		this.tagContents =  tagContents;
	}

	public Question(int userID, int questionID, String username, Date createdAt, String title, String questionContent,
			String[] tagContents) {
		this.userID = userID;
		this.questionID = questionID;
		this.username = username;
		this.createdAt = createdAt;
		this.title = title;
		this.questionContent = questionContent;
		this.tagContents = tagContents;
	}

	public Question(int questionID, int userID, String username, String questionContent, String title, Date createdAt,
			String[] tagContents, int upvotes, int downvotes, boolean isBookmarked) {
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

	public ArrayList<Comment> getComments() {
		return comments;
	}

	public void setComments(ArrayList<Comment> comments) {
		this.comments = comments;
	}

	public int getReplyCommentSize(int commentID) {
		for (Comment comment : comments) {
			if (commentID == comment.getCommentID()) {
				return comment.getReplyComments().size();
			}
		}

		return -1;
	}

	public void setReplyComments(int commentID, ArrayList<ReplyComment> replyComments) {
		for (Comment comment : comments) {
			if (commentID == comment.getCommentID()) {
				comment.setReplyComments(replyComments);
			}
		}
	}

	@Override
	public String toString() {
		return "Question [questionID=" + questionID + ", userID=" + userID + ", username=" + username
				+ ", questionContent=" + questionContent + ", title=" + title + ", createdAt=" + createdAt
				+ ", tagContents=" + Arrays.toString(tagContents) + ", upvotes=" + upvotes + ", downvotes=" + downvotes
				+ ", isBookmarked=" + isBookmarked + "]";
	}

}
