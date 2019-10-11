package com.postboard.service;

import java.util.List;

import com.postboard.pojo.User;
import com.postboard.pojo.UserExample;

public interface UserService {
	//添加用户
	public boolean addUser(User user);
	//根据id查找用户
	public User getUserById(String userId);
	//查询用户
	public List<User> getUserByExample(UserExample example);
	//根据Id更改用户
	public boolean updateUserByIdSelective(User user);
}
