package util;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class MyDispatcher {
	public static void dispatch(HttpServletRequest request, HttpServletResponse response, String destinationPath)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher(destinationPath);
		dispatcher.forward(request, response);
	}
}
