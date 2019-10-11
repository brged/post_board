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

import com.postboard.pojo.Topic;
import com.postboard.pojo.User;
import com.postboard.service.TopicService;

@Controller
public class TopicManagerController {
	@Autowired
	TopicService topicService;

	@GetMapping("/admin/topicManager")
	public String getTopicList(Model model){
		List<Topic> topicList = topicService.getTopicListByExample(null);
		model.addAttribute("topicList", topicList);
		return "admin/topicList";
	}
	
	@RequestMapping("/admin/getTopicById")
	@ResponseBody
	public Topic getUserById(String topicId){
		Topic topic = topicService.getTopicById(topicId);
		return topic;
	}
	
	@PostMapping("/admin/editTopic")
	@ResponseBody
	public String editTopic(String topicId,String name){
		
		try {
			Topic topic = new Topic();
			topic.setId(topicId);
			topic.setName(name);
			boolean b = topicService.updateTopicByIdSelective(topic);
			if(b){
				return "success";
			}
			return "fail";
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}
	//新增
	@PostMapping("/admin/addTopic")
	@ResponseBody
	public String addTopic(String topicId,String name){
		
		try {
			Topic topic = new Topic();
			topic.setId(topicId);
			topic.setName(name);
			boolean b = topicService.addTopic(topic);
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
