package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import util.Authentication;
import util.MyDispatcher;
import util.StateName;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;

import DAO.UserDAO;

@MultipartConfig
public class UpdateFileController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		Part filePart = request.getPart("photo");
		String fileName = filePart.getSubmittedFileName();
		int userID = Authentication.getCurrentUserID(request);
		int time = (int) new Date().getTime();
		String uploadDirectory = StateName.IMG_PATH;
		String completeFileName = "user-" + userID + "-" + time + "-"
				+ fileName;
		String path = uploadDirectory + completeFileName;

		try (InputStream inputStream = filePart.getInputStream();
				FileOutputStream fileOutputStream = new FileOutputStream(
						path)) {
			byte[] buffer = new byte[1024];
			int bytesRead;
			while ((bytesRead = inputStream.read(buffer)) != -1) {
				fileOutputStream.write(buffer, 0, bytesRead);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		UserDAO userDAO = new UserDAO();
		boolean isUpdated = userDAO.updateUserPhoto(completeFileName, userID);

		if (isUpdated) {
			response.sendRedirect("view-my-profile");
		}
	}

}
