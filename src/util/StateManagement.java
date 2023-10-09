package util;

import jakarta.servlet.http.HttpSession;

public class StateManagement {
	HttpSession session;

	public void setCommentOffSet() {
		session.setAttribute(null, session);
	}
}
