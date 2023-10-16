package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.User;

public class UserListDAO extends BaseDAO{
	public ArrayList<User> getAllUser( ){ 
		ArrayList<User> user = new ArrayList<>();
		try {
			PreparedStatement ps = connection.prepareStatement("Select * From users WHERE role <> 'admin'");
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				int userID = rs.getInt("user_id");
				String  userName= rs.getString("username");
				String  email= rs.getString("email");
				String  photo = rs.getString("photo");			  
				user.add(new User(userID, userName,email,photo));
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return user;
		
	}
  public boolean isAdmin(int user_id){
		String selectAdmin = "Select * From users Where user_id = ?;";
		try {
			ResultSet rs = executeQuery(selectAdmin, user_id);
			if(rs.next()) {
				String userRole = rs.getString("role");
				if(userRole.equals("admin")) {
				return true;
				}
			}
		} catch (SQLException e) {
         e.printStackTrace();
		}
		return false;
	}
}
