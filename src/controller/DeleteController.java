package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import DAO.DeleteUserDAO;
import DAO.UserListDAO;

/**
 * Servlet implementation class DeleteController
 */
public class DeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DeleteUserDAO deleteUserDAO;
    UserListDAO userDAO;
    @Override
	public void init(ServletConfig config) throws ServletException {
		deleteUserDAO = new DeleteUserDAO();
		userDAO= new UserListDAO();
	}

    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int UserID = Integer.parseInt(request.getParameter("UserID"));
		deleteUserDAO.deleteUserByID(UserID);
		RequestDispatcher dispatcher = request.getRequestDispatcher("UserListContrroller");
		dispatcher.forward(request, response);

	}

}
