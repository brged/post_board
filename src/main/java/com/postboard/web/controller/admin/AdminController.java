package com.postboard.web.controller.admin;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.postboard.pojo.Admin;
import com.postboard.pojo.AdminExample;
import com.postboard.pojo.AdminExample.Criteria;
import com.postboard.service.AdminService;

@Controller
public class AdminController {
	@Autowired
	AdminService adminService;
	
	/**
	 * 用户登录
	 * @param account
	 * @param password
	 * @param model
	 * @return
	 */
	//跳转到登录页面
	@GetMapping({"/admin","/admin/login"})
	public String toLogin(){
		return "/admin/login";
	}
	//用户登录
	@PostMapping("/admin/login")
	public String handleLogin(String account,String password,Model model,HttpSession session){
		 AdminExample example = new AdminExample();
		
		Criteria criteria = example.createCriteria();
		criteria.andIdEqualTo(account);
		criteria.andPasswordEqualTo(password);
		List<Admin> adminList = adminService.getAdminListByExample(example);
		if(adminList.isEmpty()){
			model.addAttribute("msg", "用户名或密码错误！");
			return "admin/login";
		}
		session.setAttribute("session_admin", adminList.get(0));
		return "redirect:/admin/index";
	}
	
	@RequestMapping("/admin/logout")
	public String handleLogout(HttpSession session, Model model){
		session.invalidate();
		model.addAttribute("msg", "退出成功！5秒后将跳转至登录页");
		model.addAttribute("url", "/admin/login");
		return "redirectPage";
	}
	
	@GetMapping("/admin/index")
	public String toIndex(){
		return "/admin/index";
	}
}
