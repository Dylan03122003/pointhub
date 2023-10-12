package state;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class StateManagement {
	protected HttpSession session;

	public StateManagement(HttpServletRequest request) {
		session = request.getSession();
	}

}
