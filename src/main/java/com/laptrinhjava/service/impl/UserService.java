package com.laptrinhjava.service.impl;

import javax.inject.Inject;

import com.demo.dao.IUserDao;
import com.demojsp.model.UserModel;
import com.laptrinhjava.dao.impl.UserDao;
import com.laptrinhjava.service.IUserService;

public  class UserService implements IUserService{
@Inject private UserDao user;

@Override
public UserModel findUserModel(String username, String pass, int status) {
	
	return user.findUserNameAndPassAndStt(username, pass, status);
}
	
}
