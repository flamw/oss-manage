package com.flame.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.flame.constant.Constant;
import com.flame.model.Message;
import com.flame.model.ResponseBean;
import com.flame.model.User;
import com.flame.service.MessageService;
import com.flame.service.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
@RequestMapping("/message/")
public class MessageController {

	@Autowired
	MessageService messageService;
	@Autowired
	UserService userService;

	@RequestMapping("/save")
	public @ResponseBody String save(Message message, HttpServletRequest request) {

		User user=userService.getLoginUser(request);
		message.setUserId(user.getUserId());
		message.setUserName(user.getUserName());
		if (message.getId() == null||message.getId()==0) {
			messageService.add(message);
		} else {
			messageService.update(message);
		}

		return Constant.SUCCESS_CODE;
	}

	@RequestMapping("/delete")
	public @ResponseBody String delete(Integer messageId) {
		messageService.delete(messageId);
		return Constant.SUCCESS_CODE;
	}

	@RequestMapping("/list")
	public @ResponseBody ResponseBean list(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(name = "pageSize", defaultValue = "10") int pageSize, HttpServletRequest request) {

		ResponseBean rb = new ResponseBean();
		PageHelper.orderBy("publish_time desc");

		PageHelper.startPage(page, pageSize);
		Integer userId = userService.getLoginUserId(request);
		List<Message> list = messageService.list(userId);
		PageInfo<Message> pageInfo = new PageInfo<Message>(list);
		Map<String, Object> returnMap = new HashMap<String, Object>();

		returnMap.put("pages", pageInfo.getPages());
		returnMap.put("total", pageInfo.getTotal());
		returnMap.put("datas", list);
		returnMap.put("pageSize", pageInfo.getPageSize());
		returnMap.put("size", pageInfo.getSize());
		rb.setResults(returnMap);
		return rb;
	}
	
	@RequestMapping("/userCheckList")
	public @ResponseBody List<Map<String, Object>> userCheckList(@RequestParam(value = "messageId", defaultValue ="0") Integer messageId) {
		return messageService.userCheckList(messageId);
	}

}
