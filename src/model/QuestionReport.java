package model;

public class QuestionReport {
	private int reportID;
	private int questionID;
	private String title;
	private int reportingUserID;
	private int reportedUserID;
	private String reportingUsername;
	private String reportContent;
	
	
	

	public QuestionReport(int reportID, int questionID, String title,
			int reportingUserID, int reportedUserID, String reportingUsername,
			String reportContent) {
		this.reportID = reportID;
		this.questionID = questionID;
		this.title = title;
		this.reportingUserID = reportingUserID;
		this.reportedUserID = reportedUserID;
		this.reportingUsername = reportingUsername;
		this.reportContent = reportContent;
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

	public String getReportContent() {
		return reportContent;
	}

	public void setReportContent(String reportContent) {
		this.reportContent = reportContent;
	}

	public int getReportingUserID() {
		return reportingUserID;
	}

	public void setReportingUserID(int reportingUserID) {
		this.reportingUserID = reportingUserID;
	}

	public int getReportedUserID() {
		return reportedUserID;
	}

	public void setReportedUserID(int reportedUserID) {
		this.reportedUserID = reportedUserID;
	}

	public String getReportingUsername() {
		return reportingUsername;
	}

	public void setReportingUsername(String reportingUsername) {
		this.reportingUsername = reportingUsername;
	}

	@Override
	public String toString() {
		return "QuestionReport [reportID=" + reportID + ", questionID="
				+ questionID + ", title=" + title + ", reportingUserID="
				+ reportingUserID + ", reportedUserID=" + reportedUserID
				+ ", reportingUsername=" + reportingUsername
				+ ", reportContent=" + reportContent + "]";
	}

}
