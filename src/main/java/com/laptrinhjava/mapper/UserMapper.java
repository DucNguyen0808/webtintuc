package com.laptrinhjava.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.demojsp.model.RoleModel;
import com.demojsp.model.UserModel;

public class UserMapper implements RowMapper<UserModel> {

	@Override
	public UserModel mapRow(ResultSet rs) {
		try {
			UserModel a = new UserModel();
			a.setId(rs.getLong("id"));
			a.setFullName(rs.getString("fullname"));
			a.setUserName(rs.getString("name"));
			a.setPassword(rs.getString("password"));
			a.setStatus(rs.getInt("status"));
			try {
				RoleModel b = new RoleModel();
				b.setCode(rs.getString("code"));
				b.setName(rs.getString("name"));
				a.setRole(b);	
			} catch (SQLException e) {
			}
			
			return a;
		} catch (SQLException e) {
			return null;
		
		}
	

	}


}
