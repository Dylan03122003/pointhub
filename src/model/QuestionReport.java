package model;

import java.util.ArrayList;

public class QuestionReport {
	private int reportID;
	private int questionID;
	private String title;
	private int usersReported;
	private int reportedUserID;

	public QuestionReport(int reportID, int questionID, String title,
			int usersReported, int reportedUserID) {
		this.reportID = reportID;
		this.questionID = questionID;
		this.title = title;
		this.usersReported = usersReported;
		this.reportedUserID = reportedUserID;
	}

	public int getReportID() {
		return reportID;
	}

	public void setReportID(int reportID) {
		this.reportID = reportID;
	}

	public int getQuestionID() {
		return questionID;
	}

	public void setQuestionID(int questionID) {
		this.questionID = questionID;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getUsersReported() {
		return usersReported;
	}

	public void setUsersReported(int usersReported) {
		this.usersReported = usersReported;
	}

	public int getReportedUserID() {
		return reportedUserID;
	}

	public void setReportedUserID(int reportedUserID) {
		this.reportedUserID = reportedUserID;
	}

}
