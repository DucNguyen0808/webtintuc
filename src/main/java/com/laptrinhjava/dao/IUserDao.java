package com.demo.dao;

import java.util.List;

import com.demojsp.model.UserModel;

public interface IUserDao extends GenericDAO<UserModel> {
 UserModel findUserNameAndPassAndStt(String username,String pass,int status );
}
