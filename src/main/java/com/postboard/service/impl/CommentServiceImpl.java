package com.postboard.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.postboard.mapper.CommentMapper;
import com.postboard.pojo.Comment;
import com.postboard.pojo.CommentExample;
import com.postboard.pojo.CommentExample.Criteria;
import com.postboard.service.CommentService;

@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
	private CommentMapper commentMapper;
	//获取评论列表
	@Override
	public List<Comment> getCommentList(Long postId) {
		CommentExample example = new CommentExample();
		Criteria criteria = example.createCriteria();
		criteria.andPostidEqualTo(postId);
		example.setOrderByClause("createtime desc");
		List<Comment> commentList = commentMapper.selectByExample(example);
		return commentList;
	}
	
	//添加评论
	@Override
	public boolean addCommentSelective(Comment comment) {
		comment.setId(null);
		comment.setCreatetime(null);
		int rows = commentMapper.insertSelective(comment);
		return rows>0 ? true : false;
	}
	
	//获取评论数量
	@Override
	public int getCommentCountByExample(CommentExample example){
		int count = commentMapper.countByExample(example);
		return count;
	}
	//删除评论
	@Override
	public boolean deleteCommentByExample(CommentExample example) {
		int rows = commentMapper.deleteByExample(example);
		return rows>0 ? true : false;
	}

}
