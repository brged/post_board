package com.postboard.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.postboard.mapper.TopicMapper;
import com.postboard.pojo.Topic;
import com.postboard.pojo.TopicExample;
import com.postboard.service.TopicService;

@Service
public class TopicServiceImpl implements TopicService {

	@Autowired
	private TopicMapper topicMapper;
	
	//通过id获取话题
	@Override
	public Topic getTopicById(String topicId) {
		
		return topicMapper.selectByPrimaryKey(topicId);
	}
	
	//通过条件获取话题
	@Override
	public List<Topic> getTopicListByExample(TopicExample example) {
		List<Topic> topicList = topicMapper.selectByExample(example);
		return topicList;
	}

	//添加话题
	@Override
	public boolean addTopic(Topic topic) {
		int rows = topicMapper.insert(topic);
		return rows>0 ? true :false;
	}

	//更新话题
	@Override
	public boolean updateTopicSelective(Topic topic) {
		int rows = topicMapper.updateByPrimaryKeySelective(topic);
		return rows>0 ? true :false;
	}
	
	//删除话题
	@Override
	public boolean deleteTopicById(String topicId) {
		int rows = topicMapper.deleteByPrimaryKey(topicId);
		return rows>0 ? true :false;
	}

	//通过ID更新话题
	@Override
	public boolean updateTopicByIdSelective(Topic topic) {
		int rows = topicMapper.updateByPrimaryKeySelective(topic);
		return rows>0 ? true :false;
	}
	

}
