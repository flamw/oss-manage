package com.flame.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.flame.dao.CommentMapper;
import com.flame.model.Comment;

@Service
public class CommentService {

	@Autowired
	CommentMapper commentMapper;
	
	public void save(String content,Integer userId,String userName,Integer fileId){
		Comment comment=new Comment();
		comment.setContent(content);
		comment.setUserId(userId);
		comment.setUserName(userName);
		comment.setFileId(fileId);
		comment.setCtime(new Date());;
		commentMapper.insert(comment);
	}
	
	public List<Comment> list(Integer fileId){
		return commentMapper.selectByFileId(fileId);
	}
}
