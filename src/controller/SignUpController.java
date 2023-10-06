package controller;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import util.Authentication;
import util.MyDispatcher;
import util.PasswordEncryption;

import java.io.IOException;

import DAO.SignUpDAO;

public class SignUpController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	SignUpDAO signUpDAO;

	@Override
	public void init(ServletConfig config) throws ServletException {
		signUpDAO = new SignUpDAO();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		User inputUser = new User(firstName, lastName, email, PasswordEncryption.encryptPassword(password));
		User userWithID = signUpDAO.signUp(inputUser);

		if (userWithID != null) {
			request.setAttribute("signUpStatus", "success");
			MyDispatcher.dispatch(request, response, "/log-in.jsp");
		} else {
			request.setAttribute("signUpStatus", "fail");
			MyDispatcher.dispatch(request, response, "/sign-up.jsp");
		}

	}

}
