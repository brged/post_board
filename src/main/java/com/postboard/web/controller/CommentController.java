package com.postboard.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.postboard.pojo.Comment;
import com.postboard.pojo.User;
import com.postboard.service.CommentService;

@Controller
public class CommentController {
	
	@Autowired
	private CommentService commentService;

	//获取评论 json
	@RequestMapping("/comment/getCommentList")
	@ResponseBody
	public List<Comment> getCommentList(Long postid){
		
		return commentService.getCommentList(postid);
	}
	
	//获取评论 iframe
	@RequestMapping("/comment/getCommentList2")
	public String getCommentList2(Long postid,Model model){
		List<Comment> commentList = commentService.getCommentList(postid);
		model.addAttribute("commentList", commentList);
		return "postComment2";
	}
	
	//添加评论
	@PostMapping("/comment/addComment")
	@ResponseBody
	public Map addComment(Long postid,String content,HttpSession session){
		Map<String,String> map=new HashMap<>();
		User user = (User) session.getAttribute("session_user");
		//未登录
		if(null==user){
			map.put("msg", "login");
			return map;
		}
		if(null==postid || null==content || "".equals(content)){
			map.put("msg", "fail");
			return map;
		}
		Comment comment = new Comment();
		comment.setPostid(postid);
		comment.setContent(content);
		comment.setUserid(user.getId());
		boolean b = commentService.addCommentSelective(comment);
		if(b){
			map.put("msg", "success");
			return map;
		}
		map.put("msg", "fail");
		return map;
	}
}
