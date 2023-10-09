package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConnection {
	private static final String DB_URL = "jdbc:mysql://localhost:3306/pointhub";
	private static final String USERNAME = "root";
	private static final String PASSWORD = "";
	private static int count = 0;

	public static Connection getConnection() throws SQLException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			System.out.println("connect to db successfully! " + count);
			count++;
			return DriverManager.getConnection(DB_URL, USERNAME, PASSWORD);
		} catch (ClassNotFoundException e) {
			throw new SQLException("Failed to load MySQL JDBC driver.", e);
		}
	}

	public static void main(String[] args) throws SQLException {
		DbConnection.getConnection();
	}

}
