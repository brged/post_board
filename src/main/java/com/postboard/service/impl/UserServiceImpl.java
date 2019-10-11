package com.postboard.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.postboard.mapper.UserMapper;
import com.postboard.pojo.User;
import com.postboard.pojo.UserExample;
import com.postboard.service.UserService;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	UserMapper userMapper;

	//添加用户
	@Override
	public boolean addUser(User user) {
		//注册用户默认为 1：正常
		user.setState(1);
		//让数据库自动生成创建时间
		user.setCreatetime(null);
		int rows = userMapper.insert(user);
		
		return rows>0 ? true :false;
	}
	
	//根据id查找用户
	@Override
	public User getUserById(String userId) {
		
		return userMapper.selectByPrimaryKey(userId);
	}
	
	/**
	 * 根据条件查找用户
	 * 
	 */
	@Override
	public List<User> getUserByExample(UserExample example) {
		List<User> userList = userMapper.selectByExample(example);
		return userList;
	}

	@Override
	public boolean updateUserByIdSelective(User user) {
		int rows = userMapper.updateByPrimaryKeySelective(user);
		return rows>0 ? true : false;
	}

}
