package com.postboard.web.controller;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.postboard.pojo.Post;
import com.postboard.pojo.PostExample;
import com.postboard.pojo.PostExample.Criteria;
import com.postboard.pojo.Topic;
import com.postboard.pojo.User;
import com.postboard.service.PostService;
import com.postboard.service.TopicService;

@Controller
public class PostController {
	//每页显示的条数
	private int pageSize=3;

	@Autowired
	private PostService postService;
	@Autowired
	private TopicService topicService;
	
	//通过话题获取帖子列表
	@GetMapping({"/index","/post"})
	public String findPostListById(Model model,@RequestParam(required=false) String topicId,@RequestParam(defaultValue="1") Integer page){
		//获取话题列表
		List<Topic> topicList = topicService.getTopicListByExample(null);
		model.addAttribute("topicList",topicList);
		
		PostExample example=new PostExample();
		Criteria criteria = example.createCriteria();
		if(topicId!=null && !"".equals(topicId.trim()))
			criteria.andTopicIdEqualTo(topicId);
		example.setOrderByClause("updatetime desc");
		criteria.andStateNotEqualTo(0);
		//分页
		PageHelper.startPage(page, pageSize);
		List<Post> postList = postService.getPostListByExample(example);
		PageInfo<Post> pageInfo = new PageInfo<Post>(postList);
		System.out.println(pageInfo);
		List<Post> list = pageInfo.getList();
		if(postList.isEmpty()){
			model.addAttribute("msg", "目前还没有帖子");
			return "index";
		}
		model.addAttribute("pageInfo",pageInfo);
		return "index";
	}
	
