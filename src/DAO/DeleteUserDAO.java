package DAO;

import java.sql.PreparedStatement;

public class DeleteUserDAO extends BaseDAO {
	public void deleteUserByID(int UserID) {
		 try {
			 PreparedStatement ps = connection.prepareStatement("DELETE FROM users WHERE user_id = ?");
	         ps.setInt(1, UserID);
	         ps.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
		}
		 
	 }
}
