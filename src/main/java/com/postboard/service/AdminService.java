package com.postboard.service;

import java.util.List;

import com.postboard.pojo.Admin;
import com.postboard.pojo.AdminExample;

public interface AdminService {
	//通过id获取
	public Admin getAdminById(String adminId);
	//通过example获取
	public List<Admin> getAdminListByExample(AdminExample example);
}
