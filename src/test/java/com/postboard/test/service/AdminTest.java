package com.postboard.test.service;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.postboard.pojo.Admin;
import com.postboard.service.AdminService;

public class AdminTest {
	@Test
	public void testgetAdminById(){
		ApplicationContext applicationContext=new ClassPathXmlApplicationContext("classpath:spring/applicationContext-*.xml");
		AdminService adminService = applicationContext.getBean(AdminService.class);
		Admin admin = adminService.getAdminById("admin");
		System.out.println(admin.getId()+":"+admin.getPassword());
	}
}
