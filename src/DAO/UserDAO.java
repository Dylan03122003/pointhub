package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import util.Authentication;
import util.CustomLog;

public class UserDAO extends BaseDAO {

	public User getUserProfile(int currentUserID, int viewedUserID) {
		String query = "SELECT " + "    u.email, " + "    u.username, "
				+ "    u.photo, " + "    u.about, " + "    sa.facebook_link, "
				+ "    sa.twitter_link, " + "    sa.instagram_link, "
				+ "    sa.github_link, "
				+ "    COUNT(q.question_id) AS total_questions, " + "    CASE "
				+ "        WHEN fr.followed_user_id IS NOT NULL THEN 1 "
				+ "        ELSE 0 " + "    END AS is_following, "
				+ "    (SELECT COUNT(*) FROM following_relationships WHERE followed_user_id = ?) AS followers "
				+ "FROM " + "    users u " + "LEFT JOIN "
				+ "    social_accounts sa ON u.user_id = sa.user_id "
				+ "LEFT JOIN " + "    questions q ON u.user_id = q.user_id "
				+ "LEFT JOIN "
				+ "    following_relationships fr ON u.user_id = fr.followed_user_id AND fr.user_id = ? "
				+ "WHERE " + "    u.user_id = ?";

		try {
			ResultSet result = executeQuery(query, viewedUserID, currentUserID,
					viewedUserID);
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
				boolean isFollowedByCurrentUser = result
						.getBoolean("is_following");
				int numberOfFollowers = result.getInt("followers");

				User user = new User(viewedUserID, username, email, photo,
						about, facebookLink, twitterLink, instagramLink,
						githubLink, totalQuestions);
				user.setFollowedByCurrentUser(isFollowedByCurrentUser);
				user.setNumberOfFollowers(numberOfFollowers);

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

	public boolean followUser(int currentUserID, int followedUserID)
			throws SQLException {
		String insertCommand = "INSERT INTO following_relationships (user_id, followed_user_id) VALUES (?, ?);";
		String deleteCommand = "DELETE FROM following_relationships WHERE user_id = ? AND followed_user_id = ?";

		try {
			executeUpdate(insertCommand, currentUserID, followedUserID);
			return true;
		} catch (SQLException e) {
			System.out.println("deleted duplicated follow");
			executeUpdate(deleteCommand, currentUserID, followedUserID);
			return false;

		}

	}

	public void updateUserProfile(HttpServletResponse response,
			HttpServletRequest request, User user) {
		String updateUserCommand = "UPDATE users "
				+ "SET email = ?, first_name = ?, last_name = ?, about = ?, username = ? "
				+ "WHERE user_id = ?";
		String insertSocialCommand = "INSERT INTO social_accounts (user_id, facebook_link, twitter_link, instagram_link, github_link) "
				+ "VALUES (?, ?, ?, ?, ?) " + "ON DUPLICATE KEY UPDATE "
				+ "facebook_link = VALUES(facebook_link), "
				+ "twitter_link = VALUES(twitter_link), "
				+ "instagram_link = VALUES(instagram_link), "
				+ "github_link = VALUES(github_link)";

		String queryLocationIDCommand = "SELECT location_id FROM users WHERE user_id = ?";
		String insertLocationCommand = "INSERT INTO locations (ward, district, province) VALUES (?, ?, ?)";
		String updateLocationIDCommand = "UPDATE users SET location_id = ? WHERE user_id = ?";
		String updateLocationCommand = "UPDATE locations SET ward = ?, district = ?, province = ?  WHERE location_id = ?";

		try {
			executeUpdate(updateUserCommand, user.getEmail(),
					user.getFirstName(), user.getLastName(), user.getAbout(),
					user.getLastName() + user.getFirstName(), user.getUserID());

			Authentication.updateUserEmailCookie(response, request,
					user.getEmail());

			executeUpdate(insertSocialCommand, user.getUserID(),
					user.getFacebookLink(), user.getTwitterLink(),
					user.getInstagramLink(), user.getGithubLink());

			ResultSet result = executeQuery(queryLocationIDCommand,
					user.getUserID());
			int locationID = -1;
			if (result.next()) {
				locationID = result.getInt("location_id");

			}

			boolean locationIDExisted = locationID != 0;

			if (locationIDExisted) {
				executeUpdate(updateLocationCommand, user.getWard(),
						user.getDistrict(), user.getProvince(), locationID);

			} else {
				locationID = executeInsert(insertLocationCommand,
						user.getWard(), user.getDistrict(), user.getProvince());

				executeUpdate(updateLocationIDCommand, locationID,
						user.getUserID());

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public ArrayList<User> getTopFivePopularUsers() {
		ArrayList<User> topFivePopularUsers = new ArrayList<User>();
		String query = "SELECT f.followed_user_id, COUNT(*) AS follower_count, u.username, u.photo "
				+ "FROM following_relationships f "
				+ "JOIN users u ON f.followed_user_id = u.user_id "
				+ "GROUP BY f.followed_user_id, u.username, u.photo "
				+ "ORDER BY follower_count DESC " + "LIMIT 5;";

		try {
			ResultSet resultSet = executeQuery(query);
			while (resultSet.next()) {
				int followedUserId = resultSet.getInt("followed_user_id");
				int followerCount = resultSet.getInt("follower_count");
				String username = resultSet.getString("username");
				String photo = resultSet.getString("photo");
				User user = new User(followedUserId, username, photo,
						followerCount);
				topFivePopularUsers.add(user);

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return topFivePopularUsers;
	}
	public ArrayList<User> getFollowers(int followedUserID, int limit, int currentFollowersSize) {
		ArrayList<User> followers = new ArrayList<User>();
		String query = "SELECT f.user_id, u.username, u.email, u.photo "
				+ "FROM following_relationships AS f "
				+ "JOIN users AS u ON f.user_id = u.user_id "
				+ "WHERE f.followed_user_id = ? LIMIT ? OFFSET ?";

		try {
			ResultSet result = executeQuery(query, followedUserID, limit, currentFollowersSize);
			while (result.next()) {
				int userID = result.getInt("user_id");
				String username = result.getString("username");
				String email = result.getString("email");
				String photo = result.getString("photo");

				User user = new User(userID, username, email, photo);

				followers.add(user);

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return followers;
	}



}
