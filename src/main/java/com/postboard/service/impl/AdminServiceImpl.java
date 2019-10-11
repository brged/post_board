package com.postboard.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.postboard.mapper.AdminMapper;
import com.postboard.pojo.Admin;
import com.postboard.pojo.AdminExample;
import com.postboard.service.AdminService;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminMapper adminMapper;
	
	@Override
	public Admin getAdminById(String adminId) {
		
		return adminMapper.selectByPrimaryKey(adminId);
	}

	@Override
	public List<Admin> getAdminListByExample(AdminExample example) {
		List<Admin> adminList = adminMapper.selectByExample(example);
		return adminList;
	}
	

}
