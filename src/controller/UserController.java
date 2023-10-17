package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import util.Authentication;
import util.PasswordEncryption;
import java.io.IOException;
import java.util.ArrayList;

import DAO.UserDAO;

/**
 * Servlet implementation class UserController
 */
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
			default :

		}
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

	}

	private void listUser(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		if ((!userDAO.isAdmin(Authentication.getCurrentUserID(request)))) {
		} else {
			if (userDAO.isAdmin(Authentication.getCurrentUserID(request))) {
				ArrayList<User> users = userDAO.getAllUser();
				request.setAttribute("users", users);
				RequestDispatcher dispatcher = request
						.getRequestDispatcher("user-list.jsp");
				dispatcher.forward(request, response);
			}

		}

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
