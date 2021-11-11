package com.laptrinhjava.service;

import java.util.List;

import com.demojsp.model.News;

public interface INewService {
List<News> categoryById(Long categoryId);
News save(News newss);
News update(News news);
void delete(long[] id);
News findOne(Long id);
List<News> findAllNews(Integer offset,Integer limit,String sortName,String sortBy);
int contItem();
}
