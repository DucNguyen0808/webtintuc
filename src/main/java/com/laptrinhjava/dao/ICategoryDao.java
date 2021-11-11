package com.demo.dao;

import java.util.List;

import com.demojsp.model.Category;


public interface ICategoryDao extends GenericDAO<Category>{
	List<Category> findALL();
	Category findOne(Long id);
	Category findOne(String code);
	
}
