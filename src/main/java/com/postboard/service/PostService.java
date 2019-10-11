package com.postboard.service;

import java.util.List;

import com.postboard.pojo.Post;
import com.postboard.pojo.PostExample;

public interface PostService {
	//根据id查找帖子
	public Post getPostById(Long postId);
	//根据条件查找帖子(不包括内容)
	public List<Post> getPostListByExample(PostExample example);
	//根据条件查找帖子(包括内容)
	public List<Post> getPostListByExampleWithBLOBs(PostExample example);
	//添加帖子
	public boolean addPost(Post post);
	//根据帖子Id修改
	public boolean updatePostByIdSelective(Post post);
	//更新帖子
	public boolean updatePostSelective(Post post);
	//删除帖子
	public boolean deletePost(Long postId);
}
