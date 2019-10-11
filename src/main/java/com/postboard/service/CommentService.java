package com.postboard.service;

import java.util.List;

import com.postboard.pojo.Comment;
import com.postboard.pojo.CommentExample;

public interface CommentService {
	//获取评论列表
	public List<Comment> getCommentList(Long postId);
	//添加评论
	public boolean addCommentSelective(Comment comment);
	//获取评论数量
	public int getCommentCountByExample(CommentExample example);
	//删除评论
	public boolean deleteCommentByExample(CommentExample example);
}
