package com.postboard.web.controller;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.postboard.pojo.User;
import com.postboard.pojo.UserExample;
import com.postboard.pojo.UserExample.Criteria;
import com.postboard.service.UserService;
import com.postboard.utils.VerifyCode;

@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	
	//获取用户名
	@RequestMapping("/user/getUserName")
	@ResponseBody
	public String getUserName(@RequestParam(required=false) String userId){
		User user = userService.getUserById(userId);
		if(null==user){
			return null;
		}
		return user.getId();
	}

	/**
	 * 用户注册
	 * @return
	 */
	//跳转到注册页面
	@GetMapping("/register")
	public String toRegister(){
		return "register";
	}
	//用户注册
	@PostMapping("/register")
	public String handleRegister(User user,String password2,@RequestParam("verifyCode") String vCode,Model model,HttpSession session){
		if(null==vCode || null==session.getAttribute("session_verifyCode")
				|| !session.getAttribute("session_verifyCode").equals(vCode.toLowerCase())){
			model.addAttribute("msg","验证码错误！");
			return "register";
		}
		if(null==user || "".equals(user.getId().trim())){
			model.addAttribute("msg","用户名不能为空！");
			return "register";
		}
		if(! password2.equals(user.getPassword())){
			model.addAttribute("msg","确认密码输入不一致！");
			return "register";
		}
		User user2 = userService.getUserById(user.getId());
		if(null!=user2){
			model.addAttribute("msg","该用户已经注册过了，请登录！");
			return "register";
		}
		boolean b = userService.addUser(user);
		if(b){
			model.addAttribute("msg", "恭喜你注册成功！5秒后将跳转至登录页面");
			model.addAttribute("url", "/login");
			return "redirectPage";
		}
		model.addAttribute("msg","注册失败,请重试！");
		return "register";
	}

	/**
	 * 用户登录
	 * @param account
	 * @param password
	 * @param model
	 * @return
	 */
	//跳转到登录页面
	@GetMapping("/login")
	public String toLogin(){
		return "login";
	}
	//用户登录
	@PostMapping("/login")
	public String handleLogin(@RequestParam("verifyCode") String vCode,String account,String password,Model model
			,HttpSession session){
		if(null==vCode || null==session.getAttribute("session_verifyCode") || !session.getAttribute("session_verifyCode").equals(vCode.toLowerCase())){
			model.addAttribute("msg","验证码错误！");
			return "login";
		}
		UserExample example=new UserExample();
		
		Criteria criteria1 = example.createCriteria();
		criteria1.andIdEqualTo(account);
		criteria1.andIdEqualTo(account);
		criteria1.andPasswordEqualTo(password);
		List<User> userList = userService.getUserByExample(example);
		if(userList.isEmpty()){
			model.addAttribute("msg", "用户名或密码错误！");
			return "login";
		}
		User loginUser=userList.get(0);
		if(null!=loginUser.getLimitendtime() && loginUser.getLimitendtime().getTime()<=System.currentTimeMillis()){
			loginUser.setState(1);
			loginUser.setNote("");
			userService.updateUserByIdSelective(loginUser);
		}
		session.setAttribute("session_user", loginUser);
		return "redirect:/index";
	}
	
	@RequestMapping("/logout")
	public String handleLogout(HttpSession session, Model model){
		session.invalidate();
		model.addAttribute("msg", "退出成功！5秒后将跳转至首页");
		model.addAttribute("url", "/index");
		return "redirectPage";
	}
	
	/**
	 * 生成图片验证码(100x40)
	 * @param response
	 * @param session
	 * @throws IOException
	 */
	@GetMapping("/verifyCode")
	public void verifyCode(HttpServletResponse response,HttpSession session) throws IOException{
		VerifyCode verifyCode=new VerifyCode();
		BufferedImage image = verifyCode.getImage();
		System.out.println("VerifyCode:"+verifyCode.getText());
		session.setAttribute("session_verifyCode", (verifyCode.getText()).toLowerCase());
		VerifyCode.output(image, response.getOutputStream());
	}
}
 