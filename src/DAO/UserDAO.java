package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;

import model.User;

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

	public ArrayList<User> getAllUser() {
		ArrayList<User> user = new ArrayList<>();
		try {
			PreparedStatement ps = connection.prepareStatement(
					"Select * From users WHERE role <> 'admin'");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				int userID = rs.getInt("user_id");
				String userName = rs.getString("username");
				String email = rs.getString("email");
				String photo = rs.getString("photo");
				user.add(new User(userID, userName, email, photo));
			}
		} catch (Exception e) {
		}
		return user;
	}
	public boolean isAdmin(int user_id) {
		String selectAdmin = "Select * From users Where user_id = ?;";
		try {
			ResultSet rs = executeQuery(selectAdmin, user_id);
			if (rs.next()) {
				String userRole = rs.getString("role");
				if (userRole.equals("admin")) {
					return true;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	public void deleteUserByID(int UserID) {
		try {
			PreparedStatement ps = connection
					.prepareStatement("DELETE FROM users WHERE user_id = ?");
			ps.setInt(1, UserID);
			ps.executeUpdate();
		} catch (Exception e) {
		}

	}
	public User createUser(User user) {
		try {
			String createUser = "INSERT INTO users (first_name,last_name,email,password,role,username) values (?,?,?,?,?,?)";
			int userID = executeInsert(createUser, user.getFirstName(),
					user.getLastName(), user.getEmail(), user.getPassword(),
					user.getRole(), user.getLastName() + user.getFirstName());
			User userWithID = new User(user.getFirstName(), user.getLastName(),
					user.getEmail(), user.getPassword(), user.getRole());
			return userWithID;

		} catch (SQLIntegrityConstraintViolationException e) {
			e.printStackTrace();
			return null;

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}
}
