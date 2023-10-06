package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.Authentication;

import java.io.IOException;

public class LogoutController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Authentication.deleteUserCookie(request, response);
		response.sendRedirect("log-in.jsp");
	}

}
