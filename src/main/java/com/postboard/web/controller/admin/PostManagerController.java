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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.postboard.pojo.Post;
import com.postboard.pojo.User;
import com.postboard.service.PostService;

@Controller
public class PostManagerController {
	@Autowired
	PostService postService;

	@GetMapping("/admin/postManager")
	public String getPostList(Model model){
		List<Post> postList = postService.getPostListByExample(null);
		model.addAttribute("postList", postList);
		return "admin/postList";
	}
	
	@RequestMapping("/admin/getPostById")
	@ResponseBody
	public Post getPostById(Long postId){
		Post post = postService.getPostById(postId);
		return post;
	}
	
	@PostMapping("/admin/editPost")
	@ResponseBody
	public String banPost(Long postId,@RequestParam(required=false) String limitEndTime,String note,Integer state){
		
		try {
			Date date = null;
			if(null!=limitEndTime&& !"".equals(limitEndTime)){
				date = new SimpleDateFormat("yyyy-MM-dd").parse(limitEndTime);
			}
			Post post = new Post();
			post.setId(postId);
			post.setLimitendtime(date);
			post.setState(state);
			post.setNote(note);
			boolean b = postService.updatePostByIdSelective(post);
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
