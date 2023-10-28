package model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

public class Notification {
	private int notificationID;
	private int notifiedUserID;
	private int followerID;
	private int questionID;
	private String message;
	private Date createdAt;
	private boolean checked;

	public Notification(int notificationID, int notifiedUserID, int followerID,
			int questionID, String message, Date createdAt, boolean checked) {
		this.notificationID = notificationID;
		this.notifiedUserID = notifiedUserID;
		this.followerID = followerID;
		this.questionID = questionID;
		this.message = message;
		this.createdAt = createdAt;
		this.checked = checked;
	}

	public int getNotificationID() {
		return notificationID;
	}

	public void setNotificationID(int notificationID) {
		this.notificationID = notificationID;
	}

	public int getNotifiedUserID() {
		return notifiedUserID;
	}

	public void setNotifiedUserID(int notifiedUserID) {
		this.notifiedUserID = notifiedUserID;
	}

	public int getFollowerID() {
		return followerID;
	}

	public void setFollowerID(int followerID) {
		this.followerID = followerID;
	}

	public int getQuestionID() {
		return questionID;
	}

	public void setQuestionID(int questionID) {
		this.questionID = questionID;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public String getRelativeTime() throws ParseException {
		TimeZone utcTimeZone = TimeZone.getTimeZone("UTC");
		TimeZone ictTimeZone = TimeZone.getTimeZone("ICT");

		// Set the time zone for the current date
		Calendar calendar = Calendar.getInstance(ictTimeZone);
		Date now = calendar.getTime(); // Current date and time

		// Set the time zone for the createdAt date (assuming it's in UTC)
		calendar.setTimeZone(utcTimeZone);
		long timeDifference = now.getTime() - createdAt.getTime();
		long seconds = timeDifference / 1000;
		long minutes = seconds / 60;
		long hours = minutes / 60;
		long days = hours / 24;
		long months = days / 30;
		long years = months / 12;

		if (years > 0) {
			return years + (years > 1 ? " years" : " year") + " ago";
		} else if (months > 0) {
			return months + (months > 1 ? " months" : " month") + " ago";
		} else if (days > 0) {
			return days + (days > 1 ? " days" : " day") + " ago";
		} else if (hours > 0) {
			return hours + (hours > 1 ? " hours" : " hour") + " ago";
		} else if (minutes > 0) {
			return minutes + (minutes > 1 ? " minutes" : " minute") + " ago";
		} else {
			return seconds + (seconds > 1 ? " seconds" : " second") + " ago";
		}
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean checked) {
		this.checked = checked;
	}

	public boolean hasNewFollower() {
		return this.followerID != 0;
	}

	public boolean hasQuestionInteraction() {
		return this.questionID != 0;
	}
	@Override
	public String toString() {
		return "Notification [notificationID=" + notificationID
				+ ", notifiedUserID=" + notifiedUserID + ", followerID="
				+ followerID + ", questionID=" + questionID + ", message="
				+ message + ", createdAt=" + createdAt + ", checked=" + checked
				+ "]";
	}

}
