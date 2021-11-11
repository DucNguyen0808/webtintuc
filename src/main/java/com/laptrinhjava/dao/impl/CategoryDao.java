package com.laptrinhjava.dao.impl;

import java.util.ArrayList;
import java.util.List;

import com.demo.dao.ICategoryDao;
import com.demojsp.model.Category;
import com.demojsp.model.News;
import com.laptrinhjava.mapper.CategoryMapper;
import com.laptrinhjava.mapper.NewMapper;

public class CategoryDao extends AbstractDao<Category>implements ICategoryDao{

	
	@Override
	public List<Category> findALL() {

		String sql = "select * from category";
		return query(sql, new CategoryMapper());
	}

	@Override
	public Category findOne(Long id) {
		String sql = "Select * from category where id=?  ";
		List<Category> category = query(sql, new CategoryMapper() , id);
		return category.isEmpty() ? null : category.get(0);
	}

	@Override
	public Category findOne(String code) {
		String sql = "Select * from category where code=?  ";
		List<Category> category = query(sql, new CategoryMapper() , code);
		return category.isEmpty() ? null : category.get(0);
	}

	}


