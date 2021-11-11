package com.laptrinhjava.service.impl;

import java.sql.Timestamp;
import java.util.List;

import javax.inject.Inject;

import com.demo.dao.ICategoryDao;
import com.demo.dao.INewDao;
import com.demojsp.model.Category;
import com.demojsp.model.News;
import com.laptrinhjava.service.INewService;

public class NewService implements INewService {
@Inject
private INewDao news;
@Inject
private ICategoryDao category;
	@Override
	public List<News> categoryById(Long categoryId) {
		
		return news.findByCategoryId(categoryId);
	}
//	@Override
//	public News save(News newss) {
//	Long newId = news.save(newss);
//	System.out.println(newId);
//	return null;
//	}
@Override
public News save(News newss) {
	Category cate = category.findOne(newss.getCategorycode());
	newss.setCreatedDate(new Timestamp(System.currentTimeMillis()));
	newss.setCreatedBy("");
	newss.setCategoryid(cate.getId());
	Long  id= news.inserNews(newss);
	return this.news.findOne(id);
}
@Override
public News update(News news) {

	 News newsole = this.news.findOne(news.getId());
		news.setCreatedBy(newsole.getCreatedBy());
		news.setCreatedDate(newsole.getCreatedDate());
		news.setModifieddate(new Timestamp(System.currentTimeMillis()));
		news.setMofdifiedBy("");
	this.news.updateNews(news);
	return this.news.findOne(news.getId()) ;
}
@Override
public void delete(long[] ids) {
	for (long id : ids) {
		news.delet(id);
	}
}
@Override
public News findOne(Long id) {
	
	News news1 = news.findOne(id); 
	Category cate = category.findOne(news1.getCategoryid());
	news1.setCategorycode(cate.getCode());
	return  news1;
}
@Override
public List<News> findAllNews(Integer offset,Integer limit,String sortName,String sortBy) {
	return news.findAll(offset,limit,sortName,sortBy);
}
@Override
public int contItem() {
	return news.count();
	
}
public static void main(String[] args) {
	NewService a = new NewService();
	News b =  a.findOne(2l);
	System.out.println(b.getContent());
}
}
