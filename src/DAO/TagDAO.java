package DAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class TagDAO extends BaseDAO {
	public ArrayList<String> getAllTags() {
		ArrayList<String> tags = new ArrayList<String>();
		String query = "SELECT * FROM tags";
		try {
			ResultSet result = executeQuery(query);
			while (result.next()) {
				tags.add(result.getString("tag_content"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return tags;
	}
}
