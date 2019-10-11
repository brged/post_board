package com.postboard.web.controller.admin;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.postboard.pojo.User;
import com.postboard.service.UserService;

@Controller
public class UserManagerController {
	@Autowired
	UserService userService;

	@GetMapping("/admin/userManager")
	public String getUserList(Model model){
		List<User> userList = userService.getUserByExample(null);
		model.addAttribute("userList", userList);
		return "admin/userList";
	}
	
	@RequestMapping("/admin/getUserById")
	@ResponseBody
	public User getUserById(String userId){
		User user = userService.getUserById(userId);
		return user;
	}
	
	@PostMapping("/admin/banUser")
	@ResponseBody
	public String banUser(String userId,String limitEndTime,String note){
		
		try {
			Date date = new SimpleDateFormat("yyyy-MM-dd").parse(limitEndTime);
			User user = new User();
			user.setId(userId);
			user.setLimitendtime(date);
			user.setNote(note);
			user.setState(0);
			boolean b = userService.updateUserByIdSelective(user);
			if(b){
				return "success";
			}
			return "fail";
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}
}
