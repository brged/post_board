package com.postboard.web.interceptor.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.postboard.pojo.Admin;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String uri = request.getRequestURI();
		System.out.println(uri);
		if(uri.indexOf("/admin/login")>=0){
			return true;
		}
		HttpSession session = request.getSession();
		Admin admin = (Admin) session.getAttribute("session_admin");
		if(null!=admin){
			return true;
		}
		request.setAttribute("msg", "您没有权限访问，请登录后重试！");
		request.getRequestDispatcher("/admin/login").forward(request, response);
		return false;
	}
}
