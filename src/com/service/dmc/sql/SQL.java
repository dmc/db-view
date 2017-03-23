
package com.service.dmc.sql;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

/**
 * Facade Class of JDBC Interface Class
 * @author dmc
 *
 */
public class SQL {

	Connection connection = null;
	ResultSet result = null;
	PreparedStatement preparedStatement = null;
	
	public SQL(Connection connection) {
		this.connection = connection;
	}
	
	/**
	 * Create PreparedStatement class and store inside
	 * @param sql
	 * @throws SQLException
	 */
	public void prepareStatement(String sql) throws SQLException {
		this.preparedStatement = connection.prepareStatement(sql);
	}
	
	/**
	 * Get ResultSetMetaData from stored preparedStatement in this class
	 * @return
	 * @throws SQLException
	 */
	public ResultSetMetaData getMetaData() throws SQLException {
		return preparedStatement.getMetaData();
	}
	
	/**
	 * call executeQuery method of stored preparedStatement in this class  
	 * @throws SQLException
	 */
	public void executeQuery() throws SQLException {
		this.result = preparedStatement.executeQuery();
	}

	/**
	 * call executeUpdate method of stored preparedStatement in this class
	 * and store ResultSet in this class
	 * @return
	 * @throws SQLException
	 */
	public int executeUpdate() throws SQLException {
		return preparedStatement.executeUpdate();
	}

	/**
	 * Call getObjectMethod of stored resultSet in this class
	 * @param columnIndex 
	 * @return
	 * @throws SQLException
	 */
	public Object getObject(int columnIndex) throws SQLException {
		return result.getObject(columnIndex);
	}
	public boolean next() throws SQLException{
		return result.next();
	}
	
	public void close() {
		try {
			if(result != null) result.close();
		} catch (Exception ignore) {}
		try {
			if(preparedStatement != null) preparedStatement.close();
		} catch (Exception ignore) {}
		try {
			if(connection != null) connection.close();
		} catch (Exception ignore) {}
	}
	
	
	
}
