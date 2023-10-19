package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;

import model.User;

public class UserDAO extends BaseDAO {

	public User getUserProfile(int userID) {
		String query = "SELECT u.email, u.username, u.photo, "
				+ "u.about, sa.facebook_link, sa.twitter_link, "
				+ "sa.instagram_link, sa.github_link, "
				+ "COUNT(q.question_id) AS total_questions FROM users u "
				+ "LEFT JOIN social_accounts sa ON u.user_id = sa.user_id "
				+ "LEFT JOIN questions q ON u.user_id = q.user_id "
				+ "WHERE u.user_id = ?";

		try {
			ResultSet result = executeQuery(query, userID);
			if (result.next()) {
				String email = result.getString("email");
				String username = result.getString("username");
				String photo = result.getString("photo");
				String about = result.getString("about");
				String facebookLink = result.getString("facebook_link");
				String twitterLink = result.getString("twitter_link");
				String instagramLink = result.getString("instagram_link");
				String githubLink = result.getString("github_link");
				int totalQuestions = result.getInt("total_questions");
				User user = new User(userID, username, email, photo, about,
						facebookLink, twitterLink, instagramLink, githubLink,
						totalQuestions);

				return user;
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}

	public User getUserProfileForUpdate(int userID) {
		String query = "SELECT u.email, u.first_name, u.last_name, u.photo, u.about, sa.facebook_link, sa.twitter_link, sa.instagram_link, sa.github_link, l.ward, l.district, l.province, COUNT(q.question_id) AS total_questions "
				+ "FROM users u "
				+ "LEFT JOIN social_accounts sa ON u.user_id = sa.user_id "
				+ "LEFT JOIN questions q ON u.user_id = q.user_id "
				+ "LEFT JOIN locations l ON u.location_id = l.location_id "
				+ "WHERE u.user_id = ?";

		try {
			ResultSet resultSet = executeQuery(query, userID);
			if (resultSet.next()) {
				String email = resultSet.getString("email");
				String firstName = resultSet.getString("first_name");
				String lastName = resultSet.getString("last_name");
				String photo = resultSet.getString("photo");
				String about = resultSet.getString("about");
				String facebookLink = resultSet.getString("facebook_link");
				String twitterLink = resultSet.getString("twitter_link");
				String instagramLink = resultSet.getString("instagram_link");
				String githubLink = resultSet.getString("github_link");
				String ward = resultSet.getString("ward");
				String district = resultSet.getString("district");
				String province = resultSet.getString("province");
				int totalQuestions = resultSet.getInt("total_questions");
				User user = new User(userID, firstName, lastName, email, photo,
						about, facebookLink, twitterLink, instagramLink,
						githubLink, totalQuestions, ward, district, province);
				return user;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;
	}
	
	public boolean updateUserPhoto(String fileName, int userID) {
        String updatePhotoQuery = "UPDATE users SET photo = ? WHERE user_id = ?";
        
        try {
			executeUpdate(updatePhotoQuery, fileName, userID);
			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;

	}

	public String getUsernameByID(int id) {
		String query = "SELECT username FROM users WHERE user_id = ?;";

		try {
			ResultSet result = executeQuery(query, id);
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
	
	public String getUserPhotoByEmail(String email) {
		String query = "SELECT photo FROM users WHERE email = ?;";

		try {
			ResultSet result = executeQuery(query, email);
			if (result.next()) {
				String photo = result.getString("photo");
				return photo;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public ArrayList<User> getUsers(int rowsPerPage, int currentPage) {
		ArrayList<User> user = new ArrayList<>();
		String query = "SELECT * FROM users WHERE role <> 'admin' "
				+ "LIMIT  ?  OFFSET ? ;";

		try {
			PreparedStatement ps = connection.prepareStatement(query);
			ps.setInt(1, rowsPerPage);
			ps.setInt(2, (currentPage - 1) * rowsPerPage);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				int userID = rs.getInt("user_id");
				String userName = rs.getString("username");
				String email = rs.getString("email");
				String photo = rs.getString("photo");
				User users = new User(userID, userName, email, photo);
				user.add(users);
			}
		} catch (Exception e) {
			e.printStackTrace();
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
	public int getTotalUsers() {
		return getTotalRecordsUser();
	}
}
