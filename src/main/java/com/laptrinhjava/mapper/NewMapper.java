package com.laptrinhjava.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.demojsp.model.News;

public class NewMapper implements RowMapper<News> {

	@Override
	public News mapRow(ResultSet rs) {
		try {
			News  news= new News();
			news.setId(rs.getLong("id"));
			news.setTitle(rs.getString("title"));
			news.setThumbnail(rs.getString("thumbnail"));
			news.setCategoryid(rs.getLong("categoryid"));
			news.setCreatedBy(rs.getString("createdby"));
			news.setContent(rs.getString("content"));
			news.setShortdescription(rs.getString("shortdescription"));
			news.setCreatedDate(rs.getTimestamp("createddate"));
			if (rs.getTimestamp("modifieddate") != null) {
				news.setModifieddate(rs.getTimestamp("modifieddate"));
			}
			if (rs.getString("mofdifiedby") != null) {
				news.setMofdifiedBy(rs.getString("mofdifiedby"));
			}
			return news;
		}catch(SQLException e)
		{
			return null;
		}
		
		
	}

}
