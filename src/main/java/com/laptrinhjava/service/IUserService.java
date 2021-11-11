package com.laptrinhjava.service;

import com.demojsp.model.UserModel;

public interface IUserService {
UserModel findUserModel(String username,String pass,int status);
}
