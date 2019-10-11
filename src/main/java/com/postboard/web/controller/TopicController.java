package com.postboard.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.postboard.pojo.Topic;
import com.postboard.service.TopicService;

@Controller
public class TopicController {
	@Autowired
	private TopicService topicService;
	
	
	@RequestMapping("/topic")
	@ResponseBody
	public Topic getTopicById(String id){
		Topic topic = topicService.getTopicById(id);
		return topic;
	}
}
