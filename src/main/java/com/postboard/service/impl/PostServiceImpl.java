package com.postboard.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.postboard.mapper.PostMapper;
import com.postboard.pojo.CommentExample;
import com.postboard.pojo.CommentExample.Criteria;
import com.postboard.pojo.Post;
import com.postboard.pojo.PostExample;
import com.postboard.service.CommentService;
import com.postboard.service.PostService;

@Service
public class PostServiceImpl implements PostService {
	@Autowired
	private PostMapper postMapper;
	@Autowired
	private CommentService commentService;

	//添加帖子
	public boolean addPost(Post post){
		post.setId(null);
		post.setUpdatetime(null);
		post.setCreatetime(new Date());
		int rows = postMapper.insertSelective(post);
		return rows>0 ? true : false;
	}
	//通过id查找帖子
	@Override
	public Post getPostById(Long postId) {
		
		return postMapper.selectByPrimaryKey(postId);
	}
	//根据条件查找帖子(不包括内容)
	@Override
	public List<Post> getPostListByExample(PostExample example) {
		List<Post> postList = postMapper.selectByExample(example);
		return postList;
	}
	//根据条件查找帖子(包括内容)
	@Override
	public List<Post> getPostListByExampleWithBLOBs(PostExample example) {
		List<Post> postList = postMapper.selectByExampleWithBLOBs(example);
		return postList;
	}
	//更新帖子
	@Override
	public boolean updatePostSelective(Post post) {
		int rows = postMapper.updateByPrimaryKeySelective(post);
		return rows>0 ? true : false;
	}
	//删除帖子
	@Override
	public boolean deletePost(Long postId) {
		int rows1 = postMapper.deleteByPrimaryKey(postId);
		boolean b1 = rows1>0 ? true : false;
		CommentExample example = new CommentExample();
		Criteria criteria = example.createCriteria();
		criteria.andPostidEqualTo(postId);
		int commentCount = commentService.getCommentCountByExample(example);
		if(commentCount==0){
			return b1;
		}
		boolean b2=commentService.deleteCommentByExample(example);
		return b1&&b2;
	}
	//根据帖子Id修改
	@Override
	public boolean updatePostByIdSelective(Post post) {
		int rows = postMapper.updateByPrimaryKeySelective(post);
		return rows>0 ? true : false;
	}
	
}
