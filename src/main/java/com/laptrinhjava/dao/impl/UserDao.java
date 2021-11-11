package com.laptrinhjava.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import com.demo.dao.IUserDao;
import com.demojsp.model.UserModel;
import com.laptrinhjava.mapper.UserMapper;

public class UserDao extends AbstractDao<UserModel> implements IUserDao {

	@Override
	public UserModel findUserNameAndPassAndStt(String username, String pass, int status) {
	String sql="select *from user as u inner join role as r on r.id=u.roleid where u.name=? and password=? and status=?";
	List<UserModel> listUser = query(sql, new UserMapper(), username,pass,status);
		return listUser.isEmpty()? null:listUser.get(0);
	}


}

