package com.demo.dao;

import java.util.List;

import com.demojsp.model.News;

public interface INewDao extends GenericDAO<News> {
List<News> findByCategoryId(Long categoryid);
//Long save(News news);
Long inserNews(News news1);
News findOne(Long id);
void updateNews(News news);
void delet(long id);
List<News> findAll(Integer offset,Integer limit, String sortName,String sortBy);
int count();
}
