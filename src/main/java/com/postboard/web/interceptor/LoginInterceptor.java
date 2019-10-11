package com.postboard.web.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.postboard.pojo.User;

/**
 * 登录拦截器
 * @author WWW
 *
 */
public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("session_user");
		if(null!=user){
			return true;
		}
		request.setAttribute("msg", "您没有权限访问，请登录后重试！");
//		request.setAttribute("url", "/login");
		request.getRequestDispatcher("/login").forward(request, response);
		return false;
	}

}
