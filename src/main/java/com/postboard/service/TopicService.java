package com.postboard.service;

import java.util.List;

import com.postboard.pojo.Topic;
import com.postboard.pojo.TopicExample;

public interface TopicService {

	//通过id获取话题
	Topic getTopicById(String topicId);
	
	//通过条件获取话题
	List<Topic> getTopicListByExample(TopicExample example);
	
	//添加话题
	boolean addTopic(Topic topic);
	
	//更新话题
	boolean updateTopicByIdSelective(Topic topic);
	//更新话题
	boolean updateTopicSelective(Topic topic);
	
	//删除话题
	boolean deleteTopicById(String topicId);

}
