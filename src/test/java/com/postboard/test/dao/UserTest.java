package com.postboard.test.dao;

import java.util.List;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.postboard.mapper.UserMapper;
import com.postboard.pojo.User;
import com.postboard.pojo.UserExample;
import com.postboard.pojo.UserExample.Criteria;

public class UserTest {

	@Test
	public void testfindUser(){
		ApplicationContext applicationContext=new ClassPathXmlApplicationContext("classpath:spring/applicationContext-dao.xml");
		UserMapper userMapper = applicationContext.getBean(UserMapper.class);
		UserExample userExample=new UserExample();
		Criteria criteria = userExample.createCriteria();
		criteria.andIdEqualTo("1");
		criteria.andPasswordEqualTo("1");
		
		List<User> userList = userMapper.selectByExample(userExample);
		System.out.println(userList.size());
	}
}
