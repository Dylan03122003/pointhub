package DAO;

import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO extends BaseDAO {
	public int getUserIDByEmail(String email) {
		String query = "SELECT * FROM users WHERE email = ?;";

		try {
			ResultSet result = executeQuery(query, email);
			if (result.next()) {
				int userID = result.getInt("user_id");
				return userID;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}

	public String getUsernameByEmail(String email) {
		String query = "SELECT username FROM users WHERE email = ?;";

		try {
			ResultSet result = executeQuery(query, email);
			if (result.next()) {
				String username = result.getString("username");
				return username;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public String getUserRoleByEmail(String email) {
		String query = "SELECT role FROM users WHERE email = ?;";

		try {
			ResultSet result = executeQuery(query, email);
			if (result.next()) {
				String role = result.getString("role");
				return role;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public static void main(String[] args) {
		System.out.println("hello");
	}
}
