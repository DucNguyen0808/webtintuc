package com.demo.dao;

import java.util.List;

import com.demojsp.model.News;
import com.laptrinhjava.mapper.RowMapper;

public interface GenericDAO <T>  {
<T> List<T> query(String sql,RowMapper<T> rowMapper,Object...parameters);
void updateAndDelete(String sql,Object...parameter);
Long insert(String sql,Object...parameter);
int count(String sql,Object...parameter);
}
