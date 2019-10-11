package com.postboard.test.dao;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.postboard.mapper.AdminMapper;
import com.postboard.pojo.Admin;

public class AdminTest {
	@Test
	public void findAdminByIdTest(){
		ApplicationContext applicationContext=new ClassPathXmlApplicationContext("classpath:spring/applicationContext-dao.xml");
		AdminMapper adminMapper = applicationContext.getBean(AdminMapper.class);
		Admin admin = adminMapper.selectByPrimaryKey("admin");
		System.out.println(admin.getId()+":"+admin.getPassword());
	}
	
}
