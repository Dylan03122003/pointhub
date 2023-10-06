package DAO;


import java.sql.ResultSet;


import util.PasswordEncryption;

public class LogInDAO extends BaseDAO {

	public LogInDAO() {

	}

	public boolean logIn(String email, String password) {
		String encryptedPassword = PasswordEncryption.encryptPassword(password);

		String query = "SELECT * FROM users WHERE email = ? and password = ?;";

		try {

			ResultSet resultSet = executeQuery(query, email, encryptedPassword);

			return resultSet.next();

		} catch (Exception e) {
			System.out.println("Message: " + e.getMessage());
			return false;
		}

	}

}
