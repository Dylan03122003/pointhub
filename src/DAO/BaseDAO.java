package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import util.DbConnection;

public class BaseDAO {

	public Connection connection;

	public BaseDAO() {
		try {
			connection = DbConnection.getConnection();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void closeConnection() {
		try {
			if (connection != null) {
				connection.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
			// Handle the exception appropriately
		}
	}

	protected ResultSet executeQuery(String query, Object... params) throws SQLException {
		PreparedStatement preparedStatement = connection.prepareStatement(query);
		for (int i = 0; i < params.length; i++) {
			preparedStatement.setObject(i + 1, params[i]);
		}
		return preparedStatement.executeQuery();
	}

	protected int executeInsert(String query, Object... params) throws SQLException {
		PreparedStatement preparedStatement = connection.prepareStatement(query,
				PreparedStatement.RETURN_GENERATED_KEYS);
		for (int i = 0; i < params.length; i++) {
			preparedStatement.setObject(i + 1, params[i]);
		}
		int rowsInserted = preparedStatement.executeUpdate();

		if (rowsInserted > 0) {

			ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
			if (generatedKeys.next()) {
				int generatedId = generatedKeys.getInt(1);
				return generatedId;
			}
		}

		return -1;
	}

	protected int executeUpdate(String query, Object... params) throws SQLException {
		PreparedStatement preparedStatement = connection.prepareStatement(query,
				PreparedStatement.RETURN_GENERATED_KEYS);
		for (int i = 0; i < params.length; i++) {
			preparedStatement.setObject(i + 1, params[i]);
		}
		return preparedStatement.executeUpdate();
	}
}
