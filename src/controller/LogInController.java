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

import DAO.LogInDAO;

public class LogInController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	LogInDAO loginDAO = null;

	@Override
	public void init(ServletConfig config) throws ServletException {
		loginDAO = new LogInDAO();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");


		boolean loginSuccess = loginDAO.logIn(email, password);

		if (!loginSuccess) {
			request.setAttribute("loginStatus", "fail");
			MyDispatcher.dispatch(request, response, "/log-in.jsp");
		} else {
			Authentication.setUserCookie(response, email);
			response.sendRedirect("index.jsp");
		}

	}

}
