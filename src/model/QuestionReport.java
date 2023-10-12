package model;

public class QuestionReport {
	private int reportID;
	private int questionID;
	private String title;
	private int userID;
	private String username;
	private String reportContent;

	public QuestionReport(int reportID, int questionID, String title,
			int userID, String username, String reportContent) {
		this.reportID = reportID;
		this.questionID = questionID;
		this.title = title;
		this.userID = userID;
		this.username = username;
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

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getReportContent() {
		return reportContent;
	}

	public void setReportContent(String reportContent) {
		this.reportContent = reportContent;
	}

	@Override
	public String toString() {
		return "Report ID: " + reportID + "\n" + "Question ID: " + questionID
				+ "\n" + "Title: " + title + "\n" + "User ID: " + userID + "\n"
				+ "Username: " + username + "\n" + "Report Content: "
				+ reportContent;
	}

}
