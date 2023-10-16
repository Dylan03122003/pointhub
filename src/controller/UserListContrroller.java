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

import java.io.IOException;
import java.util.ArrayList;

import DAO.UserListDAO;

/**
 * Servlet implementation class UserListContrroller
 */
public class UserListContrroller extends HttpServlet {
	private static final long serialVersionUID = 1L;
    UserListDAO userListDAO;

	@Override
	public void init(ServletConfig config) throws ServletException {
	userListDAO = new UserListDAO();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if((!userListDAO.isAdmin(Authentication.getCurrentUserID(request)))) {
	     }else{ 
	    	 if(userListDAO.isAdmin(Authentication.getCurrentUserID(request))) {
	    		 ArrayList<User> users = userListDAO.getAllUser();
		 	     request.setAttribute("users", users);
		 	     RequestDispatcher dispatcher = request.getRequestDispatcher("user-list.jsp");
		 	     dispatcher.forward(request, response);
	    	 }
	 		
	     }
	}

	
}
