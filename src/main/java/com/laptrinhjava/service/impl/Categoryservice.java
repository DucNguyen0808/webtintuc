package com.laptrinhjava.service.impl;

import java.util.List;

import javax.inject.Inject;

import com.demo.dao.ICategoryDao;
import com.demojsp.model.Category;
import com.laptrinhjava.service.ICatrgoryService;

public class Categoryservice implements ICatrgoryService {
//	private ICategoryDao categoryDao;
//	
//public Categoryservice() {
//	categoryDao = new CategoryDao();
//}
	@Inject
	private ICategoryDao categoryDao;
	@Override
	public List<Category> findAll() {
		return categoryDao.findALL();
	}
 public static void main(String[] args) {
	Categoryservice a = new Categoryservice();
	  List<Category> b= a.findAll();
	for (Category category : b) {
		System.out.println(category.getName());
	}
}
}
