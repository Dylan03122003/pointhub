package util;

import DAO.UserDAO;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class Authentication {

	public static void setUserCookie(HttpServletResponse response, String email) {

		Cookie cookie = new Cookie("user_cookie", email);

		int oneYear = 60 * 60 * 24 * 365;

		cookie.setMaxAge(oneYear);

		response.addCookie(cookie);
	}

	public static void deleteUserCookie(HttpServletRequest request, HttpServletResponse response) {
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("user_cookie")) {
					cookie.setMaxAge(0);
					response.addCookie(cookie);
					return;
				}
			}
		}
	}

	public static boolean isLoggedIn(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		String email = null;

		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if ("user_cookie".equals(cookie.getName())) {
					email = cookie.getValue();
					break;
				}
			}
		}

		if (email == null) {
			return false;
		} else {
			return true;
		}
	}

	public static String getCurrentEmail(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		String email = null;

		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if ("user_cookie".equals(cookie.getName())) {
					email = cookie.getValue();
					break;
				}
			}
		}

		return email;
	}

	public static int getCurrentUserID(HttpServletRequest request) {
		String currentEmail = Authentication.getCurrentEmail(request);
		UserDAO userDAO = new UserDAO();
		return userDAO.getUserIDByEmail(currentEmail);

	}

	public static String getCurrentUsername(HttpServletRequest request) {
		String currentEmail = Authentication.getCurrentEmail(request);
		UserDAO userDAO = new UserDAO();
		return userDAO.getUsernameByEmail(currentEmail);
	}

}
