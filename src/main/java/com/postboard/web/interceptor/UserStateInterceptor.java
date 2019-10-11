package com.postboard.web.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.postboard.pojo.User;

public class UserStateInterceptor extends HandlerInterceptorAdapter {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("session_user");
		if(user.getState()==0){
			//用户受限
			String queryString="msg=您的账号已受限，目前只能查看帖子&url=/index";
			request.getRequestDispatcher("/toRedirectPage?"+queryString).forward(request, response);
			return false;
		}
		return true;
	}

}