	//通过标题条件搜索帖子列表
	@GetMapping("/post/searchPost")
	public String searchPostList(@RequestParam(defaultValue="") String title,@RequestParam(defaultValue="") String topicId,
			Model model,@RequestParam(defaultValue="1") Integer page,HttpServletRequest request){
		/*PostExample example=new PostExample();
		Criteria criteria = example.createCriteria();
		if(post!=null){
			if(post.getId()!=null)
				criteria.andIdEqualTo(post.getId());
			if(post.getTitle()!=null && post.getTitle().trim()!="")
				criteria.andTitleLike("%"+post.getTitle()+"%");
			if(post.getTopicId()!=null && post.getTopicId().trim()!="")
				criteria.andTopicIdEqualTo(post.getTopicId());
			if(post.getUserId()!=null && post.getUserId().trim()!="")
				criteria.andUserIdLike("%"+post.getTopicId()+"%");
			example.setOrderByClause("updatetime desc");
			criteria.andStateEqualTo(1);
			List<Post> postList = postService.getPostListByExample(example);
		}*/
		//获取话题列表
		List<Topic> topicList = topicService.getTopicListByExample(null);
		model.addAttribute("topicList",topicList);

		//解决中文乱码
		String newTitle = "";
		try {
			newTitle = new String(title.getBytes("ISO-8859-1"),"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		PostExample example=new PostExample();
		Criteria criteria = example.createCriteria();
		if(newTitle.trim()!="")
			criteria.andTitleLike("%"+newTitle+"%");
		if(topicId!=null && !"".equals(topicId.trim()))
			criteria.andTopicIdEqualTo(topicId);
		example.setOrderByClause("updatetime desc");
		//帖子没被封禁
		criteria.andStateNotEqualTo(0);
		PageHelper.startPage(page, pageSize);
		List<Post> postList = postService.getPostListByExample(example);
		PageInfo<Post> pageInfo = new PageInfo<Post>(postList);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("requestUri",request.getRequestURL()+"?"+"title="+newTitle+"&topicId="+topicId);
		model.addAttribute("title2", newTitle);
		model.addAttribute("topicId2", topicId);
		return "postList";
	}
	
	//通过id获取帖子内容
	@GetMapping({"/post/{id}"})
	public String getPostById(@PathVariable(required=false) Long id,Model model){
		Post post = postService.getPostById(id);
		if (null == post || 0==post.getState()) {
			model.addAttribute("msg", "没有查找到帖子或该帖已被封禁，请重试！5秒后即将跳转至首页");
			model.addAttribute("url", "/index");
			return "redirectPage";
		}
		model.addAttribute("post",post);
		return "postContent";
	}
	
	//通过用户名获取帖子
	@GetMapping("/user/space/{userId}")
	public String getPostListByUserId(@PathVariable String userId,Model model,HttpSession session,@RequestParam(defaultValue="1",required=false) Integer page){
		User user = (User) session.getAttribute("session_user");
		//获取话题列表
		List<Topic> topicList = topicService.getTopicListByExample(null);
		model.addAttribute("topicList",topicList);
		PostExample example=new PostExample();
		Criteria criteria = example.createCriteria();
		criteria.andUserIdEqualTo(userId);
		if(user==null || !userId.equals(user.getId())){
			//帖子没被封禁
			criteria.andStateNotEqualTo(0);
		}
		example.setOrderByClause("updatetime desc");
		PageHelper.startPage(page, pageSize);
		List<Post> postList = postService.getPostListByExample(example);
		PageInfo<Post> pageInfo = new PageInfo<Post>(postList);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("requestUri","/user/space/"+userId+"?");
		return "userHome";
	}
	
	//删除帖子
	@PostMapping("/post/deletePost")
	@ResponseBody
	public String deletePost(Long postId,HttpSession session,Model model){
		User user = (User) session.getAttribute("session_user");
		Post post = postService.getPostById(postId);
		if(null==post || !user.getId().equals(post.getUserId())){
			model.addAttribute("msg","您没有权限访问！5秒后即将跳转至首页");
			model.addAttribute("url", "/index");
			return "redirectPage";
		}
		boolean b = postService.deletePost(postId);
		if(b) return "1";
		return "0";
	}
	
	/**
	 * 编辑帖子
	 * 
	 * @param id
	 * @return
	 */
	@GetMapping({"/post/toEditPost","/post/toEditPost/{id}"})
	public String toEditPost(@PathVariable(required=false) Long id, Model model,HttpSession session) {
		User user = (User) session.getAttribute("session_user");
		//未登录
		if(null==user){
			model.addAttribute("msg", "请登录后重试！");
			return "login";
		}
		List<Topic> topicList = topicService.getTopicListByExample(null);
		model.addAttribute("topicList", topicList);
		//新增帖子
		if (null == id) {
			model.addAttribute("pageTitle", "新增");
			return "editPost";
		}
		//修改帖子
		Post post = postService.getPostById(id);
		if (null == post) {
			model.addAttribute("msg", "没有查找到帖子，请重试！5秒后即将跳转至首页");
			model.addAttribute("url", "/index");
			return "redirectPage";
		}
		if(!post.getUserId().equals(user.getId())){
			model.addAttribute("msg","您没有权限访问！5秒后即将跳转至首页");
			model.addAttribute("url", "/index");
			return "redirectPage";
		}
		//有权限访问
		model.addAttribute("pageTitle", "修改");
		model.addAttribute("post",post);
		return "editPost";
		
	}

	/**
	 * 添加(没传id)或修改帖子(有id)
	 * @param post
	 * @param session
	 * @param model
	 * @return
	 */
	@PostMapping("/post/editPost")
	@ResponseBody
	public Map editPost(Post post,HttpSession session){
		Map<String ,Object> map=new HashMap<String, Object>();
		User user = (User) session.getAttribute("session_user");
		//未登录
		if(null==user){
			map.put("state", "noLogin");
			return map;
		}
		//校验表单字段
		if(!checkPost(post)){
			map.put("state", "illegal");
			return map;
		}
		//添加帖子:无id
		if(null==post.getId()){
			post.setUserId(user.getId());
			boolean b1 = postService.addPost(post);
			if(b1){
				map.put("state", "add");
				return map;
			}
		}
		/*
		 * 修改帖子:有id
		 */
		//校验数据库中的用户id
		if(!user.getId().equals(postService.getPostById(post.getId()).getUserId())){
			//非法访问,用户名不相同
			map.put("state", "fail");
			return map;
		}
		post.setUserId(null);
		boolean b2=postService.updatePostSelective(post);
		if(b2){
			map.put("state", "update");
			return map;
		}
		map.put("state", "fail");
		return map;
	}
	
	//校验表单字段:null,title,content
	private boolean checkPost(Post post){
		//没有参数
		if(null==post ) return false;
		//标题为空
		if(null==post.getTitle() || "".equals(post.getTitle().trim())) return false;
		//内容为空
		if(null==post.getContent() || "".equals(post.getContent().trim())) return false;
		//没有类别
		if(null == topicService.getTopicById(post.getTopicId())) return false;
		return true;
	}
	
}
