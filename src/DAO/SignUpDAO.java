package DAO;

import java.sql.SQLIntegrityConstraintViolationException;

import model.User;

public class SignUpDAO extends BaseDAO {

	public User signUp(User user) {
		try {

			String insertUserQuery = "INSERT INTO users (email, password, username, first_name, last_name) VALUES (?, ?, ?, ?, ?)";
			int userID = executeInsert(insertUserQuery, user.getEmail(),
					user.getPassword(),
					user.getLastName() + user.getFirstName(),
					user.getFirstName(), user.getLastName());

			user.setUserID(userID);
			User userWithID = user;

			return userWithID;

		} catch (SQLIntegrityConstraintViolationException e) {
			e.printStackTrace();
			return null;
		} catch (Exception e) {
			System.out.println("Global exception");
			e.printStackTrace();
			return null;

		}
	}
}
