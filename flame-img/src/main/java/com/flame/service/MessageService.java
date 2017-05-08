package com.flame.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.flame.dao.MessageMapper;
import com.flame.dao.UserMessageMapper;
import com.flame.model.Message;
import com.flame.model.UserMessage;
import com.github.pagehelper.StringUtil;

@Service
public class MessageService {

	@Autowired
	MessageMapper messageMapper;

	@Autowired
	UserMessageMapper userMessageMapper;

	// 发布
	public Integer add(String title, String content, Integer userId, String userName) {
		Message message = new Message();
		message.setTitle(title);
		message.setContent(content);
		message.setUserId(userId);
		message.setUserName(userName);
		message.setPublishTime(new Date());
		messageMapper.insert(message);
		updateUserMessage(message.getId(), message.getUserIds());
		return message.getId();

	}

	// 发布
	public Integer add(Message message) {
		message.setPublishTime(new Date());
		updateUserMessage(message.getId(), message.getUserIds());
		return messageMapper.insert(message);
	}

	// 更新
	public Integer update(Message message) {
		message.setPublishTime(new Date());
		updateUserMessage(message.getId(), message.getUserIds());
		return messageMapper.updateByPrimaryKeySelective(message);
	}

	// 删除
	public void delete(Integer messageId) {
		messageMapper.deleteByPrimaryKey(messageId);
		userMessageMapper.deleteByMessageId(messageId);
	}

	// 发布给用户
	public void updateUserMessage(Integer messageId, String userIds) {
		if (StringUtil.isNotEmpty(userIds)) {
			userMessageMapper.deleteByMessageId(messageId);
			
			String[] strIds =new String[]{};
			if(userIds.contains(",")){
				strIds =userIds.split(",");
			}else{
				strIds =new String[]{userIds};
			}
			
			for (String id : strIds) {
				UserMessage um = new UserMessage();
				um.setUserId(Integer.valueOf(id));
				um.setMessageId(messageId);
				userMessageMapper.insert(um);
			}

		}
	}
	
	//列表
	public List<Message> list(Integer userId){
		return messageMapper.selectByUserId(userId);
	}
	//获取用户列表
	public List<Map<String, Object>> userCheckList(Integer messageId){
		return messageMapper.selectUserCheckByMessageId(messageId);
	}
	

}
