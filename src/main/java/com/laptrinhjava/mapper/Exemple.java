//package com.laptrinhjava.mapper;
//
//import java.beans.Statement;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.util.ArrayList;
//import java.util.List;
//
//import com.demo.dao.INewDao;
//import com.demojsp.model.News;
//import com.laptrinhjava.dao.impl.AbstractDao;
//
//public class Exemple extends AbstractDao<News> implements INewDao {
//
//	@Override
//	public List<News> findByCategoryId(String thumbnail) {
//		List<News> results = new ArrayList<>();
//		String sql = "Select * from news where thumbnail=? ";
//		PreparedStatement statement = null;
//		ResultSet resu = null;
//		// open connection
//		Connection connection = getConnection();
//		if (connection != null) {
//			try {
//				statement = connection.prepareStatement(sql);
//			statement.setString(1,thumbnail );
//				resu = statement.executeQuery();
//				while (resu.next()) {
//					News  news= new News();
//					news.setId(resu.getLong("id"));
//					news.setTitle(resu.getNString("title"));
//					results.add(news);
//				}
//
//				return results;
//			} catch (SQLException e) {
//				e.printStackTrace();
//			} finally {
//				try {
//					if (connection != null)
//						connection.close();
//					if (statement != null)
//						statement.close();
//					if (resu != null)
//						resu.close();
//
//				} catch (SQLException e) {
//					return null;
//				}
//
//			}
//
//		}
//		return null;
//	}
// public static void main(String[] args) {
//	 Exemple a = new Exemple();
//	 List<News>b = a.findByCategoryId("123");
//	 for (News news : b) {
//		System.out.println(news.getTitle());
//	}
//}
//}
