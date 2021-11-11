package com.laptrinhjava.dao.impl;

import java.util.List;

import com.demo.dao.INewDao;
import com.demojsp.model.Category;
import com.demojsp.model.News;
import com.laptrinhjava.mapper.NewMapper;

public class NewDao extends AbstractDao<News> implements INewDao {
	@Override
	public List<News> findByCategoryId(Long categoryid) {
		String sql = "Select * from news where categoryid=?  ";
		return query(sql, new NewMapper(), categoryid);
	}

	@Override
	public Long inserNews(News news1) {
		String sql = "insert into news(title,categoryid,thumbnail,shortdescription,content,createddate,createdby) values(?,?,?,?,?,?,?)";
		return insert(sql, news1.getTitle(), news1.getCategoryid(), news1.getThumbnail(), news1.getShortdescription(),
				news1.getContent(), news1.getCreatedDate(), news1.getCreatedBy());
	}

	@Override
	public News findOne(Long id) {
		String sql = "Select * from news where id=?  ";
		List<News> news = query(sql, new NewMapper(), id);
		return news.isEmpty() ? null : news.get(0);
	}

	@Override
	public void updateNews(News news) {
		String sql = "update news set thumbnail=?, title=?, content=?, shortdescription=?  where id=?";
		updateAndDelete(sql, news.getThumbnail(),news.getTitle(),news.getContent()
				,news.getShortdescription(), news.getId());

	}

	@Override
	public void delet(long id) {
		String sql = "delete from news where id=?";
		updateAndDelete(sql, id);

	}

	@Override
	public List<News> findAll(Integer offset, Integer limit, String sortName,String sortBy) {
		StringBuilder sql = new StringBuilder("Select * from news ");
		if(sortName != null && sortBy!= null) {
			sql.append("order by " +sortName+" "+sortBy);
		};
			
		if (offset != null && limit!= null) {
			sql.append(" limit "+offset+","+limit);	
		};
			return query(sql.toString(), new NewMapper());
	}

	@Override
	public int count() {
		String sql = "select count(*) from news";
		return count(sql);
	}

}

//	public static void main(String[] args) {
//		NewDao a = new NewDao();
//		News c = new News();
//		List<News> b = a.findByCategoryId(1L);
//		for (News news : b) {
//			System.out.println(news.getTitle());
//		}
//	}

//	@Override
//	public Long save(News news) {
//		Long id = null;
//		PreparedStatement sta = null;
//		ResultSet rs = null;
//		String sql = "insert into news(title,categoryid,thumbnail ) values(?,?,?)";
//		Connection cn = null;
//		try {
//			cn = getConnection();
//			cn.setAutoCommit(false);
//			sta = cn.prepareStatement(sql, sta.RETURN_GENERATED_KEYS);
//			sta.setString(1, news.getTitle());
//			sta.setLong(2, news.getCategoryid());
//			sta.setString(3, news.getThumbnail());
//			sta.executeUpdate();
//			rs = sta.getGeneratedKeys();
//			if (rs.next()) {
//				id = rs.getLong(1);
//			}
//			cn.commit();
//			return id;
//		} catch (SQLException e) {
//			if (cn != null)
//				try {
//					cn.rollback();
//				} catch (SQLException e1) {
//					e1.printStackTrace();
//				}
//
//		} finally {
//			try {
//				if (cn != null)
//					cn.close();
//				if (sta != null)
//					sta.close();
//				if (rs != null)
//					rs.close();
//
//			} catch (SQLException e) {
//				return null;
//			}
//
//		}
//		return null;
//	}
