package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.Authentication;
import util.MyDispatcher;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

import DAO.VoteDAO;

public class VoteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	VoteDAO voteDAO;

	@Override
	public void init() throws ServletException {
		voteDAO = new VoteDAO();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String voteType = request.getParameter("voteType");
		int questionID = Integer.parseInt(request.getParameter("questionId"));
		int currentUserID = Authentication.getCurrentUserID(request);
		try {
			voteDAO.voteQuestion(currentUserID, questionID, voteType);
		} catch (SQLIntegrityConstraintViolationException e) {
			e.printStackTrace();
			request.setAttribute("violated_unique_vote", true);
			MyDispatcher.dispatch(request, response,
					"question-detail?question_id=" + questionID + "&user_id=" + currentUserID + "");
			return;
		} catch (Exception e) {
			System.out.println("global Exception: ");
			e.printStackTrace();
		}
		response.sendRedirect("question-detail?question_id=" + questionID + "&user_id=" + currentUserID + "");

	}

}
