package model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

public class Notification {
	private int notificationID;
	private int notifiedUserID;
	private User follower;
	private int questionID;
	private User userInteract;
	private String message;
	private Date createdAt;
	private boolean checked;

	public Notification(int notificationID, int notifiedUserID, User follower,
			int questionID, User userInteract, String message, Date createdAt,
			boolean checked) {
		this.notificationID = notificationID;
		this.notifiedUserID = notifiedUserID;
		this.follower = follower;
		this.questionID = questionID;
		this.userInteract = userInteract;
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
		return this.follower != null;
	}

	public boolean hasQuestionInteraction() {
		return this.questionID != 0;
	}

	public User getFollower() {
		return follower;
	}

	public void setFollower(User follower) {
		this.follower = follower;
	}

	public User getUserInteract() {
		return userInteract;
	}

	public void setUserInteract(User userInteract) {
		this.userInteract = userInteract;
	}

}
