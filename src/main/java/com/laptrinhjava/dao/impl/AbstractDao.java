package com.laptrinhjava.dao.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;

import com.demo.dao.GenericDAO;
import com.demojsp.model.Category;
import com.demojsp.model.News;
import com.laptrinhjava.mapper.RowMapper;

public class AbstractDao<T> implements GenericDAO<T> {
//	ResourceBundle mybl = ResourceBundle.getBundle("db");
	public Connection getConnection() {
		try {
			String url = "jdbc:mysql://localhost:3306/demoseverletdatabase";
			String user = "root";
			String pass = "duc08082000";
			Class.forName("com.mysql.cj.jdbc.Driver");
//			String url = mybl.getString("url");
//			String user = mybl.getString("user");
//			String pass =mybl.getString("pass");
//			Class.forName(mybl.getString("driverName"));
			return DriverManager.getConnection(url, user, pass);
		} catch (ClassNotFoundException | SQLException e) {
			return null;
		}

	}

	@Override
	public <T> List<T> query(String sql, RowMapper<T> rowMapper, Object... parameters) {
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resu = null;
		List<T> result = new ArrayList<>();
		try {
			connection = getConnection();
			statement = connection.prepareStatement(sql);
			setParameter(statement, parameters);
			resu = statement.executeQuery();
			while (resu.next()) {
				result.add(rowMapper.mapRow(resu));
			}
			return result;
		} catch (SQLException e) {
			return null;
		} finally {
			try {
				if (connection != null)
					connection.close();
				if (statement != null)
					statement.close();
				if (resu != null)
					resu.close();

			} catch (SQLException e) {
				return null;
			}

		}

	}

	private void setParameter(PreparedStatement statement, Object... parameters) {
		try {
			for (int i = 0; i < parameters.length; i++) {
				Object parameter = parameters[i];
				int index = i + 1;
				if (parameter instanceof Long) {
					statement.setLong(index, (Long) parameter);
				} else if (parameter instanceof String) {
					statement.setString(index, (String) parameter);
				} else if (parameter instanceof Integer) {
					statement.setInt(index, (Integer) parameter);
				} else if (parameter instanceof Timestamp) {
					statement.setTimestamp(index, (Timestamp) parameter);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updateAndDelete(String sql, Object... parameter) {
		Connection cn = null;
		PreparedStatement sta = null;
		try {
			cn = getConnection();
			cn.setAutoCommit(false);
			sta = cn.prepareStatement(sql);
			setParameter(sta, parameter);
			sta.executeUpdate();
			cn.commit();
		} catch (SQLException e) {
			if (cn != null)
				try {
					cn.rollback();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
		} finally {
			try {
				if (cn != null)
					cn.close();
				if (sta != null)
					sta.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	@Override
	public Long insert(String sql, Object... parameter) {
		Long id = null;
		Connection cn = null;
		PreparedStatement sta = null;
		ResultSet rs = null;
		try {
			cn = getConnection();
			cn.setAutoCommit(false);
			sta = cn.prepareStatement(sql, sta.RETURN_GENERATED_KEYS);
			setParameter(sta, parameter);
			sta.executeUpdate();
			rs = sta.getGeneratedKeys();
			if (rs.next())
				id = rs.getLong(1);
			cn.commit();
			return id;
		} catch (SQLException e) {
			if (cn != null)
				try {
					cn.rollback();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
		} finally {
			try {
				if (cn != null)
					cn.close();
				if (sta != null)
					sta.close();
				if (rs != null)
					rs.close();
			} catch (SQLException e) {
				return null;
			}
		}
		return null;
	}

	@Override
	public int count(String sql, Object... parameter) {
		
		int count = 0;
		Connection cn = null;
		PreparedStatement sta = null;
		ResultSet rs = null;
		try {
			cn = getConnection();
			cn.setAutoCommit(false);
			sta = cn.prepareStatement(sql);
			setParameter(sta, parameter);
			rs=sta.executeQuery();
			if (rs.next())
				count = rs.getInt(1);
			return count;
		} catch (SQLException e) {
			if (cn != null)
				return 0;
		} finally {
			try {
				if (cn != null)
					cn.close();
				if (sta != null)
					sta.close();
				if (rs != null)
					rs.close();
			} catch (SQLException e) {
				return 0;
			}
		}
		return 0;
	}

	}
