package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.User;
import util.Authentication;
import util.MyDispatcher;
import util.PasswordEncryption;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import com.google.gson.Gson;

import DAO.BaseDAO;
import DAO.NotificationDAO;
import DAO.UserDAO;

public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	UserDAO userDAO;

	@Override
	public void init(ServletConfig config) throws ServletException {
		userDAO = new UserDAO();
	}
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String path = request.getServletPath();
		switch (path) {
			case "/user-list" :
				listUser(request, response);
				break;
			case "/delete-user" :
				deleteUserByID(request, response);
				break;
			case "/create-user" :
				createUserController(request, response);
				break;
			case "/view-my-profile" :
				viewMyProfile(request, response);
				break;
			case "/retrieve-profile" :
				retrieveProfile(request, response);
				break;
			case "/update-profile" :
				updateProfile(request, response);
				break;
			case "/user-profile" :
				viewUserProfileHandler(request, response);
				break;
			case "/follow-user" :
				followUser(request, response);
				break;
			case "/view-followers" :
				viewFollowers(request, response);
				break;
			default :

		}
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String path = request.getServletPath();
		switch (path) {
			case "/update-profile" :
				updateProfile(request, response);
				break;
			default :

		}
	}

	private void viewFollowers(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		int followedUserID = Integer
				.parseInt(request.getParameter("followedUserID"));
		int currentFollowersSize = 0;

		if (request.getParameter("followersSize") != null) {
			currentFollowersSize = Integer
					.parseInt(request.getParameter("followersSize"));
		}
		int followersLimit = 2;
		ArrayList<User> followers = userDAO.getFollowers(followedUserID,
				followersLimit, currentFollowersSize);
		String json = new Gson().toJson(followers);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(json);
	}

	private void followUser(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		int followedUserID = Integer
				.parseInt(request.getParameter("followedUserID"));
		int currentUserID = Authentication.getCurrentUserID(request);
		try {
			boolean isFollowed = userDAO.followUser(currentUserID,
					followedUserID);

			if (isFollowed) {
				NotificationDAO notificationDAO = new NotificationDAO();
				String notificationMessage = Authentication
						.getCurrentUsername(request) + " have followed you.";
				notificationDAO.notifyFollowing(followedUserID, currentUserID,
						notificationMessage);
			}

			String json = new Gson().toJson(isFollowed);
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	private void viewUserProfileHandler(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		int viewedUserID = Integer.parseInt(request.getParameter("userID"));
		int currentUserID = Authentication.getCurrentUserID(request);

		boolean isCurrentLoggedInUser = viewedUserID == currentUserID;

		if (isCurrentLoggedInUser) {
			request.setAttribute("isCurrentUser", true);
			viewMyProfile(request, response);
			return;

		}

		User user = userDAO.getUserProfile(currentUserID, viewedUserID);
		request.setAttribute("userProfile", user);
		request.setAttribute("isCurrentUser", false);

		MyDispatcher.dispatch(request, response, "user-profile.jsp");
	}

	private void retrieveProfile(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		int userID = Integer.parseInt(request.getParameter("userID"));

		User user = userDAO.getUserProfileForUpdate(userID);

		request.setAttribute("userProfile", user);

		MyDispatcher.dispatch(request, response, "update-userProfile.jsp");

	}

	private void updateProfile(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		int currentUserID = Authentication.getCurrentUserID(request);

		String email = request.getParameter("email");
		String first_name = request.getParameter("firstname");
		String last_name = request.getParameter("lastname");
		String about = request.getParameter("about");

		String face_link = request.getParameter("facebook-link");
		String twitter_link = request.getParameter("twitter-link");
		String insta_link = request.getParameter("insta_link");
		String git_link = request.getParameter("github-link");

		String ward = request.getParameter("ward");
		String district = request.getParameter("district");
		String province = request.getParameter("province");

		User user = new User(currentUserID, first_name, last_name, email, about,
				face_link, twitter_link, insta_link, git_link, ward, district,
				province);
		userDAO.updateUserProfile(response, request, user);

		response.sendRedirect("user-profile?userID=" + currentUserID);

	}

	private void listUser(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		if ((!userDAO.isAdmin(Authentication.getCurrentUserID(request)))) {
		} else {
			if (userDAO.isAdmin(Authentication.getCurrentUserID(request))) {
				int rowsPerPage = 2;

				int currentPage = request.getParameter("page") == null
						? 1
						: Integer.parseInt(request.getParameter("page"));
				double totalUserPages = (double) Math
						.ceil((double) userDAO.getTotalUsers()
								/ (double) rowsPerPage);

				ArrayList<User> users = userDAO.getUsers(rowsPerPage,
						currentPage);
				request.setAttribute("users", users);
				request.setAttribute("currentUserPage", currentPage);
				request.setAttribute("totalUserPages", totalUserPages);
				RequestDispatcher dispatcher = request
						.getRequestDispatcher("user-list.jsp");
				dispatcher.forward(request, response);
			}

		}

	}

	private void viewMyProfile(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		int currentUserID = Authentication.getCurrentUserID(request);
		User user = userDAO.getUserProfile(currentUserID, currentUserID);
		request.setAttribute("userProfile", user);
		request.setAttribute("isCurrentUser", true);

		MyDispatcher.dispatch(request, response, "user-profile.jsp");
	}

	private void deleteUserByID(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		int UserID = Integer.parseInt(request.getParameter("UserID"));
		userDAO.deleteUserByID(UserID);
		listUser(request, response);
	}
	private void createUserController(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String email = request.getParameter("email");
		String roleUser = request.getParameter("role");
		String pass = request.getParameter("pass");
		User newUser = new User(firstName, lastName, email,
				PasswordEncryption.encryptPassword(pass), roleUser);
		User userWithID = userDAO.createUser(newUser);
		if (userWithID != null) {
			request.setAttribute("createStatus", "Add User Successfully");
			RequestDispatcher dispatcher = request
					.getRequestDispatcher("/user-list");
			dispatcher.forward(request, response);
		} else {
			request.setAttribute("createStatus", "Email is available");
			RequestDispatcher dispatcher = request
					.getRequestDispatcher("add-user.jsp");
			dispatcher.forward(request, response);
		}

	}

}
