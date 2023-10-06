package DAO;

import java.sql.SQLIntegrityConstraintViolationException;

import model.User;

public class SignUpDAO extends BaseDAO {

	public User signUp(User user) {
		try {

			String insertUserQuery = "INSERT INTO users (email, password) VALUES (?, ?)";
			int userID = executeInsert(insertUserQuery, user.getEmail(), user.getPassword());

			String insertProfileQuery = "INSERT INTO user_profile (user_id, first_name, last_name) VALUES (?, ?, ?)";

			executeInsert(insertProfileQuery, userID, user.getFirstName(), user.getLastName());

			User userWithID = new User(userID, user.getFirstName(), user.getLastName(), user.getEmail(),
					user.getPassword());

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
