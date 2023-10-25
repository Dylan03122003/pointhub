package model;

public class UserReported extends User {
	private String reportContent;

	public UserReported(int userID, String username, String photo,
			String reportContent, String email) {
		this.userID = userID;
		this.username = username;
		this.photo = photo;
		this.reportContent = reportContent;
		this.email = email;
	}

	public String getReportContent() {
		return reportContent;
	}

	public void setReportContent(String reportContent) {
		this.reportContent = reportContent;
	}

	@Override
	public String toString() {
		return "UserReported [reportContent=" + reportContent + ", userID="
				+ userID + ", username=" + username + ", photo=" + photo + "]";
	}

}
